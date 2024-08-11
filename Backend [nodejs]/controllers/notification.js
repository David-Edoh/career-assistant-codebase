const path=require('path');
const { StatusCodes } = require('http-status-codes')
const {User, Notification, Post}=require(path.join(__dirname,'..','models'));



const addNotification =  async (req, res) => {
    const { type, targetUserId, postId } = req.body;

    const _currentUser = await User.findOne({where: {id: req.user.id}});
    // const userPayload = {
    //     userId: _currentUser.id,
    //     username: _currentUser.username,
    //     pdp: _currentUser.pdp
    // };

    const newNotification = await Notification.create({
        type,
        targetUserId,
        userId: req.user.id,
        postId
    });

    // await newNotification.save();
    
    return res.status(200).json(newNotification);
};

const getNotifications =  async(req, res) => {
    try {
        console.log(req.user.id);
        const _currentUserId = req.user.id;
        const notifications = await Notification.findAll({
            include:[
                {   
                    model: User,
                    attributes: ['id', 'username', 'firstName', 'lastName', 'picturePath']    
                },    
                {
                    model: Post,
                    // attributes: [],
                    // where: {
                    //     state: defaultState
                    // }
                }
            ],
            where: {targetUserId: _currentUserId},
            order: [['updatedAt', 'DESC'],],
        });
        return res.status(200).json(notifications);
    } catch (error) {
        console.log(error);
        return res.status(500).json("Internal server error " + error );
    }
}

const notificationController={
    addNotification,
    getNotifications
}

module.exports=notificationController;