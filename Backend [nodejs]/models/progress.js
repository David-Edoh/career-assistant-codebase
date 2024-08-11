'use strict';
const { Model } = require('sequelize');


module.exports = (sequelize, DataTypes) => {
  class Progress extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Progress.belongsTo(models.User, { foreignKey: 'userId' });
      Progress.belongsTo(models.Streak, { foreignKey: 'streakId' });
      Progress.belongsTo(models.CareerSubject, { foreignKey: 'careerSubjectId' });
    }
  }
  Progress.init({
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    progress_description: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    score:{
      type: DataTypes.INTEGER,
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
    modelName: 'Progress',
    tableName: 'progress',
    timestamps: true,
    indexes: [
      {
        name: "userId",
        using: "BTREE",
        fields: [
          { name: "userId" },
        ]
      },
      {
        name: "streakId",
        using: "BTREE",
        fields: [
          { name: "streakId" },
        ]
      },
      {
        name: "careerSubjectId",
        using: "BTREE",
        fields: [
          { name: "careerSubjectId" },
        ]
      }
    ]
  });
  return Progress;
};
