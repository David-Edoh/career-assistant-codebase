const path=require('path');
const express=require('express');
const router=express.Router();

const swaggerUI = require('swagger-ui-express');
const swaggerDocument=require(path.join(__dirname,'..','config','documentation.js'));

const DisableTryItOutPlugin=function(){
    return {
        statePlugins: {
            spec: {
                wrapSelectors: {
                    allowTryItOutFor: () => () => false
                }
            }
        }
    }
}
const options = {
    swaggerOptions: {
        plugins: [
            //  DisableTryItOutPlugin
        ]
    }
};


const authRouter=require(path.join(__dirname,'authentication.js'));
const userRouter=require(path.join(__dirname,'user.js'));
const postRouter=require(path.join(__dirname,'post.js'));
const groupRouter=require(path.join(__dirname, 'group.js'));
const commentRouter=require(path.join(__dirname,'comment.js'));
const reactionRouter=require(path.join(__dirname,'reaction.js'));
const streakRouter=require(path.join(__dirname,'streak.js'));
const notificationRouter=require(path.join(__dirname,'notification.js'));
const releationshipRouter=require(path.join(__dirname,'releationship.js'));
const searchRouter=require(path.join(__dirname , 'search.js')) ;
const homeRouter=require(path.join(__dirname,'home.js'));
const chatRouter=require(path.join(__dirname,'chat.js'));
const imageRouter=require(path.join(__dirname , 'image.js')) ;
const careerSuggestionRouter=require(path.join(__dirname , 'careerSuggestion.js')) ;
const cvManagerRouter=require(path.join(__dirname , 'cvManager.js')) ;
const authenticated=require(path.join(__dirname,'..','middlewares','authentication.js'));



router.get('/', (req, res) =>{
    res.send('<h1>Fotisia backend API</h1><a href="/api-docs">Documentation</a>');
});

router.get('/api-docs.json', (req, res) =>{
    res.setHeader("Content-Type","application/json");
    res.send(swaggerDocument);
});

router.use('/api-docs', swaggerUI.serve, swaggerUI.setup( swaggerDocument,options));
router.use('/api/auth',authRouter);
router.use('/api/user',authenticated,userRouter);
router.use('/api/post',authenticated,postRouter);
router.use('/api/group', authenticated, groupRouter);
router.use('/api/comment',authenticated,commentRouter);
router.use('/api/reaction',authenticated,reactionRouter);
router.use('/api/relationship',authenticated,releationshipRouter);
router.use('/api/search',authenticated,searchRouter);
router.use('/api/notification',authenticated,notificationRouter);
router.use('/api/home',authenticated,homeRouter);
router.use('/api/chat',authenticated,chatRouter);
router.use('/api/streak', authenticated, streakRouter);
router.use('/api/images',authenticated,imageRouter);
router.use('/api/careersuggestions',authenticated,careerSuggestionRouter);
router.use('/api/resume',authenticated,cvManagerRouter);
module.exports=router;