'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('SuggestedCareers', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },

      career: {
        type: Sequelize.STRING,
        allowNull:false,
      },

      description: {
        type: Sequelize.TEXT('medium'),
      },

      standAlone: {
        type: Sequelize.BOOLEAN,
        defaultValue: false,
        allowNull:false,
      },

      salary: {
        type: Sequelize.STRING,
      },

      userId: {
        type: Sequelize.INTEGER,
        allowNull:false,
      },

      isActive: {
        type: Sequelize.BOOLEAN,
        defaultValue: false,
        allowNull: false
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
     * await queryInterface.dropTable('users');
     */
    await queryInterface.dropTable('SuggestedCareers');
  }
};
