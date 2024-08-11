const { parentPort, workerData } = require('worker_threads')
const path=require('path');
const axios = require('axios');
const { CareerContent, User, Roadmap, SuggestedCareer } = require(path.join(__dirname,'..','models'));
const { notifyUser } = require('../utils/Notifyer');
const { Op } = require('sequelize');

const header = {
    "Accept": "application/json, text/plain, */*",
    "Content-Type": "application/json"
}


const getFreeCourses = async () => {
    // fetch users created at this hour.
    // Get the current date and hour.
    const now = new Date();
    const startOfHour = new Date(now.getFullYear(), now.getMonth(), now.getDate(), now.getHours(), 0, 0);
    const endOfHour = new Date(now.getFullYear(), now.getMonth(), now.getDate(), now.getHours(), 59, 59, 999);
    
    const users = await User.findAll({
      where: {
        createdAt: {
          [Op.between]: [startOfHour, endOfHour]
        }
      }
    });
    
    // loop through users and get the roadmap of these users
    for (let userIndex = 0; userIndex < users.length; userIndex++) {
        const user = users[userIndex];
        const activeCareerPath = await CareerContent.findOne({userId: user.id, isActive: true})

        // fetch new coupon courses and alert user through push notification.
        let couponCount = 0;
        for (let subjectIndex = 0; subjectIndex < activeCareerPath.roadmap.careersubject.length; subjectIndex++) {
            const subject = activeCareerPath.roadmap.careersubject[subjectIndex];

            // delete free careercontent older than 4 days that hasCoupon
            let careerContentWithExpiredCoupon = []
            for (let careerContentIndex = 0; careerContentIndex < subject.careercontents.length; careerContentIndex++) {
                const careercontent = subject.careercontents[careerContentIndex];
                careerContentWithExpiredCoupon.push(careercontent.dataValues.id)
            }

            // Calculate the date 4 days ago
            const fourDaysAgo = new Date();
            fourDaysAgo.setDate(fourDaysAgo.getDate() - 4);
            
            await CareerContent.destroy({ where: { 
                id: careerContentWithExpiredCoupon,
                createdAt: {
                    [Op.lt]: fourDaysAgo
                  }
             }})

            
            // fetch free courses for this subject
            let config = {
                method: 'get',
                maxBodyLength: Infinity,
                url: `${process.env.FORTISIA_GPT_API_BASE_URL}/fetch_coupons?keywords=${subject.subject}`,
                headers: header
            };
    
            const response = await axios.request(config);
        
            // save the newly found free courses to the db with the right subjectId and userId
            let courses = []
            for (let index = 0; index < response.data.coupon_courses.length; index++) {
                const course = response.data.coupon_courses[index];
                courses.push({
                    price: 0,
                    hasCouon: true,
                    description: '',
                    link: course,
                    userId: subject.userId,
                    subjectId: subject.id,
                    platform: "Udemy",
                })
            }
            
            if(courses.length)
            {
                CareerContent.bulkCreate(courses)
                couponCount++
            }
        }
    
        if(couponCount){
            // notify user
            notifyUser(user.fcmToken, "Fotisia: Limited-Time Career Offer", "Exclusive free course coupons in your field available now! Grab these free course coupons in your field to advance your career before they’re gone.", { notification: { type: 'NEW-COUPON-COURSE', userId: user.id, targetUserId: user.id} });
        }
    }    
}

getFreeCourses();
