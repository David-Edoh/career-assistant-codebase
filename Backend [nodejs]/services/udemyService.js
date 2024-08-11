const axios = require('axios');
const { Worker, workerData } = require('worker_threads')


// Concatenate client ID and client secret with a colon
const authString = `${process.env.UDEMY_CLIENT_ID}:${process.env.UDEMY_CLIENT_SECRET}`;

// Convert the concatenated string to Base64
const base64AuthString = Buffer.from(authString).toString('base64');

const getUdemyCoursesByKeywords = async (keywords, user) =>  {
    const header = {
        "Accept": "application/json, text/plain, */*",
        "Authorization": `Basic ${base64AuthString}`,
        "Content-Type": "application/json"
      }

      let config = {
        method: 'get',
        maxBodyLength: Infinity,
        url: `https://www.udemy.com/api-2.0/courses/?page=1&page_size=10&search=${encodeURIComponent(keywords)}&is_affiliate_agreed=True&language=en&has_simple_quiz=True&ordering=price-high-to-low`,
        headers: header
    };
  
    const response = await axios.request(config);

    let courses = []
    for (let index = 0; index < response.data.results.length; index++) {
        const course = response.data.results[index];
        courses.push({
            price: course.price_detail.amount,
            link: `https://udemy.com${course.url}`,
            imageUrl: course.image_240x135,
            title: course.title,
            description: course.headline,
            userId: user.id,
            platform: "Udemy",
        })
    }

    return courses;
}


const getFreeAndCouponCourses = async (subjects, user) => {
    let data = []
    for (let index = 0; index < subjects.length; index++) {
        const element = subjects[index];
        data.push({
            userId: subjects[index].userId,
            subject: subjects[index].subject,
            id: subjects[index].id
        })
    }
    try {
        let worker = new Worker('./services/udemyCouponWorker.js', {workerData: {subjects: data, user: {id: user.id, fcmToken: user.fcmToken}}})
    
        worker.on('message', (couponCourses)=>{
            // console.log(couponCourses);
        })
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    getUdemyCoursesByKeywords,
    getFreeAndCouponCourses
}