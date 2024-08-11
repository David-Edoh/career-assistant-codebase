const path=require('path');
const express=require('express');
const router=express.Router();
const {userValidation}=require(path.join(__dirname,'..','middlewares','validation'));
const {userAuth}=require(path.join(__dirname,'..','middlewares','authorization'));
const {notificationController}=require(path.join(__dirname,'..','controllers'));


router.get('/user/:id', 
userValidation.checkIdUserExestence,
userAuth.accountOwnerShip,
notificationController.getNotifications
);



module.exports=router;