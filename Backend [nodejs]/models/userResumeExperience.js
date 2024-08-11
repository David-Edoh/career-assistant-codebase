'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class UserResumeExperience extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */

    static associate(models) {
      UserResumeExperience.belongsTo(models.UserResumeDetail, { foreignKey: 'userResumeDetailId' });
    }

  }
  UserResumeExperience.init({
    id:{
      type:DataTypes.INTEGER,
      allowNull:false,
      primaryKey:true,
      autoIncrement:true
    },
    company: {
      type: DataTypes.STRING
    },
    position: {
      type: DataTypes.STRING
    },
    startDate: {
      type: DataTypes.STRING
    },
    endDate: {
      type: DataTypes.STRING
    },
    address: {
      type: DataTypes.STRING
    },
    currentlyWorkHere : {
      type: DataTypes.BOOLEAN
    },
    description: {
      type: DataTypes.TEXT
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
    modelName: 'UserResumeExperience',
    tableName: 'experiences'
  });
  return UserResumeExperience;
};