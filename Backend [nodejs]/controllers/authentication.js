const path=require('path');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const { StatusCodes } = require('http-status-codes');
const {User}=require(path.join(__dirname,'..','models'));
const { sendSlackNewUserMessage } = require("../utils/slack")
const { generateFromEmail } = require("unique-username-generator");
const { sendMail } = require('../services/mailing'); 

const register=async (req,res)=>
{
    const data = req.body ;
    const { fcmToken } = req.body;
    
    if(!data.username) 
    data.username = generateFromEmail(data.email, 3);
    

    const salt = await bcrypt.genSalt(10);
    data.password = await bcrypt.hash(data.password, salt);
    const user= await User.create(data);

    const accessToken=jwt.sign(
        { id: user.id, username: user.username },
        process.env.ACCESS_TOKEN_SECRET,
        {
            expiresIn: process.env.ACCESS_TOKEN_JWT_LIFETIME,
        }
    );

    let refreshToken=accessToken;
    const result=await User.update({refreshToken:refreshToken, fcmToken: fcmToken},{where:{id:user.id}});
    
    let { password, refreshToken: refToken, ...userData } = user.dataValues;
    
    userData.accessToken = accessToken;
    userData.hobbies = JSON.parse(userData.hobbies);
    
    sendSlackNewUserMessage(`A new user has just registered 🥳🍾🎆 \n\nName: ${userData.firstName} ${userData.lastName} \nEmail: ${userData.email} \nAuth Type: ${userData.authType}`)
    res.status(StatusCodes.CREATED).json({message: "user created successfully", user: userData});
}

const socialSignin = async (req, res) => {
    const {email} = req.body;
    const { fcmToken } = req.body;
    let user = await User.findOne({where:{email:email}});
    
    //check if user exist else create user.
    if(!user){
        const data = req.body ;

        if(!data.username) 
        data.username = generateFromEmail(data.email, 3);
        
        try {
            user = await User.create(data);
        } catch (error) {
            console.log(error);
        }
        console.log(user)
        sendSlackNewUserMessage(`A new user has just registered 🥳🍾🎆 \n\nName: ${user.firstName} ${user.lastName} \nEmail: ${user.email} \nAuth Type: ${user.authType}`)
    }

    // create a token for the user
    const accessToken = jwt.sign(
        { id: user.id, username: user.username },
        process.env.ACCESS_TOKEN_SECRET,
        {
            expiresIn: process.env.ACCESS_TOKEN_JWT_LIFETIME,
        }
    );

    let refreshToken = accessToken;
    const result=await User.update({refreshToken:refreshToken, fcmToken: fcmToken},{where:{id:user.id}});
    
    let { password, refreshToken: rToken,  ...userData } = user.dataValues;
    userData.accessToken = accessToken;
    userData.hobbies = JSON.parse(userData.hobbies);

    
    // return user with token
    res.status(StatusCodes.CREATED).json({status: "ok", message: "user created successfully", user: userData});

}


const login=async (req,res)=>
{
    const {email} = req.body;
    const { fcmToken } = req.body;
    const user = await User.findOne({where:{email:email}});

    const accessToken = jwt.sign(
        { id: user.id, username: user.username },
        process.env.ACCESS_TOKEN_SECRET,
        {
            expiresIn: process.env.ACCESS_TOKEN_JWT_LIFETIME,
        }
    );

    refreshToken = accessToken;
    const result = await User.update({refreshToken:refreshToken, fcmToken: fcmToken},{where:{id:user.id}});

    let { password, refreshToken: refToken, ...userData } = user.dataValues;
    
    userData.accessToken = accessToken;
    userData.hobbies = JSON.parse(userData.hobbies);


    res.status(StatusCodes.OK).json({message: "Login successful", user: userData });
}

const resetPassword = async (req, res) => {
    try {
        const { token } = req.body;
        const { newPassword } = req.body;

        const user = await User.findOne({
            where: {
                resetPasswordToken: token,
                // resetPasswordExpires > Date.now()
            }
        });

        if (!user) {
            return res.status(400).send('Password reset token is invalid or has expired');
        }

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(newPassword, salt);

        await User.update({
            password: hashedPassword,
            resetPasswordToken: null,
            resetPasswordExpires: null,
        }, {where: {id: user.id}});

          res.send('Password has been reset');
    } catch (error) {
        console.log(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({message: "Failed reseting password"});
    }
}

const forgotPassword = async (req, res) => {
    try {
        const resetToken = crypto.randomUUID().toString('hex');
        const resetTokenExpires = Date.now() + 3600000; // 1 hour
      
        await User.update({
            resetPasswordToken: resetToken,
            // resetPasswordExpires: resetTokenExpires
        }, {where: {email: req.body.email}});

        const from = "admin@fotisia.com";
        const to =  req.body.email
        const subject = `Reset your password`;
        const message = `You are receiving this because you (or someone else) have requested the reset of the password for your account.\n\n` +
        `Please click on the following link, or paste this into your browser to complete the process:\n\n` +
        `http://localhost:3000/request-reset-password/${resetToken}\n\n` +
        `If you did not request this, please ignore this email and your password will remain unchanged.\n`;

        await sendMail(from, to, subject, message);

        res.status(StatusCodes.OK).json({message: "Check your email"});
    } catch (error) {
        console.log(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({message: "Failed sending reset email"});
    }
}

const logout=async(req,res)=>
{
    const result=await User.update({refreshToken:null, fcmToken: null},{where:{id:req.user.id}});
    res.sendStatus(StatusCodes.NO_CONTENT);
}

const authController={
    register,
    login,
    socialSignin,
    logout,
    forgotPassword,
    resetPassword
};

module.exports = authController;