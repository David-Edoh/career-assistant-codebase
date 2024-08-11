 'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    //posts
    queryInterface.addConstraint('posts',{
      fields:['userId'],
      type:'foreign key',
      name:'post_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    // comments
    queryInterface.addConstraint('Comments',{
      fields:['userId'],
      type:'foreign key',
      name:'comment_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('Comments',{
      fields:['postId'],
      type:'foreign key',
      name:'comment_post_association',
      references:{
        table:'posts',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    // reactions
    queryInterface.addConstraint('Reactions',{
      fields:['userId'],
      type:'foreign key',
      name:'reaction_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('Reactions',{
      fields:['postId'],
      type:'foreign key',
      name:'reaction_post_association',
      references:{
        table:'posts',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    
    //releationships
    queryInterface.addConstraint('relationships',{
      fields:['firstUserId'],
      type:'foreign key',
      name:'relationships_firstUser_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('relationships',{
      fields:['secondUserId'],
      type:'foreign key',
      name:'relationships_secondUser_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    //chats
    queryInterface.addConstraint('chats',{
      fields:['senderUserId'],
      type:'foreign key',
      name:'chats_senderUserId_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('chats',{
      fields:['reciverUserId'],
      type:'foreign key',
      name:'chats_reciverUserId_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    //groupusers
    queryInterface.addConstraint('groupusers',{
      fields:['userId'],
      type:'foreign key',
      name:'groupusers_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('groupusers',{
      fields:['groupId'],
      type:'foreign key',
      name:'groupusers_group_association',
      references:{
        table:'groups',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    //groupposts
    queryInterface.addConstraint('groupposts',{
      fields:['groupUserId'],
      type:'foreign key',
      name:'groupposts_groupUser_association',
      references:{
        table:'GroupUsers',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('groupposts',{
      fields:['groupId'],
      type:'foreign key',
      name:'groupposts_group_association',
      references:{
        table:'groups',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('groupposts',{
      fields:['postId'],
      type:'foreign key',
      name:'groupposts_post_association',
      references:{
        table:'posts',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });

    queryInterface.addConstraint('suggestedcareers',{
      fields:['userId'],
      type:'foreign key',
      name:'suggestedcareer_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });

    
    queryInterface.addConstraint('roadmaps',{
      fields:['suggestedCareerId'],
      type:'foreign key',
      name:'roadmaps_suggested_career_association',
      references:{
        table:'suggestedcareers',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });

    queryInterface.addConstraint('roadmaps',{
      fields:['userId'],
      type:'foreign key',
      name:'roadmaps_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });

    queryInterface.addConstraint('careersubjects',{
      fields:['roadmapId'],
      type:'foreign key',
      name:'careersubjects_roadmap_association',
      references:{
        table:'roadmaps',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });

    queryInterface.addConstraint('careersubjects',{
      fields:['userId'],
      type:'foreign key',
      name:'careersubjects_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });

    queryInterface.addConstraint('careercontents',{
      fields:['careerSubjectId'],
      type:'foreign key',
      name:'careercontent_career_SubjectId_association',
      references:{
        table:'careersubjects',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('careercontents',{
      fields:['roadmapId'],
      type:'foreign key',
      name:'careercontent_roadmap_association',
      references:{
        table:'roadmaps',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('careercontents',{
      fields:['suggestedCareerId'],
      type:'foreign key',
      name:'careercontent_suggested_career_association',
      references:{
        table:'suggestedcareers',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('careercontents',{
      fields:['userId'],
      type:'foreign key',
      name:'careercontent_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('opportunities',{
      fields:['userId'],
      type:'foreign key',
      name:'opportunities_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('events',{
      fields:['userId'],
      type:'foreign key',
      name:'events_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('links',{
      fields:['opportunityId'],
      type:'foreign key',
      name:'links_opportunity_association',
      references:{
        table:'opportunities',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('links',{
      fields:['eventId'],
      type:'foreign key',
      name:'links_events_association',
      references:{
        table:'events',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('streaks',{
      fields:['userId'],
      type:'foreign key',
      name:'Streaks_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('streaks',{
      fields:['careerId'],
      type:'foreign key',
      name:'suggestedcareer_streak_association',
      references:{
        table:'suggestedcareers',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('schedules',{
      fields:['userId'],
      type:'foreign key',
      name:'schedules_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('schedules',{
      fields:['streakId'],
      type:'foreign key',
      name:'schedules_streak_association',
      references:{
        table:'streaks',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('progress',{
      fields:['userId'],
      type:'foreign key',
      name:'progress_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('progress',{
      fields:['streakId'],
      type:'foreign key',
      name:'progress_streak_association',
      references:{
        table:'streaks',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('progress',{
      fields:['careerSubjectId'],
      type:'foreign key',
      name:'progress_subject_association',
      references:{
        table:'careersubjects',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('userresumedetails',{
      fields:['userId'],
      type:'foreign key',
      name:'userresumedetails_user_association',
      references:{
        table:'users',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    
    queryInterface.addConstraint('educations',{
      fields:['userResumeDetailId'],
      type:'foreign key',
      name:'education_userResumeDetail_association',
      references:{
        table:'userresumedetails',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('experiences',{
      fields:['userResumeDetailId'],
      type:'foreign key',
      name:'experience_userResumeDetail_association',
      references:{
        table:'userresumedetails',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('suggestedprojects',{
      fields:['roadmapId'],
      type:'foreign key',
      name:'roadmap_project_association',
      references:{
        table:'roadmaps',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    queryInterface.addConstraint('suggestedcertifications',{
      fields:['roadmapId'],
      type:'foreign key',
      name:'roadmap_certification_association',
      references:{
        table:'roadmaps',
        field:'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
    // queryInterface.addConstraint('groupposts',{
    //   fields:['userId'],
    //   type:'foreign key',
    //   name:'groupposts_user_association',
    //   references:{
    //     table:'Posts',
    //     field:'id'
    //   },
    //   onUpdate: 'CASCADE',
    //   onDelete: 'CASCADE'
    // });
  },

  async down (queryInterface, Sequelize) {
    //posts
    await queryInterface.removeConstraint('posts', 'post_user_association');
    //comments
    await queryInterface.removeConstraint('comments', 'comment_user_association');
    await queryInterface.removeConstraint('comments', 'comment_post_association');
    //reactions
    await queryInterface.removeConstraint('Reactions', 'reaction_user_association');
    await queryInterface.removeConstraint('Reactions', 'reaction_post_association');
   
    //relationships
    await queryInterface.removeConstraint('relationships', 'relationships_firstUser_association');
    await queryInterface.removeConstraint('relationships', 'relationships_secondUser_association');
    //chats
    await queryInterface.removeConstraint('chats', 'chats_senderUserId_association');
    await queryInterface.removeConstraint('chats', 'chats_reciverUserId_association');
    //groupusers
    await queryInterface.removeConstraint('groupusers', 'groupusers_user_association');
    await queryInterface.removeConstraint('groupusers', 'groupusers_group_association');
    //groupposts
    await queryInterface.removeConstraint('groupposts', 'groupposts_groupUser_association');
    await queryInterface.removeConstraint('groupposts', 'groupposts_group_association');
    await queryInterface.removeConstraint('groupposts', 'groupposts_post_association');
    // await queryInterface.removeConstraint('groupposts', 'groupposts_user_association');
  }
};
