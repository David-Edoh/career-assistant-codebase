const path=require('path');
const {StatusCodes}=require('http-status-codes');
const { User, Reaction, Post, Notification}=require(path.join(__dirname,'..','models'));
const { notifyUser } = require('../utils/Notifyer');



const createReaction=async(req, res)=>
{
    try {
        const reaction = await Reaction.create({
            userId:req.user.id,
            postId:req.params.id,
            state:req.body.state
        });

        const post = await Post.findOne({
            include:[
                {   
                    model: User,
                    attributes: ['id','username', 'firstName', 'lastName', 'picturePath', 'fcmToken']    
                }     
            ],
            where: {id: req.params.id}
        })

        // add notification    
        const newNotification = await Notification.create({
            type: 'NEW-REACTION',
            userId: req.user.id,
            targetUserId: post.dataValues.userId,
            postId: req.params.id,
        });

        notifyUser(post.dataValues.fcmToken, "New reaction", "A user reacted to your post", { notification: newNotification.dataValues });

        res.status(StatusCodes.CREATED).json(reaction.dataValues);
    } catch (error) {
        console.log(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("Failed reacting to post, server error.");  
    }
};


const editReaction=async(req,res)=>
{
    let patchUpdate={};
    patchUpdate.state=req.body.state;
    await Reaction.update(patchUpdate, {where: {id:req.params.id}});
    const data=await Reaction.findOne({ where: { id: req.params.id },attributes:{exclude:['UserId','PostId']}});
    res.status(StatusCodes.OK).json(data.dataValues);
};

const deleteReaction=async(req,res)=>
{
    let reactionId=req.params.id;
    // delete reaction
    const result=await Reaction.destroy({ where: { id: reactionId }});
    res.status(StatusCodes.OK).json({message:"reaction has been deleted"});
};

const getReactionById=async(req,res)=>
{
    let defaultState='public';
    if(req.params.groupId){
        defaultState='private';
    } 
    const reaction=await Reaction.findOne({
        include:[
            {
                model: User,
                attributes: ['id','username', 'picturePath']
            },
            {
                model: Post,
                attributes: [],
                where: {
                    state: defaultState
                }
            }
        ],
        where:{
            id:req.params.id
        },
        attributes:{
            exclude:['UserId','PostId']
        }
    });
    res.status(StatusCodes.OK).json(reaction);
};

const getAllReactions=async(req,res)=>
{
    const reaction=await Reaction.findAll({
        include:[
            {
                model: User,
                attributes: ['id','username', 'picturePath']
            },
            {
                model: Post,
                attributes: [],
                where: {
                    state: 'public'
                }
            }
        ],
        where:{
            userId:req.params.id
        },
        attributes:{
            exclude:['UserId','PostId']
        },
        order: [
            ['updatedAt', 'DESC'],
        ],
    });
    res.status(StatusCodes.OK).json(reaction);
};

const getAllReactionsForUserByPostId=async(req,res)=>
{
    const reaction=await Reaction.findAll({
        include:[
            {
                model: User,
                attributes: ['id','username', 'picturePath']
            },
            {
                model: Post,
                attributes: [],
                where: {
                    state: 'private'
                }
            }
        ],
        where:{
            userId:req.user.id,
            postId:req.params.id
        },
        attributes:{
            exclude:['UserId','PostId']
        }
    });
    res.status(StatusCodes.OK).json(reaction);
};

const reactionController={
    createReaction,
    editReaction,
    deleteReaction,
    getReactionById,
    getAllReactions,
    getAllReactionsForUserByPostId
};

module.exports=reactionController;