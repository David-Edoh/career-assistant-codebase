'use strict';
const { Model } = require('sequelize');


module.exports = (sequelize, DataTypes) => {
  class CareerSubject extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      CareerSubject.hasMany(models.CareerContent, { as: 'careercontents' });
      CareerSubject.belongsTo(models.Roadmap, { foreignKey: 'roadmapId' });
      CareerSubject.belongsTo(models.User, { foreignKey: 'userId' });
    }
  }
  CareerSubject.init({
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    subject: {
      type: DataTypes.STRING(500),
      allowNull: false
    },
    completed: {
      type: DataTypes.BOOLEAN,
      allowNull:false,
      defaultValue: false,
    },
    description: {
      type: DataTypes.STRING(500),
      allowNull: false
    },
    level: {
      type: DataTypes.STRING(500),
      allowNull: false
    },
    learningDuration: {
      type: DataTypes.STRING(500),
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
    modelName: 'CareerSubject',
    tableName: 'careersubjects',
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
      {
        name: "roadmapId",
        using: "BTREE",
        fields: [
          { name: "roadmapId" },
        ]
      },
    ]
  });
  return CareerSubject;
};
