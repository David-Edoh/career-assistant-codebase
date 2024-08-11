'use strict';

const { BOOLEAN } = require('sequelize');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('CareerContents', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },

      description: {
        type: Sequelize.TEXT('medium'),
      },

      link: {
        type: Sequelize.TEXT('medium'),
        allowNull:false,
      },

      price: {
        type: Sequelize.STRING,
      },

      imageUrl: {
        type: Sequelize.TEXT('medium'),
        allowNull: true
      },
      
      title: {
        type: Sequelize.TEXT('medium'),
        allowNull: true
      },

      hasCoupon: {
        type: Sequelize.BOOLEAN,
        defaultValue: false
      },

      platform: {
        type: Sequelize.STRING,
      },

      careerSubjectId: {
        type: Sequelize.INTEGER,
      },

      roadmapId: {
        type: Sequelize.INTEGER,
      },

      suggestedCareerId: {
        type: Sequelize.INTEGER,
      },

      userId: {
        type: Sequelize.INTEGER,
        allowNull:false,
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

  async down (queryInterface, Sequelize) {
    /**
     * Add reverting commands here.
     *
     * Example:
    */
    await queryInterface.dropTable('CareerContents');
  }
};
