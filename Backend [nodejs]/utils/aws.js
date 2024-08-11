require('dotenv').config();
var AWS = require('aws-sdk');

AWS.config.loadFromPath('./config.json');

const s3 = new AWS.S3();

module.exports.uploadUserPictureToS3 = async (picture, key) => {

    // Setting up S3 upload parameters
    const params = {
        Bucket: 'fotisia-user-pictures',
        Key: key, // File name you want to save as in S3
        Body: picture,
        ACL:'public-read'
    };
    
    // Uploading files to the bucket
    let imagedata = {}
    await s3.upload(params, function(err, data) {
        if (err) {
            throw err;
        }
        console.log(data);
        imagedata = data;
    }).promise();

    return imagedata;
}

module.exports.uploadThumbnailToS3 = async (thumbnail, key) => {


    // Setting up S3 upload parameters
    const params = {
        Bucket: 'resume-template-thumbnails',
        Key: key, // File name you want to save as in S3
        Body: thumbnail,
        ACL:'public-read'
    };
    
    // Uploading files to the bucket
    let imagedata = {}
    await s3.upload(params, function(err, data) {
        if (err) {
            throw err;
        }
        console.log(data);
        imagedata = data;
    }).promise();

    return imagedata;
}