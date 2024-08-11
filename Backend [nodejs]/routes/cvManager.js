const path=require('path');
const express=require('express');
const router=express.Router();
const { resumeManager }=require(path.join(__dirname,'..','controllers'));
const {userValidation}=require(path.join(__dirname,'..','middlewares','validation'));
const {userAuth}=require(path.join(__dirname,'..','middlewares','authorization'));

router.get('/',
    resumeManager.getTemplates
);

router.get('/user/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    resumeManager.getUserResumeDetails
);

router.post('/job-match-score/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    resumeManager.jobResumeMatch
);

router.post('/update-resume-for-job/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    resumeManager.modifyResumeForJob
);

router.post('/upload-resume/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    resumeManager.uploadResumeData
);

router.post('/user/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    resumeManager.updateUserResumeDetails
);

router.post('/user/create_education/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    resumeManager.createUserResumeEducationDetails
);

router.post('/user/create_experience/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    resumeManager.createUserResumeExperienceDetails
);

router.post('/user/update_education/:id/:educationId',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    resumeManager.updateUserResumeEducationDetails,
);

router.post('/user/update_experience/:id/:experienceId',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    resumeManager.updateUserResumeExperienceDetails
);

router.post('/user/:id/delete_resume_detail_item',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    resumeManager.deleteResumeItem 
);
module.exports = router;