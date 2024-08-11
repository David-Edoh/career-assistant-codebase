'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Users', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      username: {
        type: Sequelize.STRING,
        allowNull:false,
        validate: {
          notNull: {
            message: 'Please enter your username'
          },
          customValidator(username) {
            if (username === "") {
              throw new Error("name can't be empty Please enter your username");
            }
          },
        }
      },
      email: {
        type: Sequelize.STRING,
        allowNull:false,
        unique: {
          args: true,
          message: 'Email address already in use!'
        },
        validate:{
          isEmail:true
        }
      },
      authType:{
        type: Sequelize.STRING,
        allowNull:false,
        defaultValue: "local",
        validate:{
          isIn:[ ['local' , 'Google', 'Linkedin', 'Apple']]
        }
      },
      password: {
        type: Sequelize.STRING,
        allowNull:true,
      },
      firstName: {
        type: Sequelize.STRING
      },
      lastName: {
        type: Sequelize.STRING
      },
      picturePath: {
        type: Sequelize.STRING,
        allowNull: false,
        defaultValue: "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png"
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
      hobbies: {
        type: Sequelize.STRING,
      },
      disability: {
        type: Sequelize.STRING,
      },
      address: {
        type: Sequelize.STRING
      },
      phoneNumber: {
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
      socket_io_id: {
        type: Sequelize.STRING
      },
      fcmToken: {
        type: Sequelize.STRING,
        allowNull: true,
      },
      refreshToken: {
        type: Sequelize.STRING
      },
      resetPasswordToken: {
        type: Sequelize.STRING,
        allowNull: true,
      },
      resetPasswordExpires: {
        type: Sequelize.DATE,
        allowNull: true,
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
    await queryInterface.dropTable('Users');
  }
};