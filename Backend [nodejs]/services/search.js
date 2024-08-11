const axios = require('axios');


module.exports.search = async (keywords) => {
    try {
        let response = await searchKeywords(keywords, process.env.GOOGLE_GENERAL_SEARCH_ENGINE_ID);
        return response;
    } catch (e) {
        // sendSlackMessage('Error from Fotisia GPT - ⚡🔴🚫: search engine failed handling this request');
        console.error(e);
        throw e
    }
}

module.exports.multipleSearch = async (data) => {
    try {
        const response = [];
        for (const item of data) {
            let result = await searchKeywords(item.search_query, process.env.GOOGLE_GENERAL_SEARCH_ENGINE_ID);
            if(result && result.items && result.items.length){
                response.push({
                    subject: item.option,
                    learningDuration: item.learning_duration,
                    level: item.level,
                    description: item.description,
                    careercontents: result.items ?? []
                });
            }
        }

        return response;
    } catch (e) {
        console.error(e);
        throw e;
    }
}

module.exports.searchEdxCoursesByKeyword = async (subject, user) => {
    try {
        let result = await searchKeywords(subject, process.env.GOOGLE_EDX_SEARCH_ENGINE_ID);

        const skillsCourses = []
        if (result && result.items && result.items.length) {            
            const links = result.items ?? []
            for (const item of links) {
                // imageUrl: null,
                skillsCourses.push({
                    price: 0,
                    link: item.link ?? item.url,
                    title: item.title,
                    description: item.snippet,
                    userId: user.id,
                    platform: "Edx",
                })
            }
        }
        

        return skillsCourses;
    } catch (e) {
        // sendSlackMessage('Error from Fotisia GPT - ⚡🔴🚫: search engine failed handling this request');
        console.error(e);
        throw e;
    }
}

module.exports.getYoutubeCoursesByKeywords = async (skill, user) => {
    try {
        let result = await searchKeywords(skill.name, process.env.GOOGLE_YOUTUBE_SEARCH_ENGINE_ID);

        const skillsCourses = []
        if (result && result.items && result.items.length) {
            const links = result.items ?? []
            for (const item of links) {
                // imageUrl: null,
                skillsCourses.push({
                    price: 0,
                    link: item.link ?? item.url,
                    title: item.title,
                    description: item.snippet,
                    userId: user.id,
                    platform: "YouTube",
                })
            }
        }
        

        return skillsCourses;
    } catch (e) {
        // sendSlackMessage('Error from Fotisia GPT - ⚡🔴🚫: search engine failed handling this request');
        console.error(e);
        throw e;
    }
}

module.exports.multipleOpportunitiesSearch = async (data) => {
    try {
        const response = [];
        for (const item of data) {
            let result = await searchKeywords(item.search_query, process.env.GOOGLE_GENERAL_SEARCH_ENGINE_ID);

            if (result && result.items && result.items.length) {
                response.push({
                    opportunity: item.opportunity,
                    search_query: item.search_query,
                    description: item.description,
                    links: result.items ?? []
                });
            }
        }

        return response;
    } catch (e) {
        // sendSlackMessage('Error from Fotisia GPT - ⚡🔴🚫: search engine failed handling this request');
        console.error(e);
        throw e;
    }
}


module.exports.multipleEventsSearch = async (data) => {
    try {
        const response = [];
        for (const item of data) {
            let result = await searchKeywords(item.search_query, process.env.GOOGLE_GENERAL_SEARCH_ENGINE_ID);

            if (result && result.items && result.items.length) {
                response.push({
                    eventName: item.event,
                    description: item.description,
                    search_query: item.search_query,
                    links: result.items ?? []
                });
            }
        }

        return response;
    } catch (e) {
        // sendSlackMessage('Error from Fotisia GPT - ⚡🔴🚫: search engine failed handling this request');
        console.error(e);
        throw e;
    }
}


const searchKeywords = async (keywords, engine_id) => {
    const query = encodeURIComponent(keywords); // Default query if none is provided

    console.log(query);

    const searchUrl = `https://www.googleapis.com/customsearch/v1?key=${process.env.GOOGLE_SEARCH_API_KEY}&cx=${engine_id}&q=${query}`;
    const response = (await axios.get(searchUrl)).data;
    
    return response;
}