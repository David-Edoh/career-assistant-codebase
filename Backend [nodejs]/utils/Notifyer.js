const WebSockets = require('./WebSockets');
const { sendPushNotification: sendPushNotificationToSingleUser } = require('./firebase')

const notifyUser = (fcmToken, messageHead, messageBody, data) => {
  let redirectPage = "HOME"

  if(data.notification.type == 'NEW-REACTION' || data.notification.type == 'FRIEND-REQUEST' || data.notification.type == 'ACCEPT-FRIEND-REQUEST' || data.notification.type == 'COMMENT'){
    redirectPage = "FEEDS-NOTIFICATION-PAGE"
  }

  if(data.notification.type == 'NEW-COUPON-COURSE'){
    redirectPage = "ROADMAP-PAGE"
  }

  sendPushNotificationToSingleUser(redirectPage, fcmToken, messageHead, messageBody, data)
};


const notifyPost = (fcmToken, messageHead, messageBody, data) => {
  // sendPushNotificationToSingleUser("postNotification", fcmToken, messageHead, messageBody, data)
};


const notifyAllUsers = (messageHead, messageBody) => {
  // sendPushNotificationToAllgleUser(messageHead, messageBody)
};


module.exports = {
  notifyPost,
  notifyUser,
  notifyAllUsers,
};
