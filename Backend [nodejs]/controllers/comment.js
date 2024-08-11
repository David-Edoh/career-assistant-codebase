const path=require('path');
const { StatusCodes } = require('http-status-codes')
const {User, Comment, Post, Notification}=require(path.join(__dirname,'..','models'));
const { notifyPost, notifyUser } = require('../utils/Notifyer');

const createComment=async(req,res)=>
{
    try {
            //Get the post else return post not found error
            const post = await Post.findOne({
                include:[
                    {   
                        model: User,
                        attributes: ['id','username', 'firstName', 'lastName', 'picturePath', 'fcmToken']    
                    },
                    {
                        model: Comment,
                        attributes:{
                            exclude:['UserId','PostId']
                        },
                        include:{
                            model: User,
                            attributes:['id','username','picturePath', 'fcmToken']
                        }
                    },     
                ],
                where:{
                    id:req.params.id,
                    // state:defaultState
                },
            });
        
            if(!post){ return res.status(StatusCodes.NOT_FOUND).json({message: "Post not found"}); }
        
            const comment = await Comment.create({
                userId:req.user.id,
                postId:req.params.id,
                text:req.body.text
            });
            
            //add notification
            if (post.dataValues.userId !== req.user.id) {
                const notif = await Notification.create({
                    type: 'COMMENT',
                    targetUserId: post.dataValues.userId,
                    userId: req.user.id,
                    postId: req.params.id,
                });
        
                // const notif = await newNotification.save();
                notifyUser(post.dataValues.fcmToken, "New comment", "A user commented on your post", { notification: notif.dataValues });
            }
        
            notifyPost('comment', {
                userId: req.user.id,
                postId: req.params.id,
                comments: post.dataValues.comments,
            });

            let defaultState='public';
            if(req.params.groupId){
                defaultState='private';
            }
            const completeCommentData = await Comment.findOne({
                include:[
                    {
                        model: User,
                        attributes: ['id','username', 'firstName', 'lastName', 'picturePath']
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
                    id: comment.dataValues.id
                },
                attributes:{
                    exclude:['UserId','PostId']
                }
            });
        
            res.status(StatusCodes.CREATED).json(completeCommentData);
    } catch (error) {
        console.log(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("Failed adding comment, server error.");
    }
    
};

const editComment=async(req,res)=>
{
    let patchUpdate={};
    if(req.body){
        patchUpdate.text=req.body.text;
    }
    await Comment.update(patchUpdate, {where: {id:req.params.id}});
    const data=await Comment.findOne({ where: { id: req.params.id },attributes:{exclude:['UserId','PostId']}});
    res.status(StatusCodes.OK).json(data.dataValues);
};

const deleteComment=async(req,res)=>
{
    let commentId=req.params.id;
    // delete comment
    const result=await Comment.destroy({ where: { id: commentId }});
    res.status(StatusCodes.OK).json({message:"comment has been deleted"});
};

const getCommentById=async(req,res)=>
{
    let defaultState='public';
    if(req.params.groupId){
        defaultState='private';
    }
    const comment = await Comment.findOne({
        include:[
            {
                model: User,
                attributes: ['id','username', 'firstName', 'lastName', 'picturePath']
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
    res.status(StatusCodes.OK).json(comment);
};

const getAllComments=async(req,res)=>
{
    const comments=await Comment.findAll({
        include:[
            {
                model: User,
                attributes: ['id','username', 'firstName', 'lastName', 'picturePath']
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
            exclude:['UserId','PostId'],
        },
        order: [
            ['updatedAt', 'DESC'],
        ],
    });
    res.status(StatusCodes.OK).json(comments);
};


const getAllCommentsForUserByPostId=async(req,res)=>
{
    const comments=await Comment.findAll({
        include:[
            {
                model: User,
                attributes: ['id','username', 'firstName', 'lastName', 'picturePath']
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
    res.status(StatusCodes.OK).json(comments);
};

const getAllCommentsByPostId=async(req,res)=>
{
    console.log(req.params.id);
    const comments = await Comment.findAll({
        include:[
            {
                model: User,
                attributes: ['id','username', 'firstName', 'lastName', 'picturePath']
            },
            // {
            //     model: Post,
            //     // attributes: [],
            // }
        ],
        where:{
            postId:req.params.id
        },
        attributes:{
            exclude:['UserId','PostId']
        }
    });
    console.log(comments);
    res.status(StatusCodes.OK).json(comments);
};

const commentController={
    createComment,
    editComment,
    deleteComment,
    getCommentById,
    getAllComments,
    getAllCommentsByPostId,
    getAllCommentsForUserByPostId
};

module.exports=commentController;