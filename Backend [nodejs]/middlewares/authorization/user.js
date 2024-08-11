const path=require('path');
const {unauthorized}=require(path.join(__dirname,'..','..','errors'));
const {User,Relationship}=require(path.join(__dirname,'..','..','models'));
const { Op } = require('sequelize');
const { isBlocker } = require('./relationship');
const { StatusCodes } = require('http-status-codes');


const accountOwnerShip=async(req,res,next)=>
{
    let authenticatedId=req.user.id;
    let requestedId=req.params.id;

    if(Number(authenticatedId)!==Number(requestedId))
        return res.status(StatusCodes.UNAUTHORIZED).json({message: 'You can only modify your account'});
    return next();
};

const notBlocked=async(req,res,next)=>
{
    let firstUserId=req.user.id;
    let secondUserId=req.params.id;
    if(Number(firstUserId)===Number(secondUserId))
        return next();
    const found=await Relationship.findOne({
        where:{
            [Op.or]: [
                {
                    firstUserId:firstUserId,
                    secondUserId:secondUserId,
                },
                {
                    firstUserId:secondUserId,
                    secondUserId:firstUserId,
                }
            ] 
        }
    });
    if(!found){
        req.state="Not Friends";
        return next();
    }
    if(found.dataValues.state==="blocked"){
        return res.status(StatusCodes.UNAUTHORIZED).json({message: 'this user is blocked'});
    }
    req.state=found.dataValues.state;
    req.relationship = found.dataValues;
    
    return next();
}

const userAuth={
    accountOwnerShip,
    notBlocked
}

module.exports=userAuth;