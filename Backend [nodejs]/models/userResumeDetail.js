'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class UserResumeDetail extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */

    static associate(models) {
      UserResumeDetail.belongsTo(models.User, { foreignKey: 'userId' });
      UserResumeDetail.hasMany(models.UserResumeEducation, { as: 'educations' });
      UserResumeDetail.hasMany(models.UserResumeExperience, { as: 'experiences' });
    }
  }
  UserResumeDetail.init({
    id:{
      type:DataTypes.INTEGER,
      allowNull:false,
      primaryKey:true,
      autoIncrement:true
    },
    email: {
      type: DataTypes.STRING,
      allowNull:false,
      validate:{
        isEmail:true
      }
    },
    firstName: {
      type: DataTypes.STRING
    },
    lastName: {
      type: DataTypes.STRING
    },
    preferredDesignation: {
      type: DataTypes.STRING
    },
    address: {
      type: DataTypes.STRING
    },
    phoneNumber: {
      type: DataTypes.STRING
    },
    about: {
      type: DataTypes.STRING
    },
    picturePath: {
      type: DataTypes.STRING
    },
    gender: {
      type: DataTypes.STRING,
      validate:{
        isIn:[ ['', 'male' , 'female']]
      },
      allowNull:true,
    },
    birthday: {
      type: DataTypes.DATE
    },
    country: {
      type: DataTypes.STRING
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
    skills: {
      type: DataTypes.TEXT('medium'),
      defaultValue: "[]",
      allowNull:false,
    },
    references: {
      type: DataTypes.TEXT('medium'),
      defaultValue: "[]",
      allowNull:false,
    },
    projects: {
      type: DataTypes.TEXT('medium'),
      defaultValue: "[]",
      allowNull:false,
    },
    trainings_courses_certifications: {
      type: DataTypes.TEXT('medium'),
      defaultValue: "[]",
      allowNull:false,   
    },
    hobbies: {
      type: DataTypes.TEXT('medium'),
      defaultValue: "[]",
      allowNull:false,
    },
    disability: {
      type: DataTypes.STRING,
      allowNull:true,
    },
    socials: {
      type: DataTypes.TEXT("medium"),
      allowNull: false,
      defaultValue: "[]"
    },
    website: {
      type: DataTypes.STRING,
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
    modelName: 'UserResumeDetail',
    tableName: 'userresumedetails',
    indexes: [
      {
        name: "userId",
        using: "BTREE",
        fields: [
          { name: "userId" },
        ]
      },
    ]
  });
  return UserResumeDetail;
};