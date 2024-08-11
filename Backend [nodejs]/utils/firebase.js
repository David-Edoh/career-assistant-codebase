var FCM = require('fcm-node');
var serverKey = require('../config/firebase-push-notification-key.json') //put the generated private key path here    
var fcm = new FCM(serverKey)


const sendPushNotification = (redirectPage, fcmToken, messageHead, messageBody, data) => {
    if(fcmToken){
        try {
            var message = { //this may vary according to the message type (single recipient, multicast, topic, et cetera)
                to: fcmToken, 
                // collapse_key: 'Fotisia',
                
                notification: {
                    title: messageHead, 
                    body: messageBody 
                },
                
                data: {  //you can send only notification or only data(or include both)
                    page: redirectPage,
                }
            }
            
            fcm.send(message, function(err, response){
                if (err) {
                    console.log("Something has gone wrong!")
                    console.log(err);
                } else {
                    console.log("Successfully sent with response: ", response)
                }
            })
        } catch (error) {
            console.log(error);
        }
    }
  };

  module.exports = {
    sendPushNotification
  };