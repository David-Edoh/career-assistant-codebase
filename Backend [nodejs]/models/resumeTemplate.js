'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class ResumeTemplate extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */

    
  }
  ResumeTemplate.init({
    id:{
      type:DataTypes.INTEGER,
      allowNull:false,
      primaryKey:true,
      autoIncrement:true
    },
    bodyHTML: {
      type: DataTypes.TEXT('medium'),
      allowNull: false
    },
    sampleHTML: {
      type: DataTypes.TEXT('medium'),
      allowNull: false
    },
    experienceHTML: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    educationHTML: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    skillHTML: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    socialsHTML: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    projectsHTML: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    certificationsHTML: {
      type: DataTypes.TEXT,
      allowNull:true,
    },
    referencesHTML: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    description: {
      type: DataTypes.STRING,
    },
    thumbnail:{
      type: DataTypes.STRING,
    },

    experienceSection: {
      type: DataTypes.TEXT('medium'),
      allowNull: true
    },
    educationSection: {
      type: DataTypes.TEXT('medium'),
      allowNull: true
    },
    projectSection: {
      type: DataTypes.TEXT('medium'),
      allowNull: true
    },
    certificationSection: {
      type: DataTypes.TEXT('medium'),
      allowNull: true,
    },
    skillsSection: {
      type: DataTypes.TEXT('medium'),
      allowNull: true
    },
    websiteSection: {
      type: DataTypes.TEXT('medium'),
      allowNull: true
    },
    referenceSection: {
      type: DataTypes.TEXT('medium'),
      allowNull: true
    },
    profilePicSection: {
      type: DataTypes.TEXT('medium'),
      allowNull: true
    },
    socialsSection: {
      type: DataTypes.TEXT('medium'),
      allowNull: true
    },
    addressSection: {
      type: DataTypes.TEXT('medium'),
      allowNull: true
    },
    phoneNumberSection: {
      type: DataTypes.TEXT('medium'),
      allowNull: true
    },
    createdAt: {
      allowNull: true,
      type: DataTypes.DATE,
      defaultValue:DataTypes.NOW 
    },

    updatedAt: {
      allowNull: true,
      type: DataTypes.DATE,
      defaultValue:DataTypes.NOW
    },
  }, {
    sequelize,
    modelName: 'ResumeTemplate',
    tableName: 'resumetemplates',
  });
  return ResumeTemplate;
};