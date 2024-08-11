'use strict';
const { Model } = require('sequelize');


module.exports = (sequelize, DataTypes) => {
  class SuggestedCertification extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      SuggestedCertification.belongsTo(models.Roadmap, { foreignKey: 'roadmapId' });
    }
  }
  SuggestedCertification.init({
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    name: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    level: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    url:{
        type: DataTypes.STRING,
        allowNull: false,      
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
    modelName: 'SuggestedCertification',
    tableName: 'suggestedcertifications',
    timestamps: true,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "roadmapId",
        using: "BTREE",
        fields: [
          { name: "roadmapId" },
        ]
      },
    ]
  });
  return SuggestedCertification;
};
