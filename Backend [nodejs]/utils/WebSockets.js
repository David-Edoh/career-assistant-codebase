const axios = require('axios');
const path=require('path');
const {User}=require(path.join(__dirname,'..','models'));
const { getGeminiVoiceCallResponse } = require("../services/gemini");
const { execSync } = require('child_process');


async function getOpenAIResponse(text, socket) {
  try {
    const requestData = {
      model: "tts-1-hd",
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


    const base64Chunk = Buffer.from(response.data).toString('base64');
    socket.emit('audioData', base64Chunk);
    socket.emit('audioDataEnd', base64Chunk);

    // let audioChunks = [];

    // response.data.on('data', (chunk) => {
    //   audioChunks.push(chunk);
    //   const base64Chunk = Buffer.from(chunk).toString('base64');
    //   socket.emit('audioData', base64Chunk);
    // });

    // response.data.on('end', () => {
    //   const completeBuffer = Buffer.concat(audioChunks);
    //   const completeBase64 = completeBuffer.toString('base64');
    //   socket.emit('audioDataEnd', completeBase64);
    // });
    console.log("Sia responded");
  } catch (error) {
    console.log(error);
    console.log("Attempting to use google tts");
    await getGoogleTTSResponse(text, socket);
  }
}

async function getGoogleTTSResponse(text, socket) {
    const requestData = {
      "audioConfig": {
        "audioEncoding": "MP3",
        "effectsProfileId": ["small-bluetooth-speaker-class-device"],
        "pitch": 0,
        "speakingRate": 1
      },
      "input": {
        "text": text
      },
      "voice": {
        "languageCode": "en-US",
        "name": "en-US-Journey-F" //en-US-Standard-A, en-US-Journey-F
      }
    };

    const response = await axios.post(`https://texttospeech.googleapis.com/v1/text:synthesize?key=${process.env.GOOGLE_CLOUD_TEXT_TO_SPEECH_API_KEY}`, requestData);

    const audioData = response.data.audioContent;

    // Emit the audio data to the client
    socket.emit('audioData', audioData);

    socket.emit('audioDataEnd', audioData);
    console.log("Sia responded");
}

class WebSockets {
  users = [];
  connection = (socket) => {
    console.log('New client connected');

    socket.on("disconnect", async () => {
      console.log('Client disconnected');
      this.users = this.users.filter((user) => user.socketId !== socket.id);
    });

    socket.on("identity", async (user) => {
      this.users.push({
        socketId: socket.id,
        userId: user,
      });

      let friends = await User.findOne({ _id: user }, { _id: 0, followers: 1 });
      friends = friends.followers?.map((friend) => friend.userId);
      const toSend = this.users.filter((user) => friends.includes(user.userId));
      console.log(toSend);

      toSend.forEach((element) => {
        global.io.to(element.socketId).emit("loggedIn", user);
      });
    });

// Listen for the 'message' event on the socket
socket.on('message', async (data) => {
  try {
    // Parse the incoming data
    const { message, history, useOpenAI } = JSON.parse(data);

    // Get the response from Gemini
    const geminiResponse = await getGeminiVoiceCallResponse(message, history);

    // Log the response for debugging
    console.log(geminiResponse);

    // Use OpenAI's Text-to-Speech API (Currently supports streaming)
    // let audioData = await getOpenAIResponse(geminiResponse, socket);

    // Use Google's Text-to-Speech API
    let audioData = await getGoogleTTSResponse(geminiResponse, socket);

    // Emit the audio data to the client
    // socket.emit('audioData', audioData);

    // Send the text response back to the client
    socket.send({ message: geminiResponse });

  } catch (error) {
    // Log the error and emit an error message to the client
    console.error('Error processing the message:', error);
    socket.emit('error', 'Failed to process the message.');
  }
});

    
    socket.on("logout", async (user) => {
      this.users = this.users.filter((user) => user.socketId !== socket.id);
      let friends = await User.findOne({ _id: user }, { _id: 0, followers: 1 });
      friends = friends.followers?.map((friend) => friend.userId);
      const toSend = this.users.filter((user) => friends.includes(user.userId));

      toSend.forEach((element) => {
        global.io.to(element.socketId).emit("logout", user);
      });
    });
  };
}

module.exports = new WebSockets();
