'use strict';
const { Model } = require('sequelize');


module.exports = (sequelize, DataTypes) => {
  class SuggestedCareer extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      SuggestedCareer.hasOne(models.Roadmap, { as: 'roadmap', foreignKey: 'suggestedCareerId' });
      SuggestedCareer.belongsTo(models.User);
    }
  }
  SuggestedCareer.init({
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    career: {
      type: DataTypes.STRING(200),
      allowNull: false
    },
    standAlone: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false
    },
    salary: {
      type: DataTypes.STRING(200),
      allowNull: false
    },
    description: {
      type: DataTypes.STRING(500),
      allowNull: true
    },
    userId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'User',
        key: 'id'
      }
    },
    isActive: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false
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
    modelName: 'SuggestedCareer',
    tableName: 'suggestedcareers',
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
        name: "userId",
        using: "BTREE",
        fields: [
          { name: "userId" },
        ]
      },
    ]
  });
  return SuggestedCareer;
};
