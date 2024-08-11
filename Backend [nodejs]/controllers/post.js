const path=require('path');
const { StatusCodes } = require('http-status-codes')
const {User,Post,Comment,Reaction}=require(path.join(__dirname,'..','models'));
const Sequelize=require('sequelize');


const createPost=async(req,res)=>
{
    try {
        let data={};
        data.text=null;
        let defaultState='public';

        if(req.body){
            const {text}= req.body;
            data.text=text;
        }

        let locations = []
        if(req.files){
            req.files.forEach((file) => {
                locations.push(file.location);
            })
        }

        //create post in database
        data.userId=Number(req.user.id);
        const createdPost = await Post.create({
            userId:data.userId,
            text:data.text,
            state:defaultState,
            type: 'user-post',
            media: JSON.stringify(locations)
        });

        const post = await Post.findOne({
            include:[
                {   
                    model: User,
                    attributes: ['id','username', 'firstName', 'lastName', 'picturePath']    
                },
                {
                    model: Comment,
                    attributes:{
                        exclude:['UserId','PostId']
                    },
                    include:{
                        model: User,
                        attributes:['id','username','picturePath']
                    }
                },
                {
                    model:Reaction,
                    attributes:{
                        exclude:['UserId','PostId']
                    },
                    include:{
                        model:User,
                        attributes:['id','username','picturePath'],
                    }
                },{
                    model:Reaction , 
                    as:'reaction',
                    where: {userId:req.user.id},
                    required: false
                }
            
            ],
            where:{
                id:createdPost.dataValues.id,
                state:defaultState,
            },
            attributes:{
                include: [
                    [
                        Sequelize.literal('(SELECT COUNT(*) FROM comments WHERE comments.postId = post.id)'), 'commentsCount'
                    ],
                    [
                        Sequelize.literal('(SELECT COUNT(*) FROM reactions WHERE reactions.postId = post.id AND state="like")'), 'likesCount'
                    ],
                    [
                        Sequelize.literal('(SELECT COUNT(*) FROM reactions WHERE reactions.postId = post.id AND state="dislike")'), 'dislikesCount'
                    ]
    
                ],
                exclude:['UserId']
            },
        });
    
        res.status(StatusCodes.CREATED).json(post);
    } catch (error) {
        console.log(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("Error creating post");
    }
    
};

const editPost=async(req,res)=>
{
    let patchUpdate={};
    if(req.body)
    {
        const {text}= req.body;
        patchUpdate.text=text;
    }
    if(req.file){
        patchUpdate.picture=req.file.filename;
    }
    await Post.update(patchUpdate, {where: {id:req.params.id}});
    const data=await Post.findOne({ where: { id: req.params.id },attributes:{exclude:['UserId']}});
    res.status(StatusCodes.OK).json(data.dataValues);
};

const deletePost=async(req,res)=>
{
    let postId=req.params.id;
    // delete comments
    
    // delete reactions 

    // delete post
    const result=await Post.destroy({ where: { id: postId }});
    res.status(StatusCodes.OK).json({message:"post has been deleted"});
};

const getPostById=async(req,res)=>
{
    let defaultState='public';
    const post=await Post.findOne({
        include:[
            {   
                model: User,
                attributes: ['id','username', 'firstName', 'lastName', 'picturePath']    
            },
            {
                model: Comment,
                attributes:{
                    exclude:['UserId','PostId']
                },
                include:{
                    model: User,
                    attributes:['id','username', 'firstName', 'lastName','picturePath']
                }
            },
            {
                model:Reaction,
                attributes:{
                    exclude:['UserId','PostId']
                },
                include:{
                    model:User,
                    attributes:['id','username','picturePath'],
                }
            },
            {
                model:Reaction , 
                as:'reaction',
                where: {userId:req.user.id},
                required: false
            }
        
        ],
        where:{
            id:req.params.id,
            state:defaultState
        },
        attributes:{
            include: [
                [
                    Sequelize.literal('(SELECT COUNT(*) FROM comments WHERE comments.postId = post.id)'), 'commentsCount'
                ],
                [
                    Sequelize.literal('(SELECT COUNT(*) FROM reactions WHERE reactions.postId = post.id AND state="like")'), 'likesCount'
                ],
                [
                    Sequelize.literal('(SELECT COUNT(*) FROM reactions WHERE reactions.postId = post.id AND state="dislike")'), 'dislikesCount'
                ]

            ],
            exclude:['UserId']
        },
    });

    post.media = JSON.parse(post.media)

    res.status(StatusCodes.OK).json(post);
};

const getAllPosts=async(req, res)=>
{
    try {
        const page = req.query.page || 1;
        const pageSize = req.query.pageSize || 15;

        let defaultState = 'public';

        const posts = await Post.findAll({
            include:[
                {
                    model: User,
                    attributes: ['id','username','firstName', 'lastName','picturePath']    
                },
                {
                    model: Comment,
                    attributes:{
                        exclude:['UserId','PostId']
                    },
                    include:{
                        model: User,
                        attributes:['id','username','picturePath']
                    }
                },
                {
                    model:Reaction,
                    attributes:{
                        exclude:['UserId','PostId']
                    },
                    include:{
                        model:User,
                        attributes:['id','username','picturePath'],
                    }
                },
                {
                    model:Reaction , 
                    as: 'reaction',
                    where: {userId: req.user.id },
                    required:false 
                }
            ],
            where:{
                userId: req.params.id,
                state: defaultState,
                type: 'user-post',
            },
            attributes:{
                include: [
                    [
                        Sequelize.literal('(SELECT COUNT(*) FROM comments WHERE comments.postId = post.id)'), 'commentsCount'
                    ],
                    [
                        Sequelize.literal('(SELECT COUNT(*) FROM reactions WHERE reactions.postId = post.id AND state="like")'), 'likesCount'
                    ],
                    [
                        Sequelize.literal('(SELECT COUNT(*) FROM reactions WHERE reactions.postId = post.id AND state="dislike")'), 'dislikesCount'
                    ]
                ],
                exclude:['UserId']
            },
            order: [['updatedAt', 'DESC']],
            // limit: pageSize,
            // offset: (page - 1) * pageSize,
        });

        console.log(posts)

        posts.forEach(function(post) {
            post.Reactions += fakeLike(post.media);
        });

        console.log(posts)

        res.status(StatusCodes.OK).json({posts:posts});
    } catch (error) {
        console.error('Error fetching posts:', error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({ error: 'Internal Server Error' });
    }
    
};

// fakeLike function to convert string to integer
function fakeLike(str) {
    var hash = 0, i, chr;
    if (str.length === 0) return hash;
    for (i = 0; i < str.length; i++) {
        chr   = str.charCodeAt(i);
        hash  = ((hash << 5) - hash) + chr;
        hash |= 0; // Convert to 32bit integer
    }
    return hash;
}

const postController={
    createPost,
    editPost,
    deletePost,
    getPostById,
    getAllPosts
};
module.exports=postController;


