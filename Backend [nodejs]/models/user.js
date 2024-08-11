'use strict';
const { Model } = require('sequelize');


module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      User.hasMany(models.Post);
      User.hasMany(models.Comment);
      User.hasMany(models.Reaction);
      User.hasMany(models.GroupUser);
      User.hasMany(models.Opportunity);
      User.hasMany(models.SuggestedCareer);
      User.belongsToMany(models.Group , {through: models.GroupUser });
      // User.hasMany(models.Chat);
      // User.hasMany(User,{ through: models.Relationship });
    }
  }
  User.init({
    id:{
      type:DataTypes.INTEGER,
      allowNull:false,
      primaryKey:true,
      autoIncrement:true
    },
    username: {
      type: DataTypes.STRING,
      allowNull:false,
      unique: {
        args: true,
        message: 'Username address already in use!'
      },
      validate: {
        notNull: {
          message: 'Please enter your username'
        },
        customValidator(username) {
          if (username === "") {
            throw new Error("name can't be empty Please enter your username");
          }
        },
      }
    },
    email: {
      type: DataTypes.STRING,
      allowNull:false,
      unique: {
        args: true,
        message: 'Email address already in use!'
      },
      validate:{
        isEmail:true
      }
    },
    authType: {
      type: DataTypes.STRING,
      defaultValue: "local",
      validate:{
        isIn:[['local' , 'Google', 'Linkedin', 'Apple']]
      },
      allowNull:true,
    },
    password: {
      type: DataTypes.STRING,
      allowNull:true,
    },
    firstName: {
      type: DataTypes.STRING
    },
    lastName: {
      type: DataTypes.STRING
    },
    picturePath: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png"
    },
    gender: {
      type: DataTypes.STRING,
      validate:{
        isIn:[ ['male' , 'female']]
      }
    },
    birthday: {
      type: DataTypes.DATE
    },
    country: {
      type: DataTypes.STRING
    },
    address: {
      type: DataTypes.STRING
    },
    phoneNumber: {
      type: DataTypes.STRING
    },
    hobbies: {
      type: DataTypes.STRING,
      defaultValue: "[]"
    },
    disability: {
      type: DataTypes.STRING,
    },
    employmentStatus: {
      type: DataTypes.STRING,
    },
    educationLevel: {
      type: DataTypes.STRING,
    },
    specialization: {
      type: DataTypes.STRING,
    },
    careerGoal: {
      type: DataTypes.STRING,
    },
    keyStrength: {
      type: DataTypes.STRING,
    },
    socket_io_id: {
      type: DataTypes.STRING
    },
    fcmToken: {
      type: DataTypes.STRING
    },
    refreshToken: {
      type: DataTypes.STRING
    },
    resetPasswordToken: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    resetPasswordExpires: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    createdAt: {
      allowNull: false,
      type: DataTypes.DATE,
      defaultValue:DataTypes.NOW 
    },
    updatedAt: {
      allowNull: false,
      type: DataTypes.DATE,
      defaultValue:DataTypes.NOW
    },
  }, {
    sequelize,
    modelName: 'User',
    tableName: 'users',
  });
  return User;
};




