const prompts =  require("../utils/prompts")
const { isValidCareerSuggestionJSON, isValidSubjectSuggestionJSON, validateOpportunityJSON, validateEventsJSON, validateRoadmapJson } =  require("../utils/misc")
const path=require('path');
const axios = require('axios');
const { StatusCodes } = require('http-status-codes');
const { User, CareerSubject, CareerContent, SuggestedCareer, Roadmap, Opportunity, Event, Link, UserResumeDetail, Streak, Progress, Schedule, SuggestedCertification, SuggestedProject } = require(path.join(__dirname,'..','models'));
const { sendSlackBugReportMessage } = require("../utils/slack")
const Sequelize = require('sequelize');
const { getUdemyCoursesByKeywords, getFreeAndCouponCourses } = require('../services/udemyService');
const { getYoutubeCoursesByKeywords, searchEdxCoursesByKeyword } = require('../services/search');
const { serialize } = require("v8");
const { geminiService, hearFromGemini } = require('../services/gemini')
const { multipleSearch, multipleOpportunitiesSearch, multipleEventsSearch } = require('../services/search')
// const { getEdxCoursesByKeywords } = require('../services/edx')
const { EQ } = require('../utils/prompts')
const { cleanDynamicJsonString, cleanDynamicArrayString } = require('../utils/misc');

const getCareerSuggestions = async (req, res) => {
  const user = (await User.findOne({where:{id: req.params.id}})).dataValues;

    try {
      const response = await SuggestedCareer.findAll({
        where:{
          userId: req.params.id,
          isActive: false,
          // updatedAt: {
          //   [Sequelize.Op.gte]: new Date(new Date() - (1 * 24 * 60 * 60 * 1000 * 7)) // past 24 hours
          // }
        },  
        include:{model: Roadmap, as: 'roadmap',
        include: [
          {model: SuggestedCertification, as: 'suggestedcertifications',},
          {model: SuggestedProject, as: 'suggestedprojects',},
          {model: CareerSubject, as: 'careersubjects',
        include: [{model: CareerContent, as: 'careercontents',},],},],},
        // order: [
        //   [{ model: Roadmap, as: 'roadmap' }, { model: CareerSubject, as: 'careersubjects' }, { model: CareerContent, as: 'careercontents' }, 'price', 'ASC']
        // ]
      });
      
      if(response?.length)
      {
        console.log("recent suggestion found");
        return res.status(StatusCodes.OK).json({message: `suggestions generated`, careersToChooseFrom: response, user: user});
      }
    } catch (error) {
      sendSlackBugReportMessage(`Error from Fotisia backend - ⚡🔴🚫 \n\nReason - ${error}`)
      console.log(error);
    }

    // TODO: if careersToChooseFrom return []? error happened somewhere return error
    const careersToChooseFrom = await getSuggestionsForUsersSwitchingCareer(user);
    return res.status(StatusCodes.OK).json({message: `suggestions generated`, careersToChooseFrom: careersToChooseFrom, user: user});
  }

  const getJobs = async (req, res) =>
  {
    try {
      const userCareer = await UserResumeDetail.findOne({where:{userId: req.params.id}});
      const userCareerData = JSON.stringify(userCareer.dataValues);

      if(!userCareerData)
      return res.status(StatusCodes.NOT_FOUND).json({message: `User career details not found`});

      // Ask gemini for keywords suggestions (Save this to db)
      const keywords = await geminiService(`Here is my career info in json: ${userCareerData}. \n\n Suggest 2 job positions I am qualified for. Without explanation return only the 2 job positions.`);

      // search google for jobs links
      const query = encodeURIComponent(keywords); // Default query if none is provided
      const dateRestrict = 'd5';
      const searchUrl = `https://www.googleapis.com/customsearch/v1?key=${process.env.GOOGLE_SEARCH_API_KEY}&cx=${process.env.GOOGLE_JOB_SEARCH_ENGINE_ID}&q=${query}+job&dateRestrict=${dateRestrict}&sort=date`;

      const response = (await axios.get(searchUrl)).data;
      
      // return job links with ranking and job details
      return res.status(StatusCodes.OK).json({message: `jobs found`, jobs: response.items ?? []});
    } catch (error) {
      console.log(error);
      return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `Failed fetching jobs: ${error}`});
    }
  }

const getOpportunities  = async (req, res) => {
  try {
    const user = (await User.findOne({where:{id: req.params.id}})).dataValues;

    // Check if opportunities where generated recently
    const response = await Opportunity.findAll({where:{
      userId: req.params.id,
      updatedAt: {
        [Sequelize.Op.gte]: new Date(new Date() - (1 * 24 * 60 * 60 * 1000)) // past 24 hours
      }
    }, include: [{model: Link, as: 'links'}]},);
    
    if(response?.length)
    {
      console.log("recent opportunities found");
      return res.status(StatusCodes.OK).json({message: `Opportunities generated`, opportunities: response, user: user});
    }

    // delete old opportunities before getting new once.
    Opportunity.destroy(
      {where:{
        userId: req.params.id,
      }}
    )

    // else get new opportunities
    const suggestedOpportunities = JSON.parse(await getUserOpportunities(user));
    const opportunities = await searchForOpportunityLinks(suggestedOpportunities);
  
    for (let i = 0; i < opportunities.length; i++) 
    { 
      opportunities[i].userId = user.id;
      for (let j = 0; j < opportunities[i].links.length; j++) {
        opportunities[i].links[j].userId = user.id;
        opportunities[i].links[j].description = opportunities[i].links[j].snippet;
        opportunities[i].links[j].title = opportunities[i].links[j].title;
        opportunities[i].links[j].imageUrl = opportunities[i].links[j].imageUrl;
      }
    }
  
    await Opportunity.bulkCreate(opportunities, {
        include: [{model: Link, as: 'links'}]
    })
  
    return res.status(StatusCodes.OK).json({message: `Opportunities generated`, opportunities: opportunities, user: user}); 
  } catch (error) {
    console.log(error);
    return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `failed to create opportunities with reason: ${error}`});
  }
}

const generateRoadmapForGivenCareer  = async (req, res) => {
  try {
    const prompt = prompts.getCareerRoadmapPrompt(req.body.career)
    const response = await geminiService(prompt)
    const careerRoadmap = cleanDynamicJsonString(response);
    const user = (await User.findOne({where:{id: req.params.id}})).dataValues;

    console.log(careerRoadmap);
    for (let subjectIndex = 0; subjectIndex < careerRoadmap.subjects.length; subjectIndex++) {
      careerRoadmap.subjects[subjectIndex].subject = careerRoadmap.subjects[subjectIndex].option;
      careerRoadmap.subjects[subjectIndex].learningDuration = careerRoadmap.subjects[subjectIndex].learning_duration;
      careerRoadmap.subjects[subjectIndex].userId = user.id;
    }

    let career = {
      ...careerRoadmap,
    }

    career = {
      career: career.career_field,
      description: career.career_description,
      salary: career.salary_range,
      userId: user.id,
      standAlone: false,
      isActive: false,
      roadmap: {
        userId: user.id,
        description: career.roadmap,
        careersubjects: career.subjects,
        suggestedcertifications: career.certifications,
        suggestedprojects: career.projects,
      },
    }

    // Fetch Udemy, Edx and Coursera contents
    // (search udemy/edx and add result)
    for (let index = 0; index < career.roadmap.careersubjects.length; index++) {
      try{
        const subject = career.roadmap.careersubjects[index];

        const udemyLinks = await getUdemyCoursesByKeywords(subject.subject, user);
        // const edxLink = await getEdxCoursesByKeywords(subject.subject, user, career.career);
        const edxLink = await searchEdxCoursesByKeyword(subject.search_query, user);

        career.roadmap.careersubjects[index].careercontents = interleaveArrays(edxLink, udemyLinks);
      } catch(e){
        console.log("error getting courses", e);
      }
    }
    

    const savedSuggestedCareer = await SuggestedCareer.create(career, {
      include: {model: Roadmap, as: 'roadmap',
      include: [
          {model: SuggestedCertification, as: 'suggestedcertifications',},
          {model: SuggestedProject, as: 'suggestedprojects',},
          {model: CareerSubject, as: 'careersubjects',
        include: [{model: CareerContent, as: 'careercontents',},],},
      ],},
    });
    
    console.log(savedSuggestedCareer.dataValues);

    return res.status(StatusCodes.OK).json({message: `career roadmap generated`, careerRoadmap: savedSuggestedCareer.dataValues, user: user});
  } catch (error) {
    console.log(error);
    return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `failed to create roadmap with reason: ${error}`});
  }
}

const getEvents  = async (req, res) => {
  try {
    const user = (await User.findOne({where:{id: req.params.id}})).dataValues;
    // Check if events where generated recently
    const response = await Event.findAll({where:{
      userId: req.params.id,
      updatedAt: {
        [Sequelize.Op.gte]: new Date(new Date() - (1 * 24 * 60 * 60 * 1000)) // past 24 hours
      }
    }, include: [{model: Link, as: 'links'}]},);
    
    if(response?.length)
    {
      console.log("recent events found");
      return res.status(StatusCodes.OK).json({message: `Events generated`, events: response, user: user});
    }

    // delete old Events before getting new once.
    Event.destroy(
      {where:{
        userId: req.params.id,
      }}
    )
    
    // else get new Events
    const suggesteEvents = JSON.parse(await getUserEvents(user));
    console.log(suggesteEvents);
    
    const events = await searchForEventsLinks(suggesteEvents);
  
    for (let i = 0; i < events.length; i++) 
    { 
      events[i].userId = user.id;
      for (let j = 0; j < events[i].links.length; j++) {
        events[i].links[j].userId = user.id;
        events[i].links[j].description = events[i].links[j].snippet;
        events[i].links[j].title = events[i].links[j].title;
        events[i].links[j].imageUrl = events[i].links[j].imageUrl;
      }
    }
  
    await Event.bulkCreate(events, {
        include: [{model: Link, as: 'links'}]
    })
  
    return res.status(StatusCodes.OK).json({message: `Events generated`, events: events, user: user}); 
  } catch (error) {
    console.log(error);
    return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `failed to create events with reason: ${error}`});
  }
}



const getSingleRoadMap = async (req, res) => {
    const user = (await User.findOne({where:{id: req.params.id}})).dataValues;

    try {
      const response = await SuggestedCareer.findAll({
        where: {
          userId: req.params.id,
          isActive: true,
        },
        include: {
          model: Roadmap,
          as: 'roadmap',
          include: [
            {
              model: CareerSubject,
              as: 'careersubjects',
              include: [{
                model: CareerContent,
                as: 'careercontents',
              }],
            },
            {
              model: SuggestedCertification,
              as: 'suggestedcertifications',
            },
            {
              model: SuggestedProject,
              as: 'suggestedprojects',
            },
        ],
        },
        // order: [
        //   [{ model: Roadmap, as: 'roadmap' }, { model: CareerSubject, as: 'careersubjects' }, { model: CareerContent, as: 'careercontents' }, 'price', 'ASC'] // Sorting by price in ascending order
        // ]
      });
            
      if(response?.length)
      {
        console.log("recent roadmap suggestion found");
        return res.status(StatusCodes.OK).json({message: `suggestions roadmap`, careerRoadmap: response[0], user: user});
      }
    } catch (error) {
      sendSlackBugReportMessage(`Error from Fotisia backend - ⚡🔴🚫 \n\nReason - ${error}`)
      console.log(error);
    }

    let roadmap = null;
    // if(user.careerGoal != "switch to new field" ){
      // TODO: if roadmap return []? error happened somewhere return error
       roadmap = await generateCareerRoadmap(user);
    // }

    if(!roadmap || roadmap == []){
      return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `failed generating roadmap...`});
    }

    return res.status(StatusCodes.OK).json({message: `suggestions roadmap`, careerRoadmap: roadmap, user: user});
  }  

  

  function parsePrice(priceString) {
    // Remove currency symbol and comma
    const cleanedPrice = priceString.replace(/[^\d.-]/g, '');

    // Parse string to integer
    const parsedPrice = parseInt(cleanedPrice, 10);

    return parsedPrice;
}

  const generateCareerRoadmap = async (user) => {
    try {
      const careerRoadmap = JSON.parse(await getRoadmap(user));

      for (let subjectIndex = 0; subjectIndex < careerRoadmap.subjects.length; subjectIndex++) {
        careerRoadmap.subjects[subjectIndex].subject = careerRoadmap.subjects[subjectIndex].option;
        careerRoadmap.subjects[subjectIndex].learningDuration = careerRoadmap.subjects[subjectIndex].learning_duration;
        careerRoadmap.subjects[subjectIndex].userId = user.id;
      }

      for (let skillsId = 0; skillsId < careerRoadmap.soft_skills.length; skillsId++) {
        careerRoadmap.soft_skills[skillsId].subject = careerRoadmap.soft_skills[skillsId].name;
        careerRoadmap.soft_skills[skillsId].userId = user.id;
      }

      let career = {
        ...careerRoadmap,
      }

      career = {
        career: career.career_field,
        description: career.career_description,
        salary: career.salary_range,
        userId: user.id,
        standAlone: true,
        isActive: true,
        roadmap: {
          userId: user.id,
          description: career.roadmap,
          careersubjects: career.subjects,
          suggestedcertifications: career.certifications,
          suggestedprojects: career.projects,
        },
      }

      // Loop through courses and Fetch videos from Udemy, Edx and Coursera
      for (let index = 0; index < career.roadmap.careersubjects.length; index++) {
        try{
          const subject = career.roadmap.careersubjects[index];

          const udemyLinks = await getUdemyCoursesByKeywords(subject.subject, user);
          // const edxLink = await getEdxCoursesByKeywords(subject.subject, user, career.career);
          const edxLink = await searchEdxCoursesByKeyword(subject.search_query, user);

          career.roadmap.careersubjects[index].careercontents = interleaveArrays(edxLink, udemyLinks);
          
        } catch(e){
          console.log("error getting courses", e);
        }
      }

      // Loop through skills list and get videos for each skill from youtube
      for (let index = 0; index < careerRoadmap.soft_skills.length; index++) {
        try{
          const skill = careerRoadmap.soft_skills[index];
          const youtubeLinks = await getYoutubeCoursesByKeywords(skill, user);
          newSubject = {
            careercontents: youtubeLinks,
            subject: skill.subject,
            description: skill.description,
            learningDuration: "",
            userId: user.id,
            level: skill.level
          }

          career.roadmap.careersubjects.push(newSubject);
        } catch(e){
          console.log("error getting courses", e);
        }
      }      

      const savedSuggestedCareer = await SuggestedCareer.create(career, {
        include: {model: Roadmap, as: 'roadmap',
        include: [
          {model: SuggestedCertification, as: 'suggestedcertifications',},
          {model: SuggestedProject, as: 'suggestedprojects',},
          {model: CareerSubject, as: 'careersubjects',
        include: [{model: CareerContent, as: 'careercontents',},],},
      ],},
      });

      // try {
      //   getFreeAndCouponCourses(savedSuggestedCareer.dataValues.roadmap.careersubjects, user)
      // } catch (error) {
      //   console.log("Failed fetching coupons...");
      // }

      return savedSuggestedCareer.dataValues;

    } catch (error) {
      console.log(error);
      return []; //Todo return an error here
    }
  }

  /// IF USER WANT TO SWITCH TO A NEW CAREER
  const getSuggestionsForUsersSwitchingCareer = async (user) => {
    // Step 1: Get career suggestions for the user
    const suggestedCareers = JSON.parse(await getCareers(user));
    try {
      for (let suggestedCareerIndex = 0; suggestedCareerIndex < suggestedCareers.length; suggestedCareerIndex++) {
        for (let suggestedSubjectIndex = 0; suggestedSubjectIndex < suggestedCareers[suggestedCareerIndex].subjects.length; suggestedSubjectIndex++) {          
          suggestedCareers[suggestedCareerIndex].subjects[suggestedSubjectIndex].subject = suggestedCareers[suggestedCareerIndex].subjects[suggestedSubjectIndex].option;
          suggestedCareers[suggestedCareerIndex].subjects[suggestedSubjectIndex].learningDuration = suggestedCareers[suggestedCareerIndex].subjects[suggestedSubjectIndex].learning_duration;
          suggestedCareers[suggestedCareerIndex].subjects[suggestedSubjectIndex].userId = user.id;
        }

        for (let skillsId = 0; skillsId < suggestedCareers[suggestedCareerIndex].soft_skills.length; skillsId++) {
          suggestedCareers[suggestedCareerIndex].soft_skills[skillsId].subject = suggestedCareers[suggestedCareerIndex].soft_skills[skillsId].name;
          suggestedCareers[suggestedCareerIndex].soft_skills[skillsId].userId = user.id;
        }
      }

      // Fetch Udemy and coursera contents
      // (search udemy and add result)
      try{
        for (let index_1 = 0; index_1 < suggestedCareers.length; index_1++) {
          if(suggestedCareers[index_1].subjects.length){
            for (let index = 0; index < suggestedCareers[index_1].subjects.length; index++) {
              try{
                const subject = suggestedCareers[index_1].subjects[index];

                const udemyLinks = await getUdemyCoursesByKeywords(subject.subject, user);
                // const edxLink = await getEdxCoursesByKeywords(subject.subject, user, suggestedCareers[index_1].career_field);
                const edxLink = await searchEdxCoursesByKeyword(subject.search_query, user);

                suggestedCareers[index_1].subjects[index].careercontents = interleaveArrays(edxLink, udemyLinks);
              } catch (error){
                  console.log("error getting coupon courses", error)
              }
            }
          }

          if(suggestedCareers[index_1].soft_skills.length){
             // Loop through skills list and get videos for each skill from youtube
            for (let index = 0; index < suggestedCareers[index_1].soft_skills.length; index++) {
              try{
                const skill = suggestedCareers[index_1].soft_skills[index];
                const youtubeLinks = await getYoutubeCoursesByKeywords(skill, user);
                newSubject = {
                  careercontents: youtubeLinks,
                  subject: skill.subject,
                  description: skill.description,
                  learningDuration: "",
                  userId: user.id,
                  level: skill.level
                }

                suggestedCareers[index_1].subjects.push(newSubject);

              } catch(e){
                console.log("error getting courses", e);
              }
            }
          }
        }
      } catch (e){
        console.log(suggestedCareers);
        console.log(e)
      }
  
      // Step 3: Construct and insert records into the database      
      const careerRecords = suggestedCareers.map((career) => ({
        career: career.career_field,
        description: career.career_description,
        salary: career.salary_range,
        userId: user.id,
        roadmap: {
          userId: user.id,
          description: career.roadmap,
          careersubjects: career.subjects,
          suggestedcertifications: career.certifications,
          suggestedprojects: career.projects,
        },
      }));
  
      const allSuggestedCareer = await SuggestedCareer.bulkCreate(careerRecords, {
        include: {model: Roadmap, as: 'roadmap',
        include: [
          {model: SuggestedCertification, as: 'suggestedcertifications',},
          {model: SuggestedProject, as: 'suggestedprojects',},
          {model: CareerSubject, as: 'careersubjects',
        include: [{model: CareerContent, as: 'careercontents',},],},],},});
  
        let c = []
        for (let index = 0; index < allSuggestedCareer.length; index++) {
          const _career = allSuggestedCareer[index];
          c.push(_career.dataValues)
        }

        return c;
    } catch (error) {
      console.log(error);
      return [];//Todo return an error here
    }
  };

  function interleaveArrays(arr1, arr2) {
    let result = [];
    let maxLength = Math.max(arr1.length, arr2.length);
  
    for (let i = 0; i < maxLength; i++) {
      if (i < arr1.length) {
        result.push(arr1[i]);
      }
      if (i < arr2.length) {
        result.push(arr2[i]);
      }
    }
  
    return result;
  }

  const getRoadmap = async (user) => {
    const prompt = prompts.getRoadmapPrompt(user)
    const response = await geminiService(prompt)
    const jsonRoadmap = cleanDynamicJsonString(response);
   
    return JSON.stringify(jsonRoadmap);
  }


  const getCareers = async (user) => {
    const prompt = prompts.getCareersPrompt(user);
    const response = await geminiService(prompt)
    const jsonCareers = cleanDynamicArrayString(response);

    return JSON.stringify(jsonCareers);
  }

  const getUserOpportunities = async (user) =>
  {
    const prompt = prompts.getOpportunitiesPrompt(user); //randomly get either subjects or courses prompt
    const response = await geminiService(prompt)
    const opportunitiesJson = cleanDynamicArrayString(response);
    return JSON.stringify(opportunitiesJson);
  }

  const getUserEvents = async (user) =>
  {
    const prompt = prompts.getEventsPrompt(user); //randomly get either subjects or courses prompt
    const response = await geminiService(prompt)
    const eventsJson = cleanDynamicArrayString(response);
    return JSON.stringify(eventsJson);
  }

  const getSubjects = async (user) =>
  {
    const prompt = Math.random() > 0.5 ? prompts.getCoursesPrompt(user) : prompts.getSubjectsPrompt(user); //randomly get either subjects or courses prompt

    const response = await geminiService(prompt)
    const subjectsJson = cleanDynamicJsonString(response);

    return JSON.stringify(subjectsJson);
  }

async function searchForCareerContent(subjects){
    const response = await multipleSearch(subjects);
    return response;
  }

  async function searchForOpportunityLinks(opportunities){
    const response = await multipleOpportunitiesSearch(opportunities);
    return response;
  }

  async function searchForEventsLinks(events){
    const response = await multipleEventsSearch(events);
    return response;
  }


  function fixJsonString(inputString) {
    // Remove the backticks and 'json' tag
    const cleanedString = inputString.replace(/```json/g, '').replace(/```/g, '');
  
    try {
      // Parse the cleaned string to check if it's valid JSON
      JSON.parse(cleanedString);
      return cleanedString;
    } catch (error) {
      console.error('Invalid JSON string:', error);
      return null;
    }
  }

const activeCareer = async (req, res) => {
  try{
    const activeCareer = (await SuggestedCareer.findAll({where:{
        userId: req.params.id,
        isActive: true,
      },  include:{model: Roadmap, as: 'roadmap',
          include: [
            {model: SuggestedCertification, as: 'suggestedcertifications',},
            {model: SuggestedProject, as: 'suggestedprojects',},
            {model: CareerSubject, as: 'careersubjects',
          include: [{model: CareerContent, as: 'careercontents',},],},],}},))[0];

    if(!activeCareer){
      res.status(StatusCodes.NOT_FOUND).json("Active career not found")
    }

    res.status(StatusCodes.ACCEPTED).json(activeCareer.dataValues)
    } catch (e){
      console.log(e)
      res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("Error fretching active career")
    }

}

const performanceUpdate = async (req, res) => {
  try {
    // Get users resume data
    const userCareerData = req.body.user_data;
    const availableJobs = req.body.available_jobs;

    // find and return created streak and related entities
    const streak = await Streak.findOne({
      include:[
          {
              model: Progress, 
              as: 'progress',
          },
          {
              model: Schedule,
              as: 'schedule',
          },
      ],
      where: {
          userId: req.user.id
      }
  });

    if(!userCareerData)
    return res.status(StatusCodes.NOT_FOUND).json({message: `provide users information`});

    let prompt = ``
    prompt = `You are my voice-chat career assistant and you usually send routine career check-up voice messages. \n\nHere is my career info in json: ${userCareerData} streak: ${streak} available jobs that I can apply for: ${availableJobs}. \n\n send today's Check-up voice-note to me and advice me on specific actions I need to take today based on my data. key areas to talk about are (My running Streak remind me to take it). End your voice message motivating me to be deligent and encouraging me that I will succeed, (do not add a heading) Go straight to today's message.`;
    // prompt = ``

    // Ask gemini to send a vn
    const voiceNote = await hearFromGemini(prompt);

    // return job links with ranking and job details
    return res.status(StatusCodes.OK).json({message: `performance update voice note`, result: voiceNote});
  } catch (error) {
    console.log(error);
    return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `Failed fetching performance: ${error}`});
  }
}

  const careerSuggestion={
    getCareerSuggestions,
    getSingleRoadMap,
    getOpportunities,
    getEvents,
    activeCareer,
    getJobs,
    performanceUpdate,
    generateRoadmapForGivenCareer,
  };
  module.exports=careerSuggestion;
