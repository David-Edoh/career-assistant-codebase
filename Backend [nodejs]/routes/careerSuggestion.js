const path=require('path');
const express=require('express');
const router=express.Router();
const {careerSuggestion}=require(path.join(__dirname,'..','controllers'));
const {userValidation}=require(path.join(__dirname,'..','middlewares','validation'));
const {userAuth}=require(path.join(__dirname,'..','middlewares','authorization'));


router.get('/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    careerSuggestion.getCareerSuggestions
);

router.get('/roadmap/:id', 
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    careerSuggestion.getSingleRoadMap,
)


router.get('/jobs/:id', 
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    careerSuggestion.getJobs,
)

router.get('/opportunities/:id', 
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    careerSuggestion.getOpportunities,
)

router.get('/events/:id', 
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    careerSuggestion.getEvents,
)

router.get('/active-career/:id', 
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    careerSuggestion.activeCareer,
)

router.post('/get-performance-update/:id', 
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    careerSuggestion.performanceUpdate,
)

router.post('/generate-roadmap/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    careerSuggestion.generateRoadmapForGivenCareer,
)

module.exports = router;