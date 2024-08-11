const path = require('path') ;
const {Group , GroupUser , User , Post , GroupPost , Reaction, Comment ,Sequelize }= require(path.join(__dirname , '..' , 'models'  )) ;

const createGroup = async (req , res) =>{
    let user = req.user ; 
    let data = {} ;
    if(req.file) data.filename = req.file.filename ;
    let group = await Group.create({groupName:req.body.groupName , groupDescription: req.body.groupDescription , groupPicture:data.filename });
    let groupUser = await GroupUser.create({userId: user.id , groupId: group.id , state:'Owner'}) ; 
    return res.json({message:'Group created successfully' , group: group}) ;
}

const deleteGroup = async (req , res)=>{
    let user = req.user ;
    await Group.destroy({where:{ id: req.params.groupId}}); 
    return res.json({message:"Group deleted successfully"}); 
}
const editGroup = async (req , res )=>{
    let user = req.user ;
    let group = {} ;
    if(req.body.groupName){
        group.groupName = req.body.groupName ;
    }
    if(req.body.groupDescription){
        group.groupDescription = req.body.groupDescription ; 
    }
    let Updatedgroup = await Group.update(group , {where:{id: req.params.groupId}}) ;
    return res.json({message:"group updated successfully" , group:Updatedgroup}) ;
}
const getGroup = async(req, res )=>{
    let group = await Group.findOne({where:{id: req.params.groupId}}) ;
    let state =  await GroupUser.findOne({where:{groupId: req.params.groupId , userId: req.user.id}}) ;
    return res.json({message:'success', group , role: (state.state || 'outOfGroup')}) ; 
}
const MyGroups = async (req , res )=>{
    let user =await User.findOne({where:{id:req.user.id} , include:Group } );
    return res.json({groups:user.Groups});
}

const joinRequest = async (req , res )=>{
    // if user is kicked he can't do anything, he haven't sent any request -> pending , if he is in he will leave
    let groupUser = await GroupUser.findOne({where:{userId: req.user.id , groupId : req.params.groupId }}) ; 
    if(!groupUser){
        await GroupUser.create({userId: req.user.id , groupId: req.params.groupId , state:'pending'}) ;
        return res.json({message:'join request has been sent successfully'});
    }
    if(groupUser.state == 'kicked' ){
        return res.json({message:'You are not allowed to make this action'}) ;
    }
    else{
        await GroupUser.destroy({where:{userId: req.user.id , groupId: req.params.groupId }} );
        return res.json({message:'canceled successfully'}) ;
    }
}
const showJoinRequests  = async (req , res )=>{
    let users = await GroupUser.findAll({ where:{groupId: req.params.groupId , state:'pending' },  include:{model:User , attributes:['id','username' , 'picturePath']  } , attributes:['userId' , 'state' , 'createdAt' ]}); 
    return res.json(users.users);
}
const modifyRole = async (req , res )=>{
    await GroupUser.update({state:req.body.state } ,{where:{groupId: req.params.groupId , userId:req.params.userId }});
    return res.json({message:'updated successfully' , newRole: req.body.state }) ;
}
const groupMemebers = async (req , res )=>{
    let users = await GroupUser.findAll({where:{groupId: req.params.groupId , state:['Admin' , 'Owner', 'normal' ]}, include:{model:User, attributes:['id', 'username' , 'picturePath']}}) ; 
    return res.json(users) ;
}

const createPost = async (req ,res ) =>{
    let data = {} ;
    if(req.body.text)  data.text = req.body.text ;
    if(req.file) data.filename = req.file.filename ;
    const groupUser = await GroupUser.findOne({where:{userId:req.user.id , groupId: req.params.groupId}}) ;
    const post = await Post.create({userId : req.user.id , text: data.text , picture: data.filename , state:'private' } ) ;
    const groupPost = await GroupPost.create({groupUserId : groupUser.id , postId: post.id , groupId: req.params.groupId } ) ;
    return res.json({message:'Post created successfully' , post }) ;    
}

const getPost = async (req ,res )=>{
    
    const post=await Post.findOne({
        include:[
            {
                model: User,
                attributes: ['id','username', 'picturePath']    
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
                as :'reaction',
                where:{userId: req.user.id},
                required:false 
            }
        ],
        where:{
            id:req.params.postId
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
        }
    });
    
    return res.json({message:'success' , post }) ;
}


const getPosts = async (req ,res ) =>{
    const posts = await Group.findOne({where:{id:req.params.groupId} , 
            include:{
                model: GroupPost , attributes:['postId'] , 
                include:{
                    model:Post ,include:[
                        {
                            model: User,
                            attributes: ['id','username', 'picturePath']    
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
                            model: Reaction ,
                            as: 'reaction',
                            where: {userId:req.user.id},
                            required:false 
                        }
                    ]
                }
            },
            attributes:{
                include: [
                    [
                        Sequelize.literal('(SELECT COUNT(*) FROM comments WHERE comments.postId = groupposts.groupId)'), 'commentsCount'
                    ],
                    [
                        Sequelize.literal('(SELECT COUNT(*) FROM reactions WHERE reactions.postId = groupposts.groupId AND state="like")'), 'likesCount'
                    ],
                    [
                        Sequelize.literal('(SELECT COUNT(*) FROM reactions WHERE reactions.postId = groupposts.groupId AND state="dislike")'), 'dislikesCount'
                    ]
                ],
                exclude:['UserId']
            }
    });
    return res.json({posts:posts.GroupPosts}) ;
}

const editPost = async (req ,res )=>{
    let data = {} ;
    if(req.body.text ) data.text = req.body.text ;
    if(req.file) data.filename = req.file.filename ;
    await Post.update({text: data.text , picture: data.filename } , {where: {id: req.params.postId } } );
    return res.json({message:'post updated successfully' }) ;
}
const deletePost = async (req , res) => 
{
    await Post.destroy({where:{id: req.params.postId}}) ;
    await GroupPost.destroy({where:{postId: req.params.postId}});
    return res.json({message:'success' });
}

let groupController = {
    createGroup ,
    editGroup,
    deleteGroup,
    MyGroups,
    joinRequest,
    modifyRole,
    showJoinRequests,
    groupMemebers ,
    getGroup,

    createPost,
    getPosts,
    editPost ,
    deletePost,
    getPost 
};

module.exports = groupController ;

/* 
    
    check (comment , post , reaction) existance in group 
    
*/