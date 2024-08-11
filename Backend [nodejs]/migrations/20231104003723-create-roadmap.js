'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('Roadmaps', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },

      description: {
        type: Sequelize.TEXT('medium'),
        allowNull:false,
      },

      suggestedCareerId: {
        type: Sequelize.INTEGER,
        allowNull:false,
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
     * await queryInterface.dropTable('Roadmaps');
     */
    await queryInterface.dropTable('Roadmaps');
  }
};
