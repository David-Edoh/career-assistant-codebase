'use strict';
const { Model } = require('sequelize');


module.exports = (sequelize, DataTypes) => {
  class Streak extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Streak.belongsTo(models.User, { foreignKey: 'userId' });
      Streak.belongsTo(models.SuggestedCareer, { foreignKey: 'careerId' });
      Streak.hasMany(models.Progress, { as: 'progress' });
      Streak.hasMany(models.Schedule, { as: 'schedule' });
    }
  }
  Streak.init({
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    start_date: {
      type: DataTypes.DATE,
      allowNull: true
    },
    end_date: {
      type: DataTypes.DATE,
      allowNull: true
    },
    hasFailed:{
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    recently_won_milestone: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    current_streak: {
      type: DataTypes.INTEGER,
      defaultValue: 0
    },
    current_milestone: {
      type: DataTypes.INTEGER,
      defaultValue: 7
    },
    longest_streak: {
      type: DataTypes.INTEGER,
      defaultValue: 0
    },
  }, {
    sequelize,
    modelName: 'Streak',
    tableName: 'streaks',
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
        name: "careerId",
        using: "BTREE",
        fields: [
          { name: "careerId" },
        ]
      },
    ]
  });
  return Streak;
};
