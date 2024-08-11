const path=require('path');
const { StatusCodes } = require('http-status-codes')
const {User, Notification, Streak, Progress, Schedule, SuggestedCareer}=require(path.join(__dirname,'..','models'));
const { notifyPost, notifyUser } = require('../utils/Notifyer');
const { Op, Sequelize } = require('sequelize');
const { startOfDay, endOfDay } = require('date-fns');
const { scoreStreak } = require('../services/gemini');

const createStreak=async(req,res)=> {
    try {
        // check if previous streak exist.
        let  streak = await Streak.findOne({
            where: {
                userId: req.user.id,
            }
        })
        
        if(streak){
            await Streak.update({careerId: req.body.careerId, current_streak: 0, recently_won_milestone: null, current_milestone: 7, longest_streak: 0, hasFailed: false}, {where: {userId: req.user.id,}});
        } else {
            // Create streak with user and roadmap id
             streak = await Streak.create({
                userId: req.user.id,
                careerId: req.body.careerId,
            });
        }

        // deactivate previouly active Career path and activate the requested career path.
        await SuggestedCareer.update({isActive: false}, {where: {userId: req.user.id}})
        await SuggestedCareer.update({isActive: true}, {where: {id: req.body.careerId}})

        // Delete any previous schedule for this user...
        await Schedule.destroy({where: {userId: req.user.id}})

        // Delete any previous progress for this user...
        await Progress.destroy({where: {userId: req.user.id}})

        // Create schedule with streak id and requested days
        await Schedule.create({
            userId: req.user.id,
            streakId: streak.dataValues.id,
            monday: req.body.schedule.monday,
            tuesday: req.body.schedule.tuesday,
            wednesday: req.body.schedule.wednesday,
            thursday: req.body.schedule.thursday,
            friday: req.body.schedule.friday,
            saturday: req.body.schedule.saturday,
            sunday: req.body.schedule.sunday,
            startTime: req.body.schedule.startTime,
            endTime: req.body.schedule.endTime,
        })

        // find and return created streak and related entities
        const createdStreak = await Streak.findOne({
            include:[
                {   
                    model: User,
                    attributes: ['id','username', 'firstName', 'lastName', 'picturePath']    
                },
                {   
                    model: Progress, 
                    as: 'progress',
                },
                {   
                    model: Schedule,
                    as: 'schedule',
                },
            ],
            where: {
                userId: req.user.id
            }
        });

        res.status(StatusCodes.CREATED).json({msg: "Streak created successfully.", streak: createdStreak.dataValues});
    } catch (error) {
        console.log(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("Failed creating streak, server error.");
    }
};

const checkStreak = async (req, res)=> {
    try {
        let startOfDay = new Date();
        startOfDay.setHours(0, 0, 0, 0);

        let endOfDay = new Date();
        endOfDay.setHours(23, 59, 59, 999);

        // find and return created streak and related entities
        let streak = await Streak.findOne({
            include:[
                {   
                    model: User,
                    attributes: ['id','username', 'firstName', 'lastName', 'picturePath']    
                },
                {   
                    model: Progress, 
                    as: 'progress',
                    where: {
                        createdAt: {
                            [Op.gte]: startOfDay,
                            [Op.lt]: endOfDay
                        }
                    }
                },
                {   
                    model: Schedule,
                    as: 'schedule',
                },
            ],
            where: {
                userId: req.user.id
            }
        });

        if(!streak){
            res.status(StatusCodes.NOT_FOUND).json("Streak not found");
        }

        if(!streak.dataValues.progress)
        {
            streak = await Streak.update({hasFailed: true}, {
                where: {
                    userId: req.user.id
                }
            })
        }

        res.status(StatusCodes.OK).json(streak.dataValues);
    } catch (error) {
        console.log(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("Failed fetching streak, server error.");
    }
};


const getStreak = async (req, res)=> {
    try {
        // find and return created streak and related entities
        const streak = await Streak.findOne({
            include:[
                {   
                    model: User,
                    attributes: ['id','username', 'firstName', 'lastName', 'picturePath']    
                },
                {   
                    model: Progress, 
                    as: 'progress',
                },
                {   
                    model: Schedule,
                    as: 'schedule',
                },
            ],
            where: {
                userId: req.user.id
            }
        });

        if(streak){
            res.status(StatusCodes.OK).json(streak.dataValues);
        } else {
            res.status(StatusCodes.NOT_FOUND).json("Streak not found");
        }
        
    } catch (error) {
        console.log(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("Failed fetching streak, server error.");
    }
};

const createProgress = async (req, res) => {
    try {
        // check if progress has been created that day and return error if true.
        const checkProgress = await Progress.findOne({
            where: {
                createdAt: {
                    [Op.between]: [startOfDay(new Date(req.body.todaysDate)), endOfDay(new Date(req.body.todaysDate))]
                },
                userId: req.user.id,
            }
        })

        if(checkProgress){
            res.status(StatusCodes.CONFLICT).json("Failed creating progress, You have recorded your daily progress. Update it to make a change.")
            return
        }
        
        // If progress has not been created, Create a new prorgess.
        const progress = await Progress.create({
            userId: req.user.id,
            streakId: req.body.streakId,
            progress_description: req.body.progressDescription,
            careerSubjectId: req.body.subjectId,
            score: req.body.score,
            createdAt: req.body.currentUsersTime,
        });

        const s = await Streak.findOne({
            where: {
                userId: req.user.id,
                id: req.body.streakId
            }
        })

        let current_streak = s.dataValues.current_streak
        let current_milestone = s.dataValues.current_milestone
        let new_milestone

        if(current_streak + 1 >= current_milestone){
            new_milestone = current_milestone <= 7 ? 14 : Math.floor((current_milestone + 20)/10) * 10
        } else {
            new_milestone = current_milestone
        }

        // Update the users streak, Increase current_streak, check and update longest streak.
        await Streak.update(
            {
                current_streak: Sequelize.literal('current_streak + 1'),
                longest_streak: Sequelize.literal('GREATEST(longest_streak, current_streak)'),
                recently_won_milestone: Sequelize.literal(`CASE WHEN current_streak >= current_milestone THEN current_milestone ELSE recently_won_milestone END`),
                current_milestone: new_milestone
            }, 
            { where: {
            userId: req.user.id,
            id: req.body.streakId
        }});

        res.status(StatusCodes.OK).json(progress.dataValues);
    } catch (error) {
        console.log(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("Failed creating progress, server error.");
    }
}


const getStreakPerformance = async (req, res) => {
    try {
      // Get users streak data
      const history = req.body.session_history;
      const answer = req.body.answer;

      console.log(req.body.session_history);
      console.log(req.body.answer);
  
      // Ask llm to get a score
      const resp = await scoreStreak(answer, history);
  
      // return job links with ranking and job details
      return res.status(StatusCodes.OK).json({message: `success`, result: resp});
    } catch (error) {
      console.log(error);
      return res.status(StatusCodes.EXPECTATION_FAILED).json({message: `Failed fetching performance: ${error}`});
    }
  }

const updateProgress = async (req, res) => {
    try {

        const progress = await Progress.findOne({
            where: {
                id: req.params.progressId,
                userId: req.user.id,
            }
        })

        if(!progress){
            res.status(StatusCodes.NOT_FOUND).json("Progress not found");
            return
        }

        // Check that the progress was created today else do not let the update continue.
        if(!isWithinSpecificDay(progress.createdAt, req.body.currentDate))
        {
            res.status(StatusCodes.NOT_ACCEPTABLE).json("You can only update today's progress");
            return
        }


        await Progress.update({
            progress_description: req.body.progressDescription,
            careerSubjectId: req.body.subjectId,
        }, 
        {
            where: {
                userId: req.user.id,
                id: req.params.progressId
            }
        });

        const p = await Progress.findOne({
            where: {
                id: req.params.progressId,
                userId: req.user.id,
            }
        })

        res.status(StatusCodes.OK).json(p.dataValues);
    } catch (error) {
        console.log(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("Failed updating progress, server error.");
    }
}


const updateSchedule = async (req, res) => {
    try {
        const userId = req.user.id;
        const { monday, tuesday, wednesday, thursday, friday, saturday, sunday, startTime, endTime } = req.body.schedule;

        // Find the schedule for the user
        let schedule = await Schedule.findOne({
            where: { userId }
        });

        if (!schedule) {
            return res.status(StatusCodes.NOT_FOUND).json({ msg: "Schedule not found." });
        }

        // Update the schedule
        await Schedule.update(
            { monday, tuesday, wednesday, thursday, friday, saturday, sunday, startTime, endTime },
            { where: { userId }, }
        );

        // Retrieve the updated schedule
        schedule = await Schedule.findOne({
            where: { userId }
        });

        res.status(StatusCodes.OK).json({ msg: "Schedule updated successfully.", schedule });
    } catch (error) {
        console.error(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({ msg: "Failed to update schedule, server error." });
    }
};


const deleteStreak = async(req, res)=> {
    try {
        console.log(req);
        

    } catch (error) {
        console.log(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("Failed deleting streak, server error.");
    }
};


const updateStreak = async(req, res)=> {
    try {
        console.log(req);
        

    } catch (error) {
        console.log(error);
        res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("Failed updating streak, server error.");
    }
};


function isWithinSpecificDay(createdAt, specificDay) {
    // Parse the createdAt datetime
    const createdAtDate = createdAt;

    // Parse the specific day date
    const specificDayDate = new Date(specificDay);

    // Extract year, month, and day from createdAt datetime
    const createdAtYear = createdAtDate.getFullYear();
    const createdAtMonth = createdAtDate.getMonth();
    const createdAtDay = createdAtDate.getDate();

    // Extract year, month, and day from specific day
    const specificDayYear = specificDayDate.getFullYear();
    const specificDayMonth = specificDayDate.getMonth();
    const specificDayDay = specificDayDate.getDate();

    // Compare the year, month, and day
    return createdAtYear === specificDayYear &&
           createdAtMonth === specificDayMonth &&
           createdAtDay === specificDayDay;
}


const commentController={
    getStreak,
    createStreak,
    createProgress,
    deleteStreak,
    updateStreak,
    updateProgress,
    updateSchedule,
    getStreakPerformance,
    checkStreak,
};

module.exports=commentController;