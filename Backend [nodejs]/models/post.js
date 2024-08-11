'use strict';
const {Model} = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Post extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
        Post.belongsTo(models.User, { foreignKey: 'userId' });
        Post.hasMany(models.Comment);
        Post.hasMany(models.Reaction);
        Post.hasOne(models.Reaction , {as:'reaction' , foreignKey:'postId' }) ;
        Post.hasOne(models.GroupPost);
    }
  }
  Post.init({
    id:{
      type:DataTypes.INTEGER,
      allowNull:false,
      primaryKey:true,
      autoIncrement:true
    },
    text: DataTypes.STRING,
    heading: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    media: DataTypes.STRING,
    externalUrl: DataTypes.STRING,
    type: {
      type: DataTypes.STRING,
      allowNull:false,
      validate:{
        isIn:[ ['news-article' , 'user-post']]
      }
    },
    state: {
      type: DataTypes.STRING,
      validate:{
        isIn:[ ['public' , 'private']]
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
    modelName: 'Post',
    tableName: 'posts',
  });
  return Post;
};