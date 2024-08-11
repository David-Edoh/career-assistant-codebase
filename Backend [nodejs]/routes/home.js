const path=require('path');
const express=require('express');
const router=express.Router();
const {homeController}=require(path.join(__dirname,'..','controllers'));


router.get('/search',homeController.search);
router.get('/news',homeController.postFeeds);
router.post(
    '/personalized-news',
    homeController.getPersonalizedNews,
);

module.exports=router;