const nodemailer = require('nodemailer')

const template = `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email from backend</title>
</head>
<body>
    <h1>Email from Sia backend</h1>
</body>
</html>
`

const transport = nodemailer.createTransport({
    host: 'mail.fotisia.com',
    port: 465,
    secure: true,
    tls: {
        rejectUnauthorized: false,
        // minVersion: "TLSv1.2"
    },
    auth: {
        user: process.env.COMPANY_EMAIL_USER,
        pass: process.env.COMPANY_EMAIL_PASSWORD,
    }
})

const sendMail = async (from, to, subject, message) => {
    const info = await transport.sendMail({
        from: from,
        to: to,
        subject: subject,
        text: message
    })

    console.log(`Message sent: ${info.messageId}`);
}

const setupForgetPasswordHTML = (userId) => {

}

module.exports = {
    sendMail,
    setupForgetPasswordHTML,
}


