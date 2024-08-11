'use strict';
const { Model } = require('sequelize');


module.exports = (sequelize, DataTypes) => {
  class CareerContent extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      CareerContent.belongsTo(models.CareerSubject, { as: 'careersubject', foreignKey: 'careerSubjectId' });
    }
  }
  CareerContent.init({
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
    link: {
      type: DataTypes.STRING(200),
      allowNull: false
    },
    imageUrl: {
      type: DataTypes.TEXT(''),
      allowNull: true
    },
    title: {
      type: DataTypes.TEXT(''),
      allowNull: true
    },
    price: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    
    hasCoupon: {
      type: DataTypes.BOOLEAN,
      defaultValue: false
    },

    platform: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    roadmapId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'Roadmap',
        key: 'id'
      }
    },
    suggestedCareerId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'SuggestedCareer',
        key: 'id'
      }
    },
    userId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'User',
        key: 'id'
      }
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
    modelName: 'CareerContent',
    tableName: 'careercontents',
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
        name: "careerSubjectId",
        using: "BTREE",
        fields: [
          { name: "careerSubjectId" },
        ]
      },
      {
        name: "roadmapId",
        using: "BTREE",
        fields: [
          { name: "roadmapId" },
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
  return CareerContent;
};
