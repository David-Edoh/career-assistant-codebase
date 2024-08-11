'use strict';
const { Model } = require('sequelize');


module.exports = (sequelize, DataTypes) => {
  class Schedule extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Schedule.belongsTo(models.User, { foreignKey: 'userId' });
      Schedule.belongsTo(models.Streak, { foreignKey: 'streakId' });
    }
  }
  Schedule.init({
    id:{
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
      type: DataTypes.INTEGER
    },
      // Days of the week
  monday: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  tuesday: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  wednesday: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  thursday: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  friday: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  saturday: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  sunday: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  // Start time and end time
  startTime: {
    type: DataTypes.TIME,
    allowNull: false,
  },
  endTime: {
    type: DataTypes.TIME,
    allowNull: false,
  },
  }, {
    sequelize,
    modelName: 'Schedule',
    tableName: 'schedules',
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
    ]
  });
  return Schedule;
};
