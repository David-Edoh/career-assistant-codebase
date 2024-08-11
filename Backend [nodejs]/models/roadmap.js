'use strict';
const { Model } = require('sequelize');


module.exports = (sequelize, DataTypes) => {
  class Roadmap extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Roadmap.hasMany(models.CareerSubject, { as: 'careersubjects' });
      Roadmap.hasMany(models.SuggestedCertification, { as: 'suggestedcertifications' });
      Roadmap.hasMany(models.SuggestedProject, { as: 'suggestedprojects' });
      Roadmap.belongsTo(models.SuggestedCareer, { foreignKey: 'suggestedCareerId' });
      Roadmap.belongsTo(models.User, { foreignKey: 'userId' });
    }
  }
  Roadmap.init({
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    description: {
      type: DataTypes.STRING(500),
      allowNull: true
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
    modelName: 'Roadmap',
    tableName: 'roadmaps',
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
        name: "suggestedCareerId",
        using: "BTREE",
        fields: [
          { name: "suggestedCareerId" },
        ]
      },
      {
        name: "userId",
        using: "BTREE",
        fields: [
          { name: "userId" },
        ]
      },
    ]
  });
  return Roadmap;
};
