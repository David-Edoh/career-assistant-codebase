const { GoogleGenerativeAI } = require("@google/generative-ai");
const axios = require('axios');
const { EQ, resumeEditorSystemInstruction, voiceChatSystemInstruction, streakScoreSystemInstruction } = require('../utils/prompts')
const { removeEmojis, cleanDynamicArrayString, cleanDynamicJsonString, getStartDateString, getTodaysDateString } = require('../utils/misc')
const genAI = new GoogleGenerativeAI(process.env.GOOGLE_AI_STUDIO_API_KEY);



const scoreStreak = async (message, history) => {
  try {
    const model = genAI.getGenerativeModel({
      model: "gemini-1.5-pro",
      systemInstruction: streakScoreSystemInstruction,
    });

    const chat = model.startChat({
        history: history
    });

    const result = await chat.sendMessage(message);
    const response = await result.response;
    const text = removeEmojis(response.text());
    
    return cleanDynamicJsonString(text);
  } catch (error) {
    console.error(error);
    throw error;
  }
};

const getGeminiVoiceCallResponse = async (message, history) => {
    try {
        const model = genAI.getGenerativeModel({
          model: "gemini-1.5-flash",
          systemInstruction: voiceChatSystemInstruction,
        });

        const chat = model.startChat({
            history:history, 
            generationConfig: {
                maxOutputTokens: 250,
            },
        });

        const result = await chat.sendMessage(message);
        const response = await result.response;
        const text = removeEmojis(response.text());
      
      return text;
    } catch (error) {
      console.error(error);
      return "Uhm, Sorry. I had some technical issues understanding your last message. can you repeat your last message please?";
    }
  };


  const hearFromGemini = async (prompt) => {
    const response = await geminiWithInstructions(prompt);
    const audioData = await getOpenAIResponse(response);
    return audioData;
  }

  async function getOpenAIResponse(text) {
    try {
      const requestData = {
        model: "tts-1",
        input: text,
        voice: 'nova', // Specify the "nova" voice
        response_format: "mp3",
      };
    
      const response = await axios.post('https://api.openai.com/v1/audio/speech', requestData, {
        headers: {
          'Authorization': `Bearer ${process.env.OPENAI_API_KEY}`,
        }, 
        responseType: 'arraybuffer',
      });
    
      const buffer = Buffer.from(response.data).toString('base64');
      return buffer;
  
    } catch (error) {
      console.log(error);
    }
  }


const geminiResumeEditor = async (prompt, history) => {
try {
  const model = genAI.getGenerativeModel({ 
    model: "gemini-1.5-pro",
    systemInstruction: resumeEditorSystemInstruction,
  });

  const chat = model.startChat({
    history: history,
});
  
  const result = await chat.sendMessage(prompt);
  const response = await result.response;
  const text = removeEmojis(response.text());

  return text;
} catch (error) {
  console.error(error);
  return "Error getting response from Gemini";
}
};

const geminiWithInstructions = async (prompt) => {
  try {
    const model = genAI.getGenerativeModel({ 
      model: "gemini-1.5-pro",
      systemInstruction: voiceChatSystemInstruction,
    });
    
    const result = await model.generateContent(prompt)

    return removeEmojis(result.response.text());
  } catch (error) {
    console.error(error);
    throw error
  }
};

  const geminiService = async (prompt) => {
    try {
      const model = genAI.getGenerativeModel({ 
        model: "gemini-1.5-pro",
      });
      
      const result = await model.generateContent(prompt)

      return result.response.text();
    } catch (error) {
      console.error(error);
      throw error
    }
  };


  const getNews = async (userResumeDetail) => {
    try {
      const model = genAI.getGenerativeModel({ 
        model: "gemini-1.5-flash",
      });

      prompt = `Here is my career detail in JSON: \n ${userResumeDetail} \n\n Suggest 4 keywords for tools used in my industry, so I can search for updated news related to these tools online. without Explanation Return only an array of keywords string to be used by a frontend web client. e.g ["keyword_1", "keyword_2", "keyword_3"]`
      
      const result = await model.generateContent(prompt)

      const keywords = cleanDynamicArrayString(result.response.text());

      if (!Array.isArray(keywords) || keywords.length === 0) {
        throw new Error('Keywords must be a non-empty array');
      }
        
      const queries = keywords.map((keyword, index) => index != keywords.length - 1 ? `${encodeURIComponent(`${keyword} OR `)}` : `${encodeURIComponent(`${keyword}`)}`);
      
      const url = `https://newsapi.org/v2/everything?q=${queries.join("")}&from=${getStartDateString()}&to=${getTodaysDateString()}&sortBy=popularity&pageSize=50&apiKey=${process.env.NEWS_API_KEY}`;
      const response = await axios.get(url);

      return response.data;
    } catch (error) {
      console.error(error);
      return "Error getting personalized news";
    }
  };

    

module.exports = {
    getGeminiVoiceCallResponse,
    getNews,
    geminiService,
    geminiResumeEditor,
    hearFromGemini,
    scoreStreak
}