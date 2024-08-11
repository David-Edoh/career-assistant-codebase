const { parentPort, workerData } = require('worker_threads')
const path=require('path');
const axios = require('axios');
const { CareerContent } = require(path.join(__dirname,'..','models'));
const { notifyUser } = require('../utils/Notifyer');


const header = {
    "Accept": "application/json, text/plain, */*",
    "Content-Type": "application/json"
}


const getFreeCourses = async () => {
    let couponCount = 0;
    for (let index = 0; index < workerData.subjects.length; index++) {
        const subject = workerData.subjects[index];
        
        // fetch free courses for this subject
        let config = {
            method: 'get',
            maxBodyLength: Infinity,
            url: `${process.env.FORTISIA_GPT_API_BASE_URL}/fetch_coupons?keywords=${subject.subject}`,
            headers: header
        };

        try{
            const response = await axios.request(config);
    
            // save the newly found free courses to the db with the right subjectId and userId
            let courses = []
            for (let index = 0; index < response.data.coupon_courses.length; index++) {
                const course = response.data.coupon_courses[index];
                courses.push({
                    price: 0,
                    hasCoupon: true,
                    description: '',
                    link: course,
                    userId: subject.userId,
                    careerSubjectId: subject.id,
                    platform: "Udemy",
                })
            }
            
            if(courses.length)
            {
                console.log(`Found ${courses.length} coupons for subject: ${subject.subject}`);
                CareerContent.bulkCreate(courses)
                couponCount++
            }
        } catch (e) {
            console.log(e);
        }
        
    }

    if(couponCount){
        // notify user
        notifyUser(workerData.user.fcmToken, "Fotisia: Limited-Time Career Offer", "Exclusive free course coupons in your field available now! Grab these free course coupons in your field to advance your career before they’re gone.", { notification: { type: 'NEW-COUPON-COURSE', userId: workerData.user.id, targetUserId: workerData.user.id} });
    }
}

getFreeCourses()

parentPort.postMessage(workerData.subjects);

