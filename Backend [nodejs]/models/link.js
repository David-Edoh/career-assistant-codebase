'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Link extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Link.belongsTo(models.Opportunity, { foreignKey: 'opportunityId' });
      Link.belongsTo(models.Event, { foreignKey: 'eventId' });
    }
  }
  Link.init({
    id:{
      type:DataTypes.INTEGER,
      allowNull:false,
      primaryKey:true,
      autoIncrement:true
    },

    link: DataTypes.STRING,

    description: DataTypes.STRING,

    title: DataTypes.STRING,

    imageUrl: DataTypes.STRING,

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
    modelName: 'Link',
    tableName: 'links',
  });
  return Link;
};