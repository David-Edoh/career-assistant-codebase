const multer = require('multer');
const path=require('path');
const fs = require('fs');
const { StatusCodes } = require('http-status-codes');
const multerS3 = require('multer-s3')


var AWS = require('aws-sdk');
AWS.config.loadFromPath('./config.json');
const s3 = new AWS.S3();

// const upload = multer({
//   storage: multerS3({
//       s3: s3,
//       acl: 'public-read',
//       bucket: 'fotisia-users-posts-media',
//       key: function (req, file, cb) {
//         cb(null, path.basename(file.originalname) + '-' + Date.now() + path.extname(file.originalname));
//       }
//   })
// });

const upload = multer({

  storage: multerS3({
      s3: s3,
      acl: 'public-read',
      bucket: 'fotisia-users-posts-media',
      metadata: (req, file, callBack) => {
          callBack(null, { fieldName: file.fieldname })
      },
      key: (req, file, callBack) => {
          callBack(null, path.basename(file.originalname) + '-' + Date.now() + path.extname(file.originalname))
      }
  }),
  limits: { fileSize: 5000000 }, // In bytes: 5000000 bytes = 5 MB
  // fileFilter: function (req, file, cb) {
  //     checkFileType(file, cb);
  // }
});

const uploadImage = async(req, res, next) => {

    // await createDirectoryIfNotExists(dirPath);
    upload.array('photos', 10)(req, res, (err) => {
        if (err instanceof multer.MulterError) {
          return res.status(StatusCodes.BAD_REQUEST).json({ error: err.message });
        } else if (err) {
          console.log(err);
          return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({ error: err.message });
        }
        next();
    });
};

module.exports=uploadImage;

