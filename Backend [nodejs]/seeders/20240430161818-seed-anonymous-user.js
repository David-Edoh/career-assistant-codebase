'use strict';

/** @type {import('sequelize-cli').Migration} */
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

      await queryInterface.bulkInsert('users', [
        {
            id: 1,
            username: 'Anonymous',
            email: 'anonymous@fotisia.com',
            firstName: 'Anonymous',
            lastName: 'Person',
            picturePath: 'https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png',
            refreshToken: 'Anonymous',
            createdAt: new Date(),
            updatedAt: new Date()
        },
        {
          id: 2,
          username: 'personalized_newsfeeds',
          email: 'personalized-newsfeeds@fotisia.com',
          firstName: 'News',
          lastName: 'Feeds',
          picturePath: 'https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png',
          refreshToken: 'Anonymous',
          createdAt: new Date(),
          updatedAt: new Date()
      }
    ], {});
  },

  async down (queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
    const Op = Sequelize.Op
    await queryInterface.bulkDelete('users', {id: {[Op.in]: [1]}}, {});
  }
};
