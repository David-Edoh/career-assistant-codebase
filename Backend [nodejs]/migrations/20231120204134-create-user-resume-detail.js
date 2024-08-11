'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    /**
     * Add altering commands here.
     *
     * Example:
     * await queryInterface.createTable('users', { id: Sequelize.INTEGER });
     */
    await queryInterface.createTable('userresumedetails', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      email: {
        type: Sequelize.STRING,
        allowNull:false,
        validate:{
          isEmail:true
        }
      },
      firstName: {
        type: Sequelize.STRING
      },
      lastName: {
        type: Sequelize.STRING
      },
      preferredDesignation: {
        type: Sequelize.STRING
      },
      address: {
        type: Sequelize.STRING
      },
      phoneNumber: {
        type: Sequelize.STRING
      },
      about: {
        type: Sequelize.TEXT("medium")
      },
      picturePath: {
        type: Sequelize.STRING
      },
      gender: {
        type: Sequelize.STRING,
        validate:{
          isIn:[ ['male' , 'female']]
        }
      },
      birthday: {
        type: Sequelize.DATE
      },
      country: {
        type: Sequelize.STRING
      },
      employmentStatus: {
        type: Sequelize.STRING,
      },
      educationLevel: {
        type: Sequelize.STRING,
      },
      specialization: {
        type: Sequelize.STRING,
      },
      careerGoal: {
        type: Sequelize.STRING,
      },
      keyStrength: {
        type: Sequelize.STRING,
      },
      skills: {
        type: Sequelize.TEXT("medium"),
        allowNull: false,
      },
      references: {
        type: Sequelize.TEXT("medium"),
        allowNull: false,
      },
      projects: {
        type: Sequelize.TEXT("medium"),
        allowNull: false,
      },
      trainings_courses_certifications: {
        type: Sequelize.TEXT("medium"),
        allowNull: false,
      },
      hobbies: {
        type: Sequelize.TEXT("medium"),
        allowNull: false,
      },
      disability: {
        type: Sequelize.STRING,
        allowNull:true,
      },
      socials: {
        type: Sequelize.TEXT("medium"),
        allowNull: false,
      },
      website: {
        type: Sequelize.STRING,
      },
      userId: {
        type: Sequelize.INTEGER,
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
    await queryInterface.dropTable('userresumedetails');
  }
};
