const path=require('path');
const express=require('express');
const router=express.Router();
const {userController}=require(path.join(__dirname,'..','controllers'));
const {userValidation}=require(path.join(__dirname,'..','middlewares','validation'));
const uploadImage=require(path.join(__dirname,'..','middlewares','uploadImage'));
const {userAuth}=require(path.join(__dirname,'..','middlewares','authorization'));


router.get('/current/profile/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    userController.getCurrentUser
);

router.get('/profile/:id',
    userValidation.checkIdUserExestence,
    userAuth.notBlocked,
    userController.getUser
);

router.post('/profile/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    // uploadImage,
    userValidation.updateProfileOfUser,
    userController.updateUser
);


router.delete('/profile/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    userController.deleteUser
);


router.post('/career/details/:id',
    userValidation.checkIdUserExestence,
    userAuth.accountOwnerShip,
    userValidation.updateProfileOfUser,
    userController.updateUserCareerDetails
);

module.exports = router;