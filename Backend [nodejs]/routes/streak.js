const path=require('path');
const express=require('express');
const router=express.Router();
const {streakController}=require(path.join(__dirname,'..','controllers'));
const {userValidation}=require(path.join(__dirname,'..','middlewares','validation'));
const {userAuth}=require(path.join(__dirname,'..','middlewares','authorization'));


router.get('/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    streakController.getStreak
);

router.get('/check/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    streakController.checkStreak
);

router.post('/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    streakController.createStreak
);

router.post('/:id/create/progress',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    streakController.createProgress
);

router.post('/get-score/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    streakController.getStreakPerformance
);

router.put('/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    streakController.updateStreak
);


router.put('/:id/update/progress/:progressId',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    streakController.updateProgress
);

router.put('/:id/update/schedule/:scheduleId',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    streakController.updateSchedule
);


router.delete('/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    streakController.deleteStreak
);


module.exports = router;