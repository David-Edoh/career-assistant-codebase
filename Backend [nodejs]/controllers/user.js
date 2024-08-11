const path=require('path');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const { StatusCodes } = require('http-status-codes')
const {User, Relationship, UserResumeDetail, UserResumeExperience, UserResumeEducation}=require(path.join(__dirname,'..','models'));
const { uploadUserPictureToS3 } = require("../utils/aws")
const { geminiResumeEditor, geminiService } = require('../services/gemini');
const { cleanDynamicJsonString } = require('../utils/misc');
const prompts =  require("../utils/prompts")

const getUser = async (req,res) =>
{
    let user = await User.findOne({
        where:{
            id:req.params.id
        },
        attributes:{
            exclude:['password','socket_io_id', 'refreshToken']
        }
    });

    user.dataValues.hobbies = JSON.parse(user.dataValues.hobbies);

    if(req.state)
        user.dataValues.state=req.state;
    if(req.relationship)
        user.dataValues.relationship=req.relationship;
    res.status(StatusCodes.OK).json({status: "ok", message: "User data", user: {...user.dataValues, accessToken: user.dataValues.refreshToken }});
};

const getCurrentUser=async(req,res)=>
{
    let user = await User.findOne({
        where:{
            id:req.params.id
        },
        attributes:{
            exclude:['password']
        }
    });

    user.dataValues.hobbies = JSON.parse(user.dataValues.hobbies);

    if(req.state)
        user.dataValues.state=req.state;

    res.status(StatusCodes.OK).json({status: "ok", message: "Current user data", user: {...user.dataValues, accessToken: user.dataValues.refreshToken }});
};

const updateUser=async(req, res)=>
{
    try {
        let patchUpdate={};
        if(!req.body)
        return;
        
        const { id, email, picturePath,createdAt,updatedAt,refreshToken,socket_io_id, password, ...data } = req.body;
        patchUpdate=data;
        
        // if(req.file){
        //     patchUpdate.picturePath=req.file.filename;
        // }

        if(patchUpdate.userPicture?.length){
            const buffer = base64ToArrayBuffer(patchUpdate.userPicture);
            const thumbnail = new Buffer.from(buffer, 'binary');
            const key = `${req.body.firstName}_${req.body.lastName}_${id}_profile_pic.png`;
            const data = await uploadUserPictureToS3(thumbnail, key);
            patchUpdate.picturePath = `https://fotisia-user-pictures.s3.amazonaws.com/${key}`
        }

        // if(patchUpdate.password){
        //     const salt = await bcrypt.genSalt(10);
        //     patchUpdate.password = await bcrypt.hash(patchUpdate.password, salt);
        //     patchUpdate.refreshToken="reloginRequired";
        // }
        const result = await User.update(patchUpdate, {where: {id:req.params.id}});
        res.status(StatusCodes.OK).json({message:"updated successfully"});
    } catch (error) {
        console.log(error);
        return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `failed saving user's data: ${error}`});
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

const updateUserCareerDetails=async(req,res)=>
{
    let patchUpdate={};
    let userResumeData = {}
    if(req.body)
    {
        const { id,email,picturePath,createdAt, updatedAt,refreshToken,socket_io_id, password, uploadedResume, ...data } = req.body;
        patchUpdate=data;
        userResumeData = uploadedResume;
    }

    if(userResumeData){
        try{
            await saveResumeData(
                userResumeData,
                {
                    employmentStatus: patchUpdate.employmentStatus,
                    educationLevel: patchUpdate.educationLevel,
                    specialization: patchUpdate.specialization,
                    careerGoal: patchUpdate.careerGoal,
                    keyStrength: patchUpdate.keyStrength,
                },
                req.params.id);
        } catch(e) {
            console.log(e);
        }
    }

    patchUpdate.hobbies = JSON.stringify(patchUpdate.hobbies);
    
    const result = await User.update(patchUpdate, {where: {id:req.params.id}});
    const user=await User.findOne({
        where:{
            id:req.params.id
        },
        attributes:{
            exclude:['password','socket_io_id']
        }
    });

    let { refreshToken, ...userData } = user.dataValues;
    userData.accessToken = refreshToken;
    res.status(StatusCodes.OK).json({message:"updated successfully", user: userData});
};


const saveResumeData = async (uploadedResume, onboardingInfo, userId) => {
    const instruction = `you are a backend api, and this is my resume data: ${uploadedResume}. create a resume json from this data and return only the json resume string. In the experiences section, generate a list of job description for each job, focus on achievements, and use action verbs to highlight my responsibilities and accomplishments.`;
    const result = await geminiResumeEditor(instruction, []);
    let resumeObject = cleanDynamicJsonString(result);

    resumeObject.experiences.map((value, index, array) => {
        console.log(resumeObject.experiences[index]);
        try{
            delete resumeObject.experiences[index].id;
        } catch {}
        resumeObject.experiences[index].startDate = resumeObject.experiences[index].startDate ? ensureDayInDateString(resumeObject.experiences[index].startDate) : null
        resumeObject.experiences[index].endDate = resumeObject.experiences[index].endDate ? ensureDayInDateString(resumeObject.experiences[index].endDate) : null
    })
    resumeObject.educations.map((value, index, array) => {
        console.log(resumeObject.educations[index]);
        try{
            delete resumeObject.educations[index].id;
        } catch {}
        resumeObject.educations[index].startDate = resumeObject.educations[index].startDate ? ensureDayInDateString(resumeObject.educations[index].startDate) : null
        resumeObject.educations[index].endDate = resumeObject.educations[index].endDate ? ensureDayInDateString(resumeObject.educations[index].endDate) : null
    })
    resumeObject.projects.map((value, index, array) => {
        console.log(resumeObject.projects[index]);
        resumeObject.projects[index].startDate = resumeObject.projects[index].startDate ? ensureDayInDateString(resumeObject.projects[index].startDate) : null
        resumeObject.projects[index].endDate = resumeObject.projects[index].endDate ? ensureDayInDateString(resumeObject.projects[index].endDate) : null
    })
    resumeObject.trainings_courses_certifications.map((value, index, array) => {
        console.log(resumeObject.trainings_courses_certifications[index]);
        resumeObject.trainings_courses_certifications[index].startDate = resumeObject.trainings_courses_certifications[index].startDate ? ensureDayInDateString(resumeObject.trainings_courses_certifications[index].startDate) : null
        resumeObject.trainings_courses_certifications[index].endDate = resumeObject.trainings_courses_certifications[index].endDate ? ensureDayInDateString(resumeObject.trainings_courses_certifications[index].endDate) : null
    })

    console.log(resumeObject);

    let user = (await User.findOne({where:{id: userId}})).dataValues;
    user.cv = uploadedResume
    const aboutMe = await getAboutMe(user);

    resumeObject.about = aboutMe.professional_summary;
    resumeObject.userId = userId;
    resumeObject.employmentStatus = onboardingInfo.employmentStatus;
    resumeObject.educationLevel = onboardingInfo.educationLevel;
    resumeObject.specialization = onboardingInfo.specialization;
    resumeObject.careerGoal = onboardingInfo.careerGoal;
    resumeObject.keyStrength = onboardingInfo.keyStrength;

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

const getAboutMe = async (user) =>
{
  const prompt = prompts.getAboutMePrompt(user);
 
  const response = await geminiService(prompt)
  const aboutMeJson = cleanDynamicJsonString(response);

  return aboutMeJson;
}

const deleteUser=async(req,res)=>
{
    let userId=req.params.id;
    // delete posts 
    
    // delete comments
    
    // delete reactions 

    // delete groups posts inside comments reactions 

    // delete friends and messages

    // delete profile
    const result=await User.destroy({ where: { id: userId }});
    res.status(StatusCodes.OK).json({message:"account has been deleted"});
};

const userController = {
    getUser,
    getCurrentUser,
    updateUser,
    deleteUser,
    updateUserCareerDetails
};

module.exports=userController;