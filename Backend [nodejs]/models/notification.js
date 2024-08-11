'use strict';
const {
  Model
} = require('sequelize');
// const UserPayload = require('./UserPayload');

module.exports = (sequelize, DataTypes) => {
  class Notification extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Notification.belongsTo(models.User, { foreignKey: 'userId' });
      Notification.belongsTo(models.Post, { foreignKey: 'postId' });
    }
  }
  Notification.init({
    id:{
      type: DataTypes.INTEGER,
      allowNull:false,
      primaryKey:true,
      autoIncrement:true
    },

    type: {
      type: DataTypes.STRING,
      required: true,
    },

    targetUserId: {
      type: DataTypes.INTEGER,
      required: true,
      // ref: 'User',
    },

    isSeen: {
      type: DataTypes.BOOLEAN,
      required: true,
      defaultValue: false,
    },
    // currentUser: UserPayload,

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
    modelName: 'Notification',
    tableName: 'notifications',
  });
  return Notification;
};



// const mongoose = require('mongoose');
// const Schema = mongoose.Schema;
// const UserPayload = require('./UserPayload');

// const NotificationtSchema = new Schema(
//   {
//     type: {
//       type: String,
//       required: true,
//     },
//     targetUserId: {
//       type: mongoose.Schema.Types.ObjectId,
//       required: true,
//       ref: 'User',
//     },
//     currentUser: UserPayload,
//     postId: {
//       type: mongoose.Schema.Types.ObjectId,
//       ref: 'Posts',
//     },
//   },
//   { timestamps: true },
// );

// module.exports = mongoose.model('Notification', NotificationtSchema);
