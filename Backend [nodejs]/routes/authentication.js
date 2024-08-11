const path=require('path');
const express=require('express');
const router=express.Router();
const {authController}=require(path.join(__dirname,'..','controllers'));
const {authValidation}=require(path.join(__dirname,'..','middlewares','validation'));
const uploadImage=require(path.join(__dirname,'..','middlewares','uploadImage'));
const authenticated=require(path.join(__dirname,'..','middlewares','authentication.js'));


router.post('/register',uploadImage,authValidation.register,authController.register);
router.post('/social/signin', authController.socialSignin);
router.post('/forgot-password', authController.forgotPassword);
router.post('/reset-password', authController.resetPassword);
router.post('/login',authValidation.login,authController.login);
router.get('/logout',authenticated,authController.logout);

module.exports = router;




