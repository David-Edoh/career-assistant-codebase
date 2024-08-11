'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class UserResumeEducation extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */

    static associate(models) {
      UserResumeEducation.belongsTo(models.UserResumeDetail, { foreignKey: 'userResumeDetailId' });
    }
    
  }
  UserResumeEducation.init({
    id:{
      type:DataTypes.INTEGER,
      allowNull:false,
      primaryKey:true,
      autoIncrement:true
    },
    school: {
      type: DataTypes.STRING
    },
    discipline: {
      type: DataTypes.STRING
    },
    level: {
      type: DataTypes.STRING
    },
    startDate: {
      type: DataTypes.STRING
    },
    endDate: {
      type: DataTypes.STRING
    },
    currentlySchoolHere : {
      type: DataTypes.BOOLEAN
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
    modelName: 'UserResumeEducation',
    tableName: 'educations',
  });
  return UserResumeEducation;
};