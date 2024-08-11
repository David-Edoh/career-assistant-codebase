'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('CareerSubjects', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },

      level: {
        type: Sequelize.STRING,
        allowNull:false,
      },

      description: {
        type: Sequelize.TEXT('medium'),
        allowNull:false,
      },

      learningDuration: {
        type: Sequelize.STRING,
        allowNull:false,
      },

      subject: {
        type: Sequelize.STRING,
        allowNull:false,
      },
      completed: {
        type: Sequelize.BOOLEAN,
        allowNull:false,
        defaultValue: false,
      },
      roadmapId: {
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
     * await queryInterface.dropTable('users');
     */
    await queryInterface.dropTable('CareerSubjects');
  }
};
