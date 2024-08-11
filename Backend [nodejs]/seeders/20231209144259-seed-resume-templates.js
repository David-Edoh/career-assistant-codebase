'use strict';

/** @type {import('sequelize-cli').Migration} */

const fs = require('fs');
const path = require('path');

// Specify the folder path where your .js files are located
const folderPath = path.join(__dirname,'resume_json');  // Update this path

// Function to read and import JSON items from a single .js file
function importJsonFromFile(filePath) {
  try {
    const jsonData = require(filePath);
    return jsonData;
  } catch (error) {
    console.error(`Error importing JSON from ${filePath}: ${error.message}`);
    return null;
  }
}

// Function to read all .js files in a folder, import JSON items, and create an array
function importJsonFromFolder(folderPath) {
  const jsonObjects = [];

  // Read all files in the folder
  const files = fs.readdirSync(folderPath);

  // Iterate through each file
  files.forEach((file) => {
    // Check if the file has a .js extension
    if (path.extname(file) === '.js') {
      const filePath = path.join(folderPath, file);
      const jsonObject = importJsonFromFile(filePath);

      // Add the imported JSON object to the array
      
      if (jsonObject) {
        jsonObjects.push(jsonObject);
      }
    }
  });

  return jsonObjects;
}

// Call the function with the specified folder path
const jsonArray = importJsonFromFolder(folderPath);


module.exports = {
  async up (queryInterface, Sequelize) {
    /**
     * Add seed commands here.
     *
     * Example:
     * await queryInterface.bulkInsert('People', [{
     *   name: 'John Doe',
     *   isBetaMember: false
     * }], {});
    */

     await queryInterface.bulkInsert('resumetemplates', 
     jsonArray, {});
    
  },

  async down (queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
    await queryInterface.bulkDelete('resumetemplates', null, {});
  }
};

