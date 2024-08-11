module.exports.isValidCareerSuggestionJSON = (jsonString) => {
  try {
    const careerJSON = JSON.parse(jsonString);
    
    if (!Array.isArray(careerJSON)) {
        return false;
    }

    for (const career of careerJSON) {
        if (
            !career.hasOwnProperty("career_field") ||
            !career.hasOwnProperty("career_description") ||
            !career.hasOwnProperty("roadmap") ||
            !career.hasOwnProperty("subjects") ||
            !Array.isArray(career.subjects) ||
            career.subjects.length < 1
        ) {
            return false;
        }

        for (const subject of career.subjects) {
            if (
                !subject.hasOwnProperty("option") ||
                !subject.hasOwnProperty("description") ||
                !subject.hasOwnProperty("level") ||
                !subject.hasOwnProperty("learning_duration") ||
                !subject.hasOwnProperty("search_query")
            ) {
                return false;
            }
        }
    }

    return true;
  } catch (error) {
    console.error('Suggested GPT JSON is not valid:', error);
    return false;
  }
}

  module.exports.isValidSubjectSuggestionJSON = (jsonString) => {
    try {
        if (typeof jsonString !== 'string') {
            throw new Error('Input is not a valid JSON string.');
        }

        const data = JSON.parse(jsonString);

        if (!Array.isArray(data)) {
            console.error('JSON is not an array.');
            return false;
        }

        for (const item of data) {
            if (
                !item.hasOwnProperty('option') ||
                !item.hasOwnProperty('description') ||
                !item.hasOwnProperty('level') ||
                !item.hasOwnProperty('learning_duration') ||
                !item.hasOwnProperty('search_query')
            ) {
                console.error('Invalid JSON structure for one or more items.');
                return false;
            }
        }

        return true;
    } catch (error) {
        console.log('JSON is invalid.');
        console.error('Error validating JSON:', error.message);
        return false;
    }
};

module.exports.validateOpportunityJSON = (jsonString) => {
    try {
        const parsedData = JSON.parse(jsonString);

        if (!Array.isArray(parsedData)) {
            return false; // Not an array
        }

        for (const item of parsedData) {
            if (typeof item !== 'object' ||
                item === null ||
                !('opportunity' in item) ||
                !('search_query' in item)
            ) {
                return false; // Invalid object structure
            }
        }

        return true; // Valid JSON structure
    } catch (error) {
        return false; // JSON parsing error
    }
}

module.exports.validateEventsJSON = (jsonString) =>  {
    try {
        const jsonArray = JSON.parse(jsonString);

        if (!Array.isArray(jsonArray)) {
            return false; // Not an array
        }

        for (const obj of jsonArray) {
            if (
                !obj.hasOwnProperty('event') ||
                !obj.hasOwnProperty('description') ||
                !obj.hasOwnProperty('search_query') ||
                obj.event.trim() === '' ||
                obj.description.trim() === '' ||
                obj.search_query.trim() === ''
            ) {
                return false; // Invalid object in the array
            }
        }

        return true; // Valid JSON array
    } catch (error) {
        return false; // Invalid JSON format
    }
}


module.exports.getTodaysDateString = () => {
    // Get today's date
    let today = new Date();
  
    // Subtract 1 day
    let yesterday = new Date(today);
    yesterday.setDate(today.getDate());
  
    // Format the date to YYYY-MM-DD
    let yyyy = yesterday.getFullYear();
    let mm = String(yesterday.getMonth() + 1).padStart(2, '0'); // January is 0!
    let dd = String(yesterday.getDate()).padStart(2, '0');
  
    // Return the formatted date string
    return `${yyyy}-${mm}-${dd}`;
  }

  module.exports.getStartDateString = () => {
    // Get today's date
    let today = new Date();
  
    // Subtract 1 day
    let yesterday = new Date(today);
    yesterday.setDate(today.getDate() - 7);
  
    // Format the date to YYYY-MM-DD
    let yyyy = yesterday.getFullYear();
    let mm = String(yesterday.getMonth() + 1).padStart(2, '0'); // January is 0!
    let dd = String(yesterday.getDate()).padStart(2, '0');
  
    // Return the formatted date string
    return `${yyyy}-${mm}-${dd}`;
  }

  module.exports.cleanDynamicJsonString = (input) => {
    let jsonArrayString;
    
    // Step 1: Check for markdown delimiters and extract the JSON array part
    const jsonArrayMatch = input.match(/```json\s*([\s\S]*?)\s*```/);
    
    if (jsonArrayMatch && jsonArrayMatch[1]) {
        jsonArrayString = jsonArrayMatch[1];
    } else {
        // If the input doesn't have markdown delimiters, assume it's a plain JSON string
        jsonArrayString = input;
    }

    // Step 2: Parse the JSON string into a JavaScript array
    try {
        const jsonArray = JSON.parse(jsonArrayString);
        return jsonArray;
    } catch (error) {
        console.error("Failed to parse JSON array:", error);
        console.log(input);
        return null;
    }
}

module.exports.cleanDynamicArrayString = (input) => {
    try {
        let jsonArrayString;
    
        // Step 1: Check for markdown delimiters and extract the JSON array part
        const jsonArrayMatch = input.match(/```json\s*\n*([\s\S]*?)\n*```/s);
        
        if (jsonArrayMatch && jsonArrayMatch[1]) {
            jsonArrayString = jsonArrayMatch[1];
        } else {
            // If the input doesn't have markdown delimiters, assume it's a plain JSON string
            jsonArrayString = input;
        }

        // Step 2: Parse the JSON string into a JavaScript array
        try {
            const jsonArray = JSON.parse(jsonArrayString);
            return jsonArray;
        } catch (error) {
            console.error("Failed to parse JSON array:", error);
            console.log(input);
            return [];
        }
    } catch (error) {
        console.log(input);
        throw error
    }
}
  
module.exports.removeEmojis = (text) => {
    // remove astericks
    let cleanedText = text.replace(/\*/g, '');


    // Regular expression to match all types of emojis
    const emojiRegex = /[\u{1F600}-\u{1F64F}]/gu; // Emoticons
    const emojiSymbols = /[\u{1F300}-\u{1F5FF}]/gu; // Miscellaneous Symbols and Pictographs
    const emojiTransport = /[\u{1F680}-\u{1F6FF}]/gu; // Transport and Map Symbols
    const emojiMisc = /[\u{2600}-\u{26FF}]/gu; // Miscellaneous Symbols
    const emojiDingbats = /[\u{2700}-\u{27BF}]/gu; // Dingbats
    const emojiSupplement = /[\u{1F900}-\u{1F9FF}]/gu; // Supplemental Symbols and Pictographs
    const emojiFlags = /[\u{1F1E0}-\u{1F1FF}]/gu; // Flags (iOS)
  
    const combinedRegex = new RegExp(
      emojiRegex.source + "|" + 
      emojiSymbols.source + "|" +
      emojiTransport.source + "|" +
      emojiMisc.source + "|" +
      emojiDingbats.source + "|" +
      emojiSupplement.source + "|" +
      emojiFlags.source,
      'gu'
    );
  

    // Replace all emojis with an empty string
    return cleanedText.replace(combinedRegex, '');
  }

module.exports.validateRoadmapJson = (jsonString) => {
    try {
        const data = JSON.parse(jsonString);

        if (!data.hasOwnProperty('roadmap') ||
            !data.hasOwnProperty('career_field') ||
            !data.hasOwnProperty('career_description') ||
            !data.hasOwnProperty('salary_range') ||
            !data.hasOwnProperty('subjects') ||
            !Array.isArray(data.subjects)) {
            return false;
        }

        for (const subject of data.subjects) {
            if (!subject.hasOwnProperty('option') ||
                !subject.hasOwnProperty('description') ||
                !subject.hasOwnProperty('level') ||
                !subject.hasOwnProperty('learning_duration') ||
                !subject.hasOwnProperty('search_query')) {
                return false;
            }
        }

        return true;
    } catch (error) {
        return false;
    }
}