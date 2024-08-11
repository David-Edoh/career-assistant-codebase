'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Posts', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      userId: {
        type: Sequelize.INTEGER,
      },
      text: {
        type: Sequelize.TEXT('long')
      },

      heading:{
        type: Sequelize.STRING,
        allowNull: true,
      },

      state: {
        type: Sequelize.STRING,
        validate:{
          isIn:[ ['public' , 'private']]
        }
      },
  
      media: {
        type: Sequelize.TEXT('medium')
      },
      externalUrl: {
        type: Sequelize.TEXT('long')
      },
      type: {
        type: Sequelize.STRING,
        allowNull:false,
        validate:{
          isIn:[ ['news-article' , 'user-post']]
        }
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue:Sequelize.NOW 
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue:Sequelize.NOW 
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Posts');
  }
};
