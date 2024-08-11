const path=require('path');
const { StatusCodes } = require('http-status-codes')
const {User,Group,Post,Comment,Reaction,Relationship}=require(path.join(__dirname,'..','models'));
const {Op,Sequelize } = require('sequelize');
const {getNews} = require('../services/gemini')

const search=async(req,res)=>
{
    let SearchResults=0;
    console.log(req.query.text);

    if(!req.query.text)
        return res.status(StatusCodes.OK).json({"msg":`${SearchResults} Search Results Found !!`});
    
    const users = await User.findAll({
        where:{
            [Op.or]: [
            {
                username:
                {
                    [Op.like]:`%${req.query.text}%`
                }
            },
            {
                firstName:
                {
                    [Op.like]:`%${req.query.text}%`
                }
            },
            {
                lastName:
                {
                    [Op.like]:`%${req.query.text}%`
                }
            }
        ]
        },
        attributes: ['id','email','username','firstName', 'lastName', 'picturePath']
    });
    const groups=await Group.findAll({
        where:{
        [Op.or]:[
            {
                groupName: 
                { 
                    [Op.like]: `%${req.query.text}%` 
                }
            },
            {
                groupDescription: { 
                    [Op.like]: `%${req.query.text}%`
                }
            } 
        ]}
    });
    const uniqueUsersId = new Set();
    uniqueUsersId.add(req.user.id);
    const friends=await Relationship.findAll({
        where:{
            [Op.or]: [
                {
                    firstUserId:req.user.id,
                    state:"friends"
                },
                {
                    secondUserId:req.user.id,
                    state:"friends"
                }
            ] 
        },
        attributes:['firstUserId','secondUserId'],
    });
    friends.forEach((friend) => {
        uniqueUsersId.add(friend.firstUserId);
        uniqueUsersId.add(friend.secondUserId);
    });
    let idArr=[...uniqueUsersId];

    let posts=await Post.findAll({
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
            }
        ],
        where:{
            text: { 
                [Op.like]: `%${req.query.text}%`,
            },
            // userId:idArr.map((id)=>id), 
            state:"public"
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

    posts.forEach((post)=>{
        post.dataValues.media = JSON.parse(post.dataValues.media)
    })
    
    if(users){
        SearchResults+=users.length;
    }
    if(groups){
        SearchResults+=groups.length;
    }
    if(posts){
        SearchResults+=posts.length;
    }
    res.status(StatusCodes.OK).json({
        "msg":`${SearchResults} Search Results Found !!`,
        users:users,
        groups:groups,
        posts:posts
    });
};


const getPersonalizedNews = async (req, res) => {
    try {
        // Get suggested news for this user
        const userResumeDetail = req.body.userResumeDetail;
        const todaysPersonalizedNews =  (await getNews(userResumeDetail)).articles;

        // search and retrieve existing news from database (With comments and likes)
        const todaysPersonalizedNewsUrls = extractUrls(todaysPersonalizedNews);

        const alreadySavedNews = await Post.findAll({
            where: {
                externalUrl: {
                    [Op.in]: todaysPersonalizedNewsUrls
                },
            },
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

        
        // Save news to the database news that has not been saved to the database.
        const unsavedNews = filterNewsUrlsForUnsavedNews(todaysPersonalizedNews, alreadySavedNews ?? [])
        const savedNews = await Post.bulkCreate(updateKeys(unsavedNews)); 

        // replace existing news from the database containing comments into the news API array.
        const articles_1 =  replaceAlreadySavedObjects(todaysPersonalizedNews, alreadySavedNews);
        const articles_2 =  replaceAlreadySavedObjects(articles_1, savedNews);

        let allPosts = updateKeys(articles_2);

        let a = []
        allPosts.forEach((post)=>{
            try {
                post.dataValues.media = JSON.parse(post.dataValues.media)
                a.push(post.dataValues)
            } catch (error) {
                console.log(error);
                // console.log(post.dataValues);
                res.status(StatusCodes.EXPECTATION_FAILED).json({ msg: error });
            }
        })

        res.status(StatusCodes.OK).json({ posts: a });
    } catch (error) {
        console.log(error);
        console.log("error getting news");
    }
}

const updateKeys = (newsArray) => {
    return newsArray.map(item => ({
        ...item,
        userId: 2,
        state: 'public',
        type: "news-article",
        text: item.description,
        heading: item.title,
        media: item.urlToImage ? JSON.stringify([item.urlToImage]) : null,
        externalUrl: item.url
    }));
};

function replaceAlreadySavedObjects(personalizedNews, alreadySavedNews){
    // Create a map from alreadySavedNews for quick lookup
    const savedNewsMap = new Map(alreadySavedNews.map(news => [news.dataValues.externalUrl, news]));

    // Replace the objects in newsUrls array with the matching objects from alreadySavedNews
    const updatedNewsUrls = personalizedNews.map(news => savedNewsMap.has(news.url) ? savedNewsMap.get(news.url) : news);

    return updatedNewsUrls;
}

function filterNewsUrlsForUnsavedNews(personalizedNews, alreadySavedNews) {
    // Extract URLs into a Set for fast lookup
    const savedUrls = new Set(alreadySavedNews.map(news => news.dataValues.externalUrl));

    // Filter newsUrls to exclude those already saved
    return personalizedNews.filter(news => !savedUrls.has(news.url));
}

function extractUrls(articles) {
    return articles.map(article => article.url);
}

const postFeeds=async(req,res)=>
{
    try {
    const page = parseInt(req.query.page) || 1;
    const pageSize = parseInt(req.query.pageSize) || 15;

    const uniqueUsersId = new Set();
    uniqueUsersId.add(req.user.id);
    const friends=await Relationship.findAll({
        where:{
            [Op.or]: [
                {
                    firstUserId:req.user.id,
                    state:"friends"
                },
                {
                    secondUserId:req.user.id,
                    state:"friends"
                }
            ] 
        },
        attributes:['firstUserId','secondUserId'],
    });
    friends.forEach((friend) => {
        uniqueUsersId.add(friend.firstUserId);
        uniqueUsersId.add(friend.secondUserId);
    });
    let idArr=[...uniqueUsersId];
    let posts = await Post.findAll({
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
                    attributes:['id','username','picturePath', 'firstName', 'lastName']
                }
            },
            {
                model:Reaction,
                attributes:{
                    exclude:['UserId','PostId']
                },
                include:{
                    model:User,
                    attributes:['id','username','picturePath', 'firstName', 'lastName'],
                }
            },{
                model:Reaction , 
                as:'reaction',
                where:{userId: req.user.id} ,
                required:false 
            }
        ],
        where:{
            // userId:idArr.map((id)=>id),
            state:"public",
            type: 'user-post'
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
        order: [['updatedAt', 'DESC'],],
        limit: pageSize,
        offset: (page - 1) * pageSize,
    });
    

    console.log(posts)

    posts.forEach((post)=>{
        post.dataValues.likesCount += fakeLike(post.dataValues.media);
        post.dataValues.media = JSON.parse(post.dataValues.media)
    })

    console.log(posts)

    
    res.status(StatusCodes.OK).json({posts:posts});
    } catch (error) {
        console.error('Error fetching posts:', error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({ error: 'Internal Server Error' });
    }
}

// fakeLike function to convert string to integer
function fakeLike(str) {
    var hash = 0, i, chr;
    if (str.length === 0) return hash;
    for (i = 0; i < str.length; i++) {
        chr   = str.charCodeAt(i);
        hash  = ((hash << 5) - hash) + chr;
        hash |= 0; // Convert to 32bit integer
    }
    // Ensure positive integer
    hash = Math.abs(hash);
    // Map the hash value to the range 1 to 500
    hash = (hash % 500) + 1;
    return hash;
}

const homeController={
    search,
    postFeeds,
    getPersonalizedNews
}


module.exports=homeController;
