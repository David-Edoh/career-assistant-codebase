const cron = require('node-cron');
const axios = require('axios');
const { Worker, workerData } = require('worker_threads')


async function myTask() {
  try {
        console.log("cron triggered...");
        let worker = new Worker('./cron/worker.js')

        worker.on('message', (data)=>{
            // console.log(couponCourses);
        })
    } catch (error) {
      console.error('Error running cron worker:', error);
    }
}

cron.schedule('0 * * * *', myTask);

console.log('Cron job scheduled: running task every hour');
