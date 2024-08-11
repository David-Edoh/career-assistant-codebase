const prompts =  require("../utils/prompts")
const { isValidCareerSuggestionJSON, isValidSubjectSuggestionJSON, validateOpportunityJSON } =  require("../utils/misc")
const path=require('path');
const axios = require('axios');
const { StatusCodes } = require('http-status-codes');
const { User, ResumeTemplate, UserResumeDetail, UserResumeExperience, UserResumeEducation } = require(path.join(__dirname,'..','models'));
const { sendSlackBugReportMessage } = require("../utils/slack")
const Sequelize = require('sequelize');
const nodeHtmlToImage = require('node-html-to-image')
const { uploadThumbnailToS3, uploadUserPictureToS3 } = require("../utils/aws")
const { geminiService, geminiResumeEditor } = require('../services/gemini')
const { cleanDynamicJsonString } = require('../utils/misc')


const getTemplates  = async (req, res) => {
    try {
      let templates = await ResumeTemplate.findAll();
      
      for (let index = 0; index < templates.length; index++) {
        let template = templates[index];
        
        if(!template.thumbnail)
        {
          console.log(template.id);
          const bufferImage = await nodeHtmlToImage({ html: template.sampleHTML });
          const thumbnail = new Buffer.from(bufferImage, 'binary');
          const data = await uploadThumbnailToS3(thumbnail, "thumbnail_"+template.id+".png");
          
          template.thumbnail = "https://resume-template-thumbnails.s3.amazonaws.com/thumbnail_"+template.id+".png"
          await ResumeTemplate.update({thumbnail: template.thumbnail}, {where: {id: template.id}});
        }
      }
    
      return res.status(StatusCodes.OK).json({message: `resume templates`, templates: templates}); 
    } catch (error) {
      console.log(error);
      return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `failed to retrieve resume templates: ${error}`});
    }
  }

  const getUserResumeDetails = async (req, res) => {
    try {
      const userResumeDetail = (await UserResumeDetail.findOne({where:{userId: req.params.id}, include: [
        { model: UserResumeExperience, as: 'experiences' },
        { model: UserResumeEducation, as: 'educations' },
      ]}))?.dataValues;

      if(userResumeDetail)
      {
        userResumeDetail.skills = JSON.parse(userResumeDetail.skills);
        userResumeDetail.projects = JSON.parse(userResumeDetail.projects);
        userResumeDetail.references = JSON.parse(userResumeDetail.references);
        userResumeDetail.socials = JSON.parse(userResumeDetail.socials);
        userResumeDetail.trainings_courses_certifications = JSON.parse(userResumeDetail.trainings_courses_certifications);

        return res.status(StatusCodes.OK).json({message: `user resume details`, userResumeDetails: userResumeDetail}); 
      }

      const user = (await User.findOne({where:{id: req.params.id}})).dataValues;
      const { id, picturePath, refreshToken, socket_io_id, password, ...userData } = user;

      // Generate an about me using AI for the user.
      let aboutMe = await getAboutMe(user);
      aboutMe = JSON.parse(aboutMe);

      // Save details to resumedetailstable.
      await UserResumeDetail.create({id: 0, about: aboutMe.professional_summary, experiences: [], educations: [], userId: id, ...userData}, 
        {include: [
          { model: UserResumeExperience, as: 'experiences' },
          { model: UserResumeEducation, as: 'educations' },
        ],})

      return res.status(StatusCodes.OK).json({message: `user resume details`, userResumeDetails: {about: aboutMe.professional_summary, experiences: [], educations: [], skills: [], ...userData}}); 
    } catch (error) {
      console.log(error);
      return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `failed to retrieve resume templates: ${error}`});
    }
  }

  const modifyResumeForJob = async (req, res) =>
  {
    try {
      console.log(req.body.prompt)
      const prompt = req.body.prompt;
      const chatHistory = req.body.chat_history;

      const updatedResume = await geminiResumeEditor(prompt, chatHistory);
      console.log(updatedResume);

      // return job links with ranking and job details
      return res.status(StatusCodes.OK).json({message: `Updated resume`, result: cleanDynamicJsonString(updatedResume)});
    } catch (error) {
      console.log(error);
      return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `Failed updating resume: ${error}`});
    }
  }


  const jobResumeMatch = async (req, res) =>
  {
    try {
      // Get users resume data
      const userCareerData = JSON.stringify((await UserResumeDetail.findOne({where:{userId: req.params.id}})).dataValues);
      const jobAd = req.body.job_ad

      if(!userCareerData)
      return res.status(StatusCodes.NOT_FOUND).json({message: `User career details not found`});

      // Ask gemini for keywords suggestions (Save this to db)
      const qualificationRating = await geminiService(`You are a backend api. \n\nHere is my career info in json: ${userCareerData}. \n\n This is a job ad: ${jobAd}. Give a rating of how I qualify for the job in percentage. without any explanation, return only a json of score, jobTitle, jobCompany and an explanation of why you gave the score in the json e.g: {"score": 50, "explanation": "Why did you give this score...", "jobTitle": "title of the job position", "jobCompany": "job company"}`);
      console.log(qualificationRating);

      // return job links with ranking and job details
      return res.status(StatusCodes.OK).json({message: `Qualification Score`, result: cleanDynamicJsonString(qualificationRating)});
    } catch (error) {
      console.log(error);
      return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `Failed fetching score: ${error}`});
    }
  }

  const uploadResumeData = async (req, res) =>
  {
    try {
      const userResumeData = req.body.userResumeData;
      
      await UserResumeDetail.destroy({where:{ userId: req.params.id}}); 
      await saveNewResumeData(
        userResumeData,
        req.params.id
      );

      const userResumeDetail = (await UserResumeDetail.findOne({where:{userId: req.params.id}, include: [
        { model: UserResumeExperience, as: 'experiences' },
        { model: UserResumeEducation, as: 'educations' },
      ]}))?.dataValues;


      userResumeDetail.skills = JSON.parse(userResumeDetail.skills);
      userResumeDetail.projects = JSON.parse(userResumeDetail.projects);
      userResumeDetail.references = JSON.parse(userResumeDetail.references);
      userResumeDetail.socials = JSON.parse(userResumeDetail.socials);
      userResumeDetail.trainings_courses_certifications = JSON.parse(userResumeDetail.trainings_courses_certifications);

      return res.status(StatusCodes.OK).json({message: `user resume details`, userResumeDetails: userResumeDetail}); 
      
    } catch (error) {
      console.log(error);
      return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `Failed uploading data: ${error}`});
    }
  }

  
function ensureDayInDateString(dateString) {
  // Check if the date string contains a day part by counting the number of slashes
  const parts = dateString.split('/');

  if (parts.length === 2) {
      // If the day is missing (only month and year are present), add '01' as the day
      return `01/${dateString}`;
  } else if (parts.length === 3) {
      // If the date string already contains a day, return it as is
      return dateString;
  } else {
      // If the date string is not in a valid format, return an error message or handle it as needed
      throw new Error('Invalid date format');
  }
}

const saveNewResumeData = async (uploadedResume, userId) => {
  const instruction = `you are a backend api, and this is my resume data: ${uploadedResume}. create a resume json from this data and return only the json resume string. In the experiences section, generate a list of job description for each job, focus on achievements, and use action verbs to highlight my responsibilities and accomplishments.`;
  const result = await geminiResumeEditor(instruction, []);
  let resumeObject = cleanDynamicJsonString(result);

  resumeObject.experiences.map((value, index, array) => {
      try{
          delete resumeObject.experiences[index].id;
      } catch {}
      resumeObject.experiences[index].startDate = resumeObject.experiences[index].startDate ? ensureDayInDateString(resumeObject.experiences[index].startDate) : null
      resumeObject.experiences[index].endDate = resumeObject.experiences[index].endDate ? ensureDayInDateString(resumeObject.experiences[index].endDate) : null
  })
  resumeObject.educations.map((value, index, array) => {
      try{
          delete resumeObject.educations[index].id;
      } catch {}
      resumeObject.educations[index].startDate = resumeObject.educations[index].startDate ? ensureDayInDateString(resumeObject.educations[index].startDate) : null
      resumeObject.educations[index].endDate = resumeObject.educations[index].endDate ? ensureDayInDateString(resumeObject.educations[index].endDate) : null
  })
  resumeObject.projects.map((value, index, array) => {
      resumeObject.projects[index].startDate = resumeObject.projects[index].startDate ? ensureDayInDateString(resumeObject.projects[index].startDate) : null
      resumeObject.projects[index].endDate = resumeObject.projects[index].endDate ? ensureDayInDateString(resumeObject.projects[index].endDate) : null
  })
  resumeObject.trainings_courses_certifications.map((value, index, array) => {
      resumeObject.trainings_courses_certifications[index].startDate = resumeObject.trainings_courses_certifications[index].startDate ? ensureDayInDateString(resumeObject.trainings_courses_certifications[index].startDate) : null
      resumeObject.trainings_courses_certifications[index].endDate = resumeObject.trainings_courses_certifications[index].endDate ? ensureDayInDateString(resumeObject.trainings_courses_certifications[index].endDate) : null
  })

  console.log(resumeObject);
  let aboutMe = await getAboutMe(resumeObject);

  resumeObject.userId = userId;
  resumeObject.about = JSON.parse(aboutMe).professional_summary;
  resumeObject.skills = JSON.stringify(resumeObject.skills);
  resumeObject.projects = JSON.stringify(resumeObject.projects);
  resumeObject.references = JSON.stringify(resumeObject.references);
  resumeObject.socials = JSON.stringify(resumeObject.socials);
  resumeObject.trainings_courses_certifications = JSON.stringify(resumeObject.trainings_courses_certifications);
  
  await UserResumeDetail.create(
    resumeObject,
    {include: [
        { model: UserResumeExperience, as: 'experiences' },
        { model: UserResumeEducation, as: 'educations' },
    ],});
}



  const getAboutMe = async (user) =>
  {
    const prompt = prompts.getAboutMePrompt(user);
   
    const response = await geminiService(prompt)
    const aboutMeJson = cleanDynamicJsonString(response);

    return JSON.stringify(aboutMeJson);
  }

  // const setId = (arrayObject) => {
  //   [].map((value, index, array) => {
  //     arrayObject[index].id = index;
  //   })
  // }

  const updateUserResumeDetails = async (req, res) => {
    let {id, createdAt, updatedAt, ...cvDate} = req.body;

    try {
      if(cvDate.userPicture?.length)
      {
        const buffer = base64ToArrayBuffer(cvDate.userPicture);
        const thumbnail = new Buffer.from(buffer, 'binary');
        const key = `${req.body.firstName}_${req.body.lastName}_${id}_professional_pic.png`;
        const data = await uploadUserPictureToS3(thumbnail, key);
        cvDate.picturePath = `https://fotisia-user-pictures.s3.amazonaws.com/${key}`
      }

      cvDate.skills = JSON.stringify(cvDate.skills);
      cvDate.projects = JSON.stringify(cvDate.projects);
      cvDate.references = JSON.stringify(cvDate.references);
      cvDate.socials = JSON.stringify(cvDate.socials);
      cvDate.hobbies = JSON.stringify(cvDate.hobbies);
      cvDate.trainings_courses_certifications = JSON.stringify(cvDate.trainings_courses_certifications);
      
      const result = await UserResumeDetail.update(cvDate, {
        where: { userId: req.params.id }
      });
  
      const resumeDetail = await UserResumeDetail.findOne({
        where: {
          userId: req.params.id,
        },
        include: [
          { model: UserResumeExperience, as: 'experiences' },
          { model: UserResumeEducation, as: 'educations' },
        ],
      });
  
      res.status(StatusCodes.OK).json({
        message: "Updated successfully",
        userResumeDetail: resumeDetail,
      });
    } catch (error) {
      console.error(error);
      res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
        message: "Error updating user resume details",
        error: error.message,
      });
    }
  };

  function base64ToArrayBuffer(base64) {
    var binaryString = atob(base64);
    var bytes = new Uint8Array(binaryString.length);
    for (var i = 0; i < binaryString.length; i++) {
        bytes[i] = binaryString.charCodeAt(i);
    }
    return bytes.buffer;
}

  const createUserResumeExperienceDetails = async (req, res) => {  
    console.log(req.body)
    try {
      const userResumeDetail = (await UserResumeDetail.findOne({where:{userId: req.params.id}}))?.dataValues;

      const result = await UserResumeExperience.create({userResumeDetailId: userResumeDetail.id, ...req.body});
  
      res.status(StatusCodes.OK).json({
        message: "Created successfully",
        userResumeExperience: req.body,
      });
      
    } catch (error) {
      console.error(error);
      res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
        message: "Error creating user resume experience details",
        error: error.message,
      });
    }
  };

  const updateUserResumeExperienceDetails = async (req, res) => {  
    try {
      const {id, createdAt, updatedAt, ...cvDate} = req.body;

      const result = await UserResumeExperience.update(cvDate, {
        where: { id: req.params.experienceId, }
      });
  
      const resumeDetailExperience = await UserResumeExperience.findOne({
        where: {
          id: req.params.experienceId,
        },
      });
  
      res.status(StatusCodes.OK).json({
        message: "Updated successfully",
        userResumeExperience: resumeDetailExperience,
      });
    } catch (error) {
      console.error(error);
      res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
        message: "Error updating user resume experience details",
        error: error.message,
      });
    }
  };

  const deleteResumeItem = async (req, res) => {  
    try {
      if(req.body.itemType == "Experience")
      {
        await UserResumeExperience.destroy({
          where: {id: req.body.itemId}
        });
      }

      if(req.body.itemType == "Education")
      {
        await UserResumeEducation.destroy({
          where: {id: req.body.itemId}
        });
      }

      res.status(StatusCodes.OK).json({
        message: "Item deleted",
        item: req.body,
      });
      
    } catch (error) {
      console.error(error);
      res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
        message: "Error updating user resume experience details",
        error: error.message,
      });
    }
  };

  
  const createUserResumeEducationDetails = async (req, res) => {  
    try {
      const userResumeDetail = (await UserResumeDetail.findOne({where:{userId: req.params.id}}))?.dataValues;

      const result = await UserResumeEducation.create({userResumeDetailId: userResumeDetail.id, ...req.body});
  
      res.status(StatusCodes.OK).json({
        message: "Created successfully",
        userResumeEducation: req.body,
      });
      
    } catch (error) {
      console.error(error);
      res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
        message: "Error creating user resume education details",
        error: error.message,
      });
    }
  };

  const updateUserResumeEducationDetails = async (req, res) => {  
    try {
      const {id, createdAt, updatedAt, ...cvDate} = req.body;

      const result = await UserResumeEducation.update(cvDate, {
        where: { id: req.params.educationId, }
      });
  
      const resumeDetailEducation = await UserResumeEducation.findOne({
        where: {
          id: req.params.educationId,
        },
      });
  
      res.status(StatusCodes.OK).json({
        message: "Updated successfully",
        userResumeEducation: resumeDetailEducation,
      });
    } catch (error) {
      console.error(error);
      res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
        message: "Error updating user resume education details",
        error: error.message,
      });
    }
  };
  

  const resumeManager = {
    getTemplates,
    getUserResumeDetails,
    updateUserResumeDetails,
    createUserResumeExperienceDetails,
    updateUserResumeExperienceDetails,
    createUserResumeEducationDetails,
    updateUserResumeEducationDetails,
    deleteResumeItem,
    jobResumeMatch,
    modifyResumeForJob,
    uploadResumeData,
  };

  module.exports=resumeManager;