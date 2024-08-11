// Importing the WebClient class from the '@slack/web-api' package
const { WebClient } = require('@slack/web-api');

// Loading environment variables from a .env file
require('dotenv').config();

// Async function to send a message to a Slack channel
module.exports.sendSlackBugReportMessage = async (message) => {
    try {
        // Creating a new instance of WebClient with the Slack token from the environment variables
        const webClient = new WebClient(process.env.SLACK_TOKEN);

        // Sending a message to the specified Slack channel
        const result = await webClient.chat.postMessage({
            text: message,
            channel: process.env.SLACK_BUG_REPORT_CHANNEL_ID
        });

        // Logging a success message along with the result object
        console.log('Message sent:', result);
    } catch (error) {
        // Handling errors and logging the details
        console.error('Error:', error);
    }
}

// Async function to send a message to a Slack channel
module.exports.sendSlackNewUserMessage = async (message) => {
    try {
        // Creating a new instance of WebClient with the Slack token from the environment variables
        const webClient = new WebClient(process.env.SLACK_TOKEN);

        // Sending a message to the specified Slack channel
        const result = await webClient.chat.postMessage({
            text: message,
            channel: process.env.SLACK_NEW_USER_CHANNEL_ID
        });

        // Logging a success message along with the result object
        console.log('Message sent:', result);
    } catch (error) {
        // Handling errors and logging the details
        console.error('Error:', error);
    }
}