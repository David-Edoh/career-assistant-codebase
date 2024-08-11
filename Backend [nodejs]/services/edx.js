const axios = require('axios');

const accountSID = process.env.IMPACT_ACCOUNT_SID;
const authToken = process.env.IMPACT_ACCOUNT_AUTH_TOKEN;
const baseUrl = `https://api.impact.com/Mediapartners/${accountSID}`;


// const getEdxCoursesByKeywords = async (keywords, user, career) => {
//     const response = await axios.get(`${baseUrl}/Catalogs/ItemSearch`, {
//         auth: {
//           username: accountSID,
//           password: authToken
//         },
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json'
//         },
//         params: {
//             Keyword: keywords,
//             PageSize: 10,
//             Query: createQueryString(career)
//           }
//       });

//       let courses = []
//       for (let index = 0; index < response.data.Items.length; index++) {
//           const course = response.data.Items[index];
//           courses.push({
//               price: (course.CurrentPrice && course.CurrentPrice != "" && parseFloat(course.CurrentPrice) != NaN) ? parseFloat(course.CurrentPrice) : 0,
//               link: course.CatalogItemId, //course.Url is proper for affiliate link
//               imageUrl: course.ImageUrl,
//               title: course.Name,
//               description: course.Description,
//               userId: user.id,
//               platform: "Edx",
//           })
//       }

//       return courses;
// }

function createQueryString(careerName) {
  // Split the career name into individual words
  const words = careerName.split(' ');

  // Create the query parts for the description
  const descriptionQuery = words.map(word => `Description~'${word}'`).join('OR');

  // Create the query parts for the name
  const nameQuery = words.map(word => `Name~'${word}'`).join('OR');

  // Construct the final query string
  const queryString = `(Description~'course'AND(${descriptionQuery}OR${nameQuery}))`;

  return queryString;
}

module.exports = {
    getEdxCoursesByKeywords,
}