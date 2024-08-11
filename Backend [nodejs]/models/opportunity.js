'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Opportunity extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Opportunity.belongsTo(models.User, { foreignKey: 'userId' });
      Opportunity.hasMany(models.Link, { as: 'links' });
    }
  }
  Opportunity.init({
    id:{
      type:DataTypes.INTEGER,
      allowNull:false,
      primaryKey:true,
      autoIncrement:true
    },

    opportunity: DataTypes.STRING,

    description: DataTypes.STRING,

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
    modelName: 'Opportunity',
    tableName: 'opportunities',
  });
  return Opportunity;
};