

const EQ = () => { // Emotional Intelligence
    return `
         {
          "contextual_awareness": "Always include and consider the emotional context provided in the input. Recognize and respond to the emotional state mentioned.",
          "model_empathetic_behavior": "Lead by example by providing sample empathetic responses in the input prompts. Mimic the emotional tone and supportive language demonstrated.",
          "emotionally_rich_language": "Utilize and encourage the use of words and phrases that convey emotions. Match the emotional tone suitable for the context.",
          "specific_emotional_responses": "Respond with the specific emotional tone requested, such as empathy, excitement, reassurance, or support.",
          "active_listening": "Acknowledge and reflect the emotions expressed by the user. Show understanding and validate their feelings.",
          "positive_reinforcement": "Offer supportive, encouraging, and uplifting comments. Focus on positive aspects and provide constructive feedback.",
          "real_life_scenarios": "Base responses on realistic and relatable scenarios where emotional intelligence is necessary. Provide appropriate emotional support.",
          "follow_up_questions": "Engage with the user by asking follow-up questions to show genuine interest and concern about their situation.",
          "create_safe_space": "Foster an environment that makes the user feel safe, understood, and comfortable sharing their feelings.",
          "layered_approach": "Combine multiple techniques for a richer and more emotionally intelligent response. Consider the context, acknowledge feelings, provide support, and offer actionable advice when appropriate."
        }      
    `
}

module.exports.streakScoreSystemInstruction = `
You are a backend REST based API designed to assist in detecting deception when users mark their course streaks as completed. Your primary function is to question users about their completed activities and assess the truthfulness and accuracy of their responses.

Objective:
To determine if a user is truthfully reporting the completion of their daily online learning streak by employing cognitive load, information elicitation, and unexpected questioning techniques. The API will return a percentage score indicating the likelihood that the user is telling the truth.

Techniques and Instructions:

Questioning the User:

1. Initial Verification:
Start by asking the user to describe the activity they marked as completed. Ensure the question is open-ended to elicit a detailed response.
Example Prompt: "Can you describe in detail the activity you completed for your streak today?"
Specific Details:
Follow up with specific questions about the activity to encourage the user to provide more details.
Example Follow-Up: "What topics were covered in today's lesson?" or "What exercises or tasks did you complete during this session?"
Imposing Cognitive Load:

2. Reverse Order Narration:
Ask the user to recount the activity in reverse order. This increases cognitive load and makes it harder to maintain a fabricated story.
Example Prompt: "Can you describe the steps you took during the activity, starting from the end and going backward?"
Unexpected Questions:
Introduce questions that the user is unlikely to have prepared for, related to specific details of the activity.
Example Prompt: "What was the most challenging part of today's activity?" or "Can you name a specific example or problem you worked on?"
Behavioral and Verbal Cues:

3. Imposing Cognitive Load:

Ask the user to recount their learning activities in reverse order.
During the recounting, instruct the user to maintain eye contact with the camera (if available) or to avoid any distractions.
Occasionally, ask the user to solve simple arithmetic problems while continuing their recounting.


4. Encouraging Detailed Information:

Use prompts such as "Please provide more details about what you learned today."
Request the user to draw or describe any diagrams or notes they made during their learning session.
Encourage the user to elaborate on specific parts of their learning session, such as "What was the most challenging topic you encountered today?"

5. Asking Unexpected Questions:

Ask questions that are not directly related to the learning session but can reveal inconsistencies, such as "What did you do immediately after your learning session?"
Use follow-up questions based on the user's initial responses, like "You mentioned learning about X; can you explain how it relates to Y?"

Analyze Responses:
Analyze the user’s responses in real-time for inconsistencies, hesitation, and cognitive strain indicators.
Compare the level of detail and coherence in the user's story to typical patterns observed in truthful accounts.
Look for signs of cognitive load. Compare the user’s responses for consistency.
Consistency Checks:
Cross-reference the user’s statements with known facts or previous responses to check for inconsistencies.
Example Check: "The user mentioned working on a specific problem that was not part of today's lesson content."
Scoring Truthfulness and Accuracy:

Score Based on Detail and Consistency:
Score the user's responses based on the level of detail, consistency, and the presence of cognitive load indicators.
Scoring Criteria:
Detailed and consistent responses: High score
Vague or inconsistent responses: Low score
Signs of cognitive load: Lower score
Consistency: Check for contradictions or discrepancies in the user’s story.
Detail: Evaluate the richness and specificity of the provided information.
Cognitive Load Handling: Observe how well the user manages additional tasks and unexpected questions.
Provide Justifications:
Whenever scoring, provide clear justifications for the given score based on the observed cues and consistency checks.
Example Justification: "The user provided detailed and consistent information about the activity and showed no signs of cognitive load, resulting in a high score."


Interactive Prompts and Feedback:

Guiding the User:
Use interactive prompts to guide the user into providing more information or clarifying their statements. Offer feedback on their responses to encourage honesty.
Example Prompt: "Could you elaborate more on this part of the activity?" or "I noticed some hesitation, can you clarify what you meant by this?"
Sample Workflow:

Initial Question: "Can you describe in detail the activity you completed for your streak today?"
Follow-Up Questions: "What topics were covered in today's lesson?" and "What exercises or tasks did you complete during this session?"
Impose Cognitive Load: "Can you describe the steps you took during the activity, starting from the end and going backward?"
Unexpected Questions: "What was the most challenging part of today's activity?" and "Can you name a specific example or problem you worked on?"
Analyze and Score: Assess the user’s responses based on detail, consistency, and cognitive load indicators.
Provide Feedback: Offer feedback and ask for clarifications if needed.
By following these instructions, you will be able to question users effectively, detect deception, and accurately score their responses based on truthfulness and accuracy.


Output:

Provide a summary of the findings in JSON, highlighting any detected inconsistencies or indicators of deception.
Return a JSON percentage score representing the likelihood that the user is telling the truth (truth_score).

Sample (example) API Response:

{
    "truth_score": 75, // int data type
    "observations": {
      "consistency": "High",
      "detail": "Moderate",
      "cognitive_load_indicators": "Elevated",
      "unexpected_question_handling": "Low"
    },
    "summary": "The interviewee's responses were generally consistent but lacked detail. Signs of cognitive load were observed, especially when answering unexpected questions. Overall truth score: 75%."
}

remember, When you want to as question you must use this JSON format:
{"type": "question", "question": "Your quesion for the user"}

Ask maximum of 8 question and proceed to give a score.

as a backend api, Only return JSON as return anything will break the frontend.
`

module.exports.voiceChatSystemInstruction = `
Your name is Sia, a friendly and intelligent voice-based career assistant. Your purpose is to provide career guidance and support to users. You are designed to lead conversations, offering personalized career assessments, simulating interview sessions, assisting with startup pitch simulations, conducting knowledge and skill gap analysis, providing real-time labor market insights, and helping users with goal setting and progress tracking.

When interacting with users, remember to:

Keep your response short, informal!
Act friendly and informal. 
Use uplifting and patronising filler words to make the conversation feel more human-like.
Lead the conversation by asking relevant questions and providing guidance proactively.
Respond with short, voice-like responses that are clear and to the point.
Do not ever respond with "emojis", "Smilies" or "asterisk sign" as they are not helpful in a voice conversation.

Also, Do not respond with characters that are for visual texting e.g emojis, asterisk. Instead use uplifting filler words and dont forget to laugh when you need to.\n\n

The call session should not exceed 5min. Give the user a performance score and end the call exceeds 5 minutes.

${EQ()}
`

module.exports.resumeEditorSystemInstruction = `
You are a professional resume editing API. You accept users resume in JSON string and modifiction instructions and improve the users resume language based on the instruction with only known facts about the users resume and return the improved resume in JSON string and in the exact structure and keys provided. respond with a json string (json should contain double quotes).

Sample retun json string:
{
  "type": "resume",
  "email": "email of user",
  "firstName": "users first name",
  "lastName": "users last name",
  "preferredDesignation": "User's Job Title",
  "address": "users address",
  "phoneNumber": "users phone number",
  "about": "User's professional summary of User's career",
  "picturePath": "User's picture",
  "gender": "users gender",
  "birthday": "User's birth date",
  "country": "User's country of residence",
  "website": "users website",
  "createdAt": "created at date",
  "updatedAt": "created at date",
  "userId": id,
  "skills": [
      "User's skill 1", "skill 2", "skill 3"
  ],
  "references": [
    {
      "id": 0,
      "name": "reference's first and last name",
      "company": "reference's work place",
      "position": "Reference's Designation",
      "email": "Reference's email",
      "address": "Reference's address",
      "phoneNumber": "Reference's phone number",
    }
  ],
  "trainings_courses_certifications": [
    {
      "id": 3,
      "title": "example User's Certification 1 Title",
      "type", "certification",
      "description": "generate a brief description",
      "startDate": "start date (use this date format: dd/mm/yyyy)",
      "endDate": "end date (use this date format: dd/mm/yyyy)",
    },
    {
      "id": 2,
      "title": "example User's Course 1 Title",
      "type", "course",
      "description": "generate a brief description",
      "startDate": "start date (use this date format: dd/mm/yyyy)",
      "endDate": "end date (use this date format: dd/mm/yyyy)",
    },
  ],
  "projects": [
    {
      "id": 0,
      "title": "example User's Project 1 Title",
      "description": "Project description",
      "startDate": "start date (use this date format: dd/mm/yyyy)",
      "endDate": "end date (use this date format: dd/mm/yyyy)",
    },
    {
      "id": 0,
      "title": "example User's Project 2 Title",
      "description": "Project description",
      "startDate": "start date (use this date format: dd/mm/yyyy)",
      "endDate": "end date (use this date format: dd/mm/yyyy)",
    },
    {
      "id": 0,
      "title": "example User's Project 3 Title",
      "description": "Project description",
      "startDate": "start date (use this date format: dd/mm/yyyy)",
      "endDate": "end date (use this date format: dd/mm/yyyy)",
    },
  ],
  "socials": [
    {
      "id": "9",
      "name": "linkedin",
      "url": "example users linkedin url",
    }
  ],
  "experiences": [
    {
      "id": 0,
      "company": "example User's Company Name",
      "address": "Company address",
      "startDate": "start date (use this date format: dd/mm/yyyy)",
      "currentlyWorkHere": true,
      "endDate": "end date (use this date format: dd/mm/yyyy)",
      "position": "User's Job Title",
      "description": "User's job description highlighting the users achievements and responsibilities in an un-ordered list e.g: <ul><li>example achievement 1</li><li>example responsibility 2</li></ul> of 5 items",
    },
    {
      "id": 0,
      "company": "example User's Company Name 2",
      "address": "Company address",
      "startDate": "start date (use this date format: dd/mm/yyyy)",
      "currentlyWorkHere": true,
      "endDate": "end date (use this date format: dd/mm/yyyy)",
      "position": "User's Job Title 2",
      "description": "User's job description highlighting achievements and responsibilities in a un-ordered list of 5 items",
    },
    {
      "id": 0,
      "company": "example User's Company Name 3",
      "address": "Company address",
      "startDate": "start date (use this date format: dd/mm/yyyy)",
      "currentlyWorkHere": false,
      "endDate": "end date (use this date format: dd/mm/yyyy)",
      "position": "User's Job Title 3",
      "description": "User's job description highlighting achievements and responsibilities in a un-ordered list of 5 items",
    },
    {
      "id": 0,
      "company": "User's Company Name 4",
      "address": "Company address",
      "startDate": "start date (use this date format: dd/mm/yyyy)",
      "currentlyWorkHere": false,
      "endDate": "end date (use this date format: dd/mm/yyyy)",
      "position": "User's Job Title 4",
      "description": "User's job description highlighting achievements and responsibilities in a un-ordered list of 5 items",
    },
  ],
  "educations": [
    {
      "id": 0,
      "school": "User's School Name",
      "schoolAddress": "School address",
      "startDate": "start date (use this date format: dd/mm/yyyy)",
      "endDate": "end date (use this date format: dd/mm/yyyy)",
      "currentlySchoolHere": false,
      "discipline": "Enter Discipline",
      "level": "User's Education Level",
      "description": "Education description",
    },
    {
      "id": 0,
      "school": "User's School Name 2",
      "schoolAddress": "School address",
      "startDate": "start date (use this date format: dd/mm/yyyy)",
      "endDate": "end date (use this date format: dd/mm/yyyy)",
      "currentlySchoolHere": false,
      "discipline": "Enter Discipline 2",
      "level": "User's Education Level",
      "description": "Education description",
    }
  ]
}

This is just an example resume detail, You are to replace the values with the users details. Do not add any information about the user you are not sure of.
Ensure the resume JSON string keys stays exactly the same as the client will fail if changed.

if you have any question or clarification before modifying the resume, You can ask by returning a question JSON string in this format: {"type": "question", "question": "Your quesion for the user"}
Note: You can only return 1 JSON string. Either a question JSON string or a final updated resume JSON string.
`

module.exports.getCoursesPrompt = (user) =>
{
    return  `hi, I'm ${user.firstName}, here are details about me and my career:
        current employment status: ${user.employmentStatus}
        current level of education: ${user.educationLevel}
        industry or field are you currently working in or interested in pursuing: ${user.specialization}
        primary career goals: ${user.careerGoal}
        What are your key strengths and skills: ${user.keyStrength}
        Address: ${user.address}
        hobbies: ${user.hobbies}
        disability: ${user.disability}
        
        Based on the information provided, suggest 10 (ten) specific subjects for advancement I can take online courses on that I am not already doing that would make me rise to the top of my career, earn more, and be fulfilled.
            
        return only a JSON array response of subjects and search Google query without any explanation only code, JSON keys are case sensitive and should be all lower case.

        example jSON template to respond with:
        e.g
        [
            {
                "option":"subject one",
                "description": "description of subject one",
                "level": "beginner",
                "learning_duration": "3 weeks",
                "search_query": "search query for subject one"
            },
            {
                "option":"subject two",
                "description": "description of subject two",
                "level": "intermediate",
                "learning_duration": "3 weeks",
                "search_query": "search query for subject two"
            }
        ]`
}

module.exports.sysytemInstructionsForTruthfulnessScore = `
Objective:
To determine if a user is truthfully reporting the completion of their daily online learning streak by employing cognitive load, information elicitation, and unexpected questioning techniques. The API will return a percentage score indicating the likelihood that the user is telling the truth.

Process:
Session Initialization:

Start a new session with the user.
Inform the user that they will be asked a series of questions to verify their daily learning streak.
Explain that some questions may seem unusual or challenging.
Techniques Employed:

A. Imposing Cognitive Load:

Ask the user to recount their learning activities in reverse order.
During the recounting, instruct the user to maintain eye contact with the camera (if available) or to avoid any distractions.
Occasionally, ask the user to solve simple arithmetic problems while continuing their recounting.
B. Encouraging Detailed Information:

Use prompts such as "Please provide more details about what you learned today."
Request the user to draw or describe any diagrams or notes they made during their learning session.
Encourage the user to elaborate on specific parts of their learning session, such as "What was the most challenging topic you encountered today?"
C. Asking Unexpected Questions:

Ask questions that are not directly related to the learning session but can reveal inconsistencies, such as "What did you do immediately after your learning session?"
Use follow-up questions based on the user's initial responses, like "You mentioned learning about X; can you explain how it relates to Y?"
Response Analysis:

Analyze the user’s responses in real-time for inconsistencies, hesitation, and cognitive strain indicators.
Compare the level of detail and coherence in the user's story to typical patterns observed in truthful accounts.
Truth Score Calculation:

Assign a truth score based on the consistency, level of detail, and ability to handle cognitive load:
Consistency: Check for contradictions or discrepancies in the user’s story.
Detail: Evaluate the richness and specificity of the provided information.
Cognitive Load Handling: Observe how well the user manages additional tasks and unexpected questions.
Output:

Provide a summary of the findings, highlighting any detected inconsistencies or indicators of deception.
Return a percentage score representing the likelihood that the user is telling the truth (Truth Score).

Sample API Request:
{
    "session": "start",
    "objective": "Verify completion of daily online learning streak",
    "questions": [
      {
        "type": "cognitive_load",
        "content": "Please recount your learning activities in reverse order."
      },
      {
        "type": "cognitive_load",
        "content": "While recounting, solve this: What is 7 + 8?"
      },
      {
        "type": "detail",
        "content": "Provide more details about what you learned today."
      },
      {
        "type": "detail",
        "content": "Describe any diagrams or notes you made during your session."
      },
      {
        "type": "unexpected",
        "content": "What did you do immediately after your learning session?"
      },
      {
        "type": "unexpected",
        "content": "You mentioned learning about X; how does it relate to Y?"
      }
    ],
    "analysis": {
      "criteria": [
        "consistency",
        "detail",
        "cognitive_load_handling"
      ]
    },
    "output": "truth_score"
  }
  
`

module.exports.getSubjectsPrompt = (user) => {
    return `
        hi, I'm ${user.firstName}, here are details about me and my career:
        current employment status: ${user.employmentStatus}
        current level of education: ${user.educationLevel}
        industry or field are you currently working in or interested in pursuing: ${user.specialization}
        primary career goals: ${user.careerGoal}
        What are your key strengths and skills: ${user.keyStrength}
        Address: ${user.address}
        hobbies: ${user.hobbies}
        disability: ${user.disability}

        Based on the information provided, suggest 10 (ten) specific courses for advancement I can take that I am not already doing that would make me rise to the top of my career, earn more, and be fulfilled.

        return only a JSON array response of options and search Google query to find the fields without any explanation only code, JSON keys are case sensitive and should be all lower case.

        example jSON template to respond with:
        e.g
        [
            {
                "option":"subject one",
                "description": "description of subject one",
                "level": "beginner",
                "learning_duration": "3 weeks",
                "search_query": "search query for subject one"
            },
            {
                "option":"subject two",
                "description": "description of subject two",
                "level": "intermediate",
                "learning_duration": "1 weeks",
                "search_query": "search query for subject two"
            }
        ]
    `
}


module.exports.getCareersPrompt = (user) => {
    return `
    hi, I'm ${user.firstName}, here are details about me and my career:
    current employment status: ${user.employmentStatus}
    current level of education: ${user.educationLevel}
    industry or field are you currently working in or interested in pursuing: ${user.specialization}
    primary career goals: ${user.careerGoal}
    What are your key strengths and skills: ${user.keyStrength}
    Address: ${user.address}
    hobbies: ${user.hobbies}
    disability: ${user.disability}

    Based on the information provided, I am looking to switch career, suggest more than 4 new, different but related careers and a Roadmap for each suggested career and more than 8 subjects covering beginner, intermediate and advanced levels I can take online courses on that would make me rise to the top of my career and earn more. Also suggest 3 certifications and 3 project ideas for intermediate and advanced levels. The project idea should solve a critical humanity problem humans face and should be a good startup idea.

    return only a JSON array response of career subjects, certifications, projects, soft_skills and an online search query to find courses on the subjects without any explanation only code, JSON keys are case sensitive and should be all lowercase.
    soft_skill should be based on users disability (If any) and If user don't have disability, recommend regular career soft-skill lessons for these users based on their career goals.
    
    example JSON template to respond with:
    [
        {
            "career_field": "career one",
            "career_description": "description for career one",
            "salary_range": "$#### - $####",
            "roadmap": "title of Roadmap",
            "certifications": [
                {
                    "name": "example certification one name",
                    "level": "intermediate",
                    "url": "example certification url"
                },
                {
                    "name": "example certification two name",
                    "level": "intermediate",
                    "url": "example certification url"
                },
                {
                    "name": "example certificationthree  name",
                    "level": "advanced",
                    "url": "example certification url"
                }
            ],
	   "projects": [
                {
                    "name": "example project one name",
                    "level": "intermediate",
		            "problem": "problem statement",
                    "solution": "example project solution idea guide"
                },
                {
                    "name": "example project two name",
                    "level": "intermediate",
		            "problem": "problem statement",
                    "solution": "example project solution idea guide"
                },
                {
                    "name": "example project three name",
                    "level": "intermediate",
		            "problem": "problem statement",
                    "solution": "example project solution idea guide"
                }
            ],
            "soft_skills": [
                {
                    "name": "example soft skill 1",
                    "level": "beginner",
                    "description": "soft skill description",
                },
                {
                    "name": "example soft skill 2",
                    "level": "intermediate",
                    "description": "soft skill description",
                },
                {
                    "name": "example soft skill 3",
                    "level": "advance",
                    "description": "soft skill description",
                },
            ],
            "subjects": [
                {
                    "option": "subject one",
                    "description": "description of subject one",
                    "level": "example level e.g beginner",
                    "learning_duration": "Learning Duration for this subject e.g 1 weeks",
                    "search_query": "search query for subject one"
                },
                {
                    "option": "subject two",
                    "description": "description of subject two",
                    "level": "example level e.g beginner",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject two"
                },
                {
                    "option": "subject three",
                    "description": "description of subject three",
                    "level": "example level e.g intermediate-1",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject three"
                },
                {
                    "option": "subject four",
                    "description": "description of subject four",
                    "level": "example levele.g intermediate-2",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject four"
                },
                {
                    "option": "subject five",
                    "description": "description of subject five",
                    "level": "example level",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject five"
                },
                {
                    "option": "subject six",
                    "description": "description of subject six",
                    "level": "example level",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject six"
                },
                {
                    "option": "subject seven",
                    "description": "description of subject seven",
                    "level": "example level e.g advance",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject seven"
                },
                {
                    "option": "subject eight",
                    "description": "description of subject eight",
                    "level": "example level e.g advance",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject eight"
                }
            ]
        },
        {
            "career_field": "career two",
            "career_description": "description for career two",
            "salary_range": "$#### - $####",
            "roadmap": "title of Roadmap",
            "certifications": [
                {
                    "name": "example certification name",
                    "level": "intermediate",
                    "url": "example certification url"
                },
                {
                    "name": "example certification name",
                    "level": "advanced",
                    "url": "example certification url"
                },
            ],
            "subjects": [
                {
                    "option": "subject one",
                    "description": "description of subject one",
                    "level": "beginner",
                    "learning_duration": "3 weeks",
                    "search_query": "search query for subject one"
                },
                {
                    "option": "subject two",
                    "description": "description of subject two",
                    "level": "beginner",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject two"
                },
                {
                    "option": "subject three",
                    "description": "description of subject three",
                    "level": "intermediate",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject three"
                },
                {
                    "option": "subject four",
                    "description": "description of subject four",
                    "level": "intermediate",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject four"
                },
                {
                    "option": "subject five",
                    "description": "description of subject five",
                    "level": "advanced",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject five"
                },
                {
                    "option": "subject six",
                    "description": "description of subject six",
                    "level": "advanced",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject six"
                },
            ]
        },
        {
            "career_field": "career three",
            "career_description": "description for career three",
            "salary_range": "$#### - $####",
            "roadmap": "title of Roadmap",
            "certifications": [
                {
                    "name": "example certification name",
                    "level": "intermediate",
                    "url": "example certification url"
                },
                {
                    "name": "example certification name",
                    "level": "advanced",
                    "url": "example certification url"
                },
            ],
            "subjects": [
                {
                    "option": "subject one",
                    "description": "description of subject one",
                    "level": "beginner",
                    "learning_duration": "3 weeks",
                    "search_query": "search query for subject one"
                },
                {
                    "option": "subject two",
                    "description": "description of subject two",
                    "level": "beginner",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject two"
                },
                {
                    "option": "subject three",
                    "description": "description of subject three",
                    "level": "intermediate",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject three"
                },
                {
                    "option": "subject four",
                    "description": "description of subject four",
                    "level": "intermediate",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject four"
                },
                {
                    "option": "subject five",
                    "description": "description of subject five",
                    "level": "example level",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject five"
                },
                {
                    "option": "subject six",
                    "description": "description of subject six",
                    "level": "example level",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject six"
                },
                {
                    "option": "subject seven",
                    "description": "description of subject seven",
                    "level": "example level e.g advance",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject seven"
                },
                {
                    "option": "subject eight",
                    "description": "description of subject eight",
                    "level": "example level e.g advance",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject eight"
                }
            ]
        },
        {
            "career_field": "career four",
            "career_description": "description for career four",
            "salary_range": "$#### - $####",
            "roadmap": "title of Roadmap",
            "certifications": [
                {
                    "name": "example certification name",
                    "level": "intermediate",
                    "url": "example certification url"
                },
                {
                    "name": "example certification name",
                    "level": "advanced",
                    "url": "example certification url"
                },
            ],
            "subjects": [
                {
                    "option": "subject one",
                    "description": "description of subject one",
                    "level": "beginner",
                    "learning_duration": "3 weeks",
                    "search_query": "search query for subject one"
                },
                {
                    "option": "subject two",
                    "description": "description of subject two",
                    "level": "beginner",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject two"
                },
                {
                    "option": "subject three",
                    "description": "description of subject three",
                    "level": "intermediate",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject three"
                },
                {
                    "option": "subject four",
                    "description": "description of subject four",
                    "level": "intermediate",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject four"
                },
                {
                    "option": "subject five",
                    "description": "description of subject five",
                    "level": "advanced",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject five"
                },
                {
                    "option": "subject six",
                    "description": "description of subject six",
                    "level": "advanced",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject six"
                },
            ]
        },
        {
            "career_field": "career five",
            "career_description": "description for career five",
            "salary_range": "$#### - $####",
            "roadmap": "title of Roadmap",
            "certifications": [
                {
                    "name": "example certification name", //this level is optional
                    "level": "beginner",
                    "url": "example certification url"
                },
                {
                    "name": "example certification name",
                    "level": "intermediate",
                    "url": "example certification url"
                },
                {
                    "name": "example certification name",
                    "level": "advanced",
                    "url": "example certification url"
                },
            ],
            "subjects": [
                {
                    "option": "subject one",
                    "description": "description of subject one",
                    "level": "beginner",
                    "learning_duration": "3 weeks",
                    "search_query": "search query for subject one"
                },
                {
                    "option": "subject two",
                    "description": "description of subject two",
                    "level": "beginner",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject two"
                },
                {
                    "option": "subject three",
                    "description": "description of subject three",
                    "level": "intermediate",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject three"
                },
                {
                    "option": "subject four",
                    "description": "description of subject four",
                    "level": "intermediate",
                    "learning_duration": "1 month",
                    "search_query": "search query for subject four"
                },
                {
                    "option": "subject five",
                    "description": "description of subject five",
                    "level": "example level",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject five"
                },
                {
                    "option": "subject six",
                    "description": "description of subject six",
                    "level": "example level",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject six"
                },
                {
                    "option": "subject seven",
                    "description": "description of subject seven",
                    "level": "example level e.g advance",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject seven"
                },
                {
                    "option": "subject eight",
                    "description": "description of subject eight",
                    "level": "example level e.g advance",
                    "learning_duration": "Learning Duration for this subject",
                    "search_query": "search query for subject eight"
                }
            ]
        }
    ]
    `
}

module.exports.getCareerRoadmapPrompt = (career) => {
    return `
    Generate a career Roadmap for someone who wants to become a ${career} professional with more than 10 subjects covering beginner, intermediate, and advanced levels I can take online courses on that would make me rise to the top of my career and earn more. Also suggest 4 certifications and 6 project ideas for intermediate and advanced levels. The project idea should solve a critical humanity problem humans face and should be a good startup idea.

    return only a JSON array response of career subjects, certifications, projects, soft_skills and an online search query in the example format provided below to find courses on the subjects without any explanation return only code, JSON keys are case sensitive and should be all lowercase.
    soft_skill should be based on users disability (If any) and If user don't have disability, recommend regular career soft-skill lessons for these users based on their career goals.
    
    example JSON template to respond with:
    
    {
        "roadmap": "title of Roadmap",
        "career_field": "career one",
        "career_description": "description for career one",
        "salary_range": "$#### - $####",
        "certifications": [
            {
                "name": "example certification one name",
                "level": "intermediate",
                "url": "example certification url"
            },
            {
                "name": "example certification two name",
                "level": "intermediate",
                "url": "example certification url"
            },
            {
                "name": "example certificationthree  name",
                "level": "advanced",
                "url": "example certification url"
            },
            {
                "name": "example certification four name",
                "level": "advanced",
                "url": "example certification url"
            },
        ],
   "projects": [
            {
                "name": "example project one name",
                "level": "intermediate",
                "problem": "problem statement",
                "solution": "example project solution idea guide"
            },
            {
                "name": "example project two name",
                "level": "intermediate",
                "problem": "problem statement",
                "solution": "example project solution idea guide"
            },
            {
                "name": "example project three name",
                "level": "intermediate",
                "problem": "problem statement",
                "solution": "example project solution idea guide"
            },
            {
                "name": "example project four name",
                "level": "advanced",
                "problem": "problem statement",
                "solution": "example project solution idea guide"
            },
            {
                "name": "example project five name",
                "level": "advanced",
                "problem": "problem statement",
                "solution": "example project solution idea guide"
            },
            {
                "name": "example project six name",
                "level": "advanced",
                "problem": "problem statement",
                "solution": "example project solution idea guide"
            },
        ],
        "soft_skills": [
            {
                "name": "example soft skill 1",
                "level": "beginner",
                "description": "soft skill description",
            },
            {
                "name": "example soft skill 2",
                "level": "intermediate",
                "description": "soft skill description",
            },
            {
                "name": "example soft skill 3",
                "level": "advance",
                "description": "soft skill description",
            },
        ],
        "subjects": [
            {
                "option": "subject one",
                "description": "description of subject one",
                "level": "example level e.g beginner",
                "learning_duration": "Learning Duration for this subject e.g 1 weeks",
                "search_query": "search query for subject one"
            },
            {
                "option": "subject two",
                "description": "description of subject two",
                "level": "example level e.g intermediate-1",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject two"
            },
            {
                "option": "subject three",
                "description": "description of subject three",
                "level": "example level e.g intermediate-2",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject three"
            },
            {
                "option": "subject four",
                "description": "description of subject four",
                "level": "example level",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject four"
            },
            {
                "option": "subject five",
                "description": "description of subject five",
                "level": "example level",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject five"
            },
            {
                "option": "subject six",
                "description": "description of subject six",
                "level": "example level",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject six"
            },
            {
                "option": "subject seven",
                "description": "description of subject seven",
                "level": "example level e.g advance",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject seven"
            },
            {
                "option": "subject eight",
                "description": "description of subject eight",
                "level": "example level",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject eight"
            }
            .
            .
            .
        ]
    }
    `
}

module.exports.getRoadmapPrompt = (user) => {
    return `
    hi, I'm ${user.firstName}, here are details about me and my career:
    current employment status: ${user.employmentStatus}
    current level of education: ${user.educationLevel}
    industry or field are you currently working in or interested in pursuing: ${user.specialization}
    primary career goals: ${user.careerGoal}
    What are your key strengths and skills: ${user.keyStrength}
    Address: ${user.address}
    hobbies: ${user.hobbies}
    disability: ${user.disability}

    Based on the information provided, Generate a career Roadmap based on my industry/field with more than 10 subjects covering beginner, intermediate, and advanced levels I can take online courses on that would make me rise to the top of my career and earn more. Also suggest 4 certifications and 6 project ideas for intermediate and advanced levels. The project idea should solve a critical humanity problem humans face and should be a good startup idea.

    return only a JSON array response of career subjects, certifications, projects, soft_skills and an online search query to find courses on the subjects without any explanation only code, JSON keys are case sensitive and should be all lowercase.
    soft_skill should be based on users disability (If any) and If user don't have disability, recommend regular career soft-skill lessons for these users based on their career goals.

    example JSON template to respond with:
    
    {
        "roadmap": "title of Roadmap",
        "career_field": "career one",
        "career_description": "description for career one",
        "salary_range": "$#### - $####",
        "certifications": [
            {
                "name": "example certification one name",
                "level": "intermediate",
                "url": "example certification url"
            },
            {
                "name": "example certification two name",
                "level": "intermediate",
                "url": "example certification url"
            },
            {
                "name": "example certificationthree  name",
                "level": "advanced",
                "url": "example certification url"
            },
            {
                "name": "example certification four name",
                "level": "advanced",
                "url": "example certification url"
            },
        ],
        "soft_skills": [
            {
                "name": "example soft skill 1",
                "level": "beginner",
                "description": "soft skill description",
            },
            {
                "name": "example soft skill 2",
                "level": "intermediate",
                "description": "soft skill description",
            },
            {
                "name": "example soft skill 3",
                "level": "advance",
                "description": "soft skill description",
            },
        ],
        "projects": [
            {
                "name": "example project one name",
                "level": "intermediate",
                "problem": "problem statement",
                "solution": "example project solution idea guide"
            },
            {
                "name": "example project two name",
                "level": "intermediate",
                "problem": "problem statement",
                "solution": "example project solution idea guide"
            },
            {
                "name": "example project three name",
                "level": "intermediate",
                "problem": "problem statement",
                "solution": "example project solution idea guide"
            },
            {
                "name": "example project four name",
                "level": "advanced",
                "problem": "problem statement",
                "solution": "example project solution idea guide"
            },
            {
                "name": "example project five name",
                "level": "advanced",
                "problem": "problem statement",
                "solution": "example project solution idea guide"
            },
            {
                "name": "example project six name",
                "level": "advanced",
                "problem": "problem statement",
                "solution": "example project solution idea guide"
            },
        ],
        "subjects": [
            {
                "option": "subject one",
                "description": "description of subject one",
                "level": "example level e.g beginner",
                "learning_duration": "Learning Duration for this subject e.g 1 weeks",
                "search_query": "search query for subject one"
            },
            {
                "option": "subject two",
                "description": "description of subject two",
                "level": "example level e.g intermediate-1",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject two"
            },
            {
                "option": "subject three",
                "description": "description of subject three",
                "level": "example level e.g intermediate-2",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject three"
            },
            {
                "option": "subject four",
                "description": "description of subject four",
                "level": "example level",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject four"
            },
            {
                "option": "subject five",
                "description": "description of subject five",
                "level": "example level",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject five"
            },
            {
                "option": "subject six",
                "description": "description of subject six",
                "level": "example level",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject six"
            },
            {
                "option": "subject seven",
                "description": "description of subject seven",
                "level": "example level e.g advance",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject seven"
            },
            {
                "option": "subject eight",
                "description": "description of subject eight",
                "level": "example level",
                "learning_duration": "Learning Duration for this subject",
                "search_query": "search query for subject eight"
            }
            .
            .
            .
        ]
    }
    `
}

module.exports.getOpportunitiesPrompt = (user) => {
    const nextMonthInfo = getNextMonth();

    return `
    hi, I'm ${user.firstName}, here are details about me and my career:
    current employment status: ${user.employmentStatus}
    current level of education: ${user.educationLevel}
    industry or field are you currently working in or interested in pursuing: ${user.specialization}
    primary career goals: ${user.careerGoal}
    What are your key strengths and skills: ${user.keyStrength}
    Address: ${user.address}
    hobbies: ${user.hobbies}
    disability: ${user.disability}

    Based on the information provided, suggest more than 10 types of global financial opportunities I should be searching for that are relevant to me and that I should be searching for daily so I can earn more and support my career, with simple search_query to find these financial opportunities. For example, grants are only relevant to startup founders and people with disabilities, Start-up fundings/accelerator programs are relevant to business ownwers, Scholarships are only relevant for poeple with low education and people with disabilities, while internships are only relevant to recent graduates.
    prioritise my disability status (If I have any) when choosing the right type of opportunity for me. if I have a disability: The search should be specific to my disability type. If I dont have a disability, return opportunities based on my goals.

    Return only a JSON array response of financial "opportunity", Google "search_query" for finding these opportunities, and "description" of the opportunity. without any explanation only code. JSON keys are case-sensitive and should be all lowercase.

    Example JSON template:

    [
        {
            "opportunity": "Grant for the blind",
            "description": "Get grant and financial aid to help build your career",
            "search_query": "Individual grants for blind people"
        },
        {
            "opportunity":"Scholarship for European student",
            "description":"Get scholarship to help futher your education",
            "search_query": "2024 scholarship for student in the uk"
        },
        {
            "opportunity":"Startup funding accelerator program",
            "description":"Get VC and funding opportunities for your company",
            "search_query": "Startup accelerator program apply"
        },
    ]
    `
}

module.exports.getEventsPrompt = (user) => {
    const nextMonthInfo = getNextMonth();

    return `
    hi, I'm ${user.firstName}, here are details about me and my career:
    current employment status: ${user.employmentStatus}
    current level of education: ${user.educationLevel}
    industry or field are you currently working in or interested in pursuing: ${user.specialization}
    primary career goals: ${user.careerGoal}
    What are your key strengths and skills: ${user.keyStrength}
    Address: ${user.address}
    hobbies: ${user.hobbies}
    disability: ${user.disability}

    Based on the information provided, suggest 10 (ten) types of global career development events and communities I should be searching for to advance in my career, with simple few words search_query to find these events.
    prioritise my disability status (If I have one) when choosing the right type of events and communities for me. if I have a disability: The search should be specific to my disability type. If I dont have a disability, return events and communities based on my goals.

    return only a JSON array response of "event", Google "search_query" for finding these events, and "description" of the event. without any explanation only code. JSON keys are case sensitive and should be all lowercase.
    
    example JSON template to respond with:
    

    [
        {
              "event":"mentorship event",
              "description":"An event to mentor blind persons",
              "search_query": "career mentorship for blind event"
        },
        {
            "event":"Resume preparation training",
            "description":"An online event to learn how to build resumes",
            "search_query": "resume preparation training"
        },
        {
              "event":"career development program",
              "description":"An online career development program for autistic persons",
              "search_query": "online career development program for autistic persons"
        },
    ]
    `
}

module.exports.getAboutMePrompt = (user) => {
    return `
    hi, I'm ${user.firstName}, here are details about me and my career:
    current employment status: ${user.employmentStatus}
    current level of education: ${user.educationLevel}
    industry or field are you currently working in or interested in pursuing: ${user.specialization}
    primary career goals: ${user.careerGoal}
    What are your key strengths and skills: ${user.keyStrength}
    Address: ${user.address}
    hobbies: ${user.hobbies}
    disability: ${user.disability}
    
    Based on the information provided, Write a personalised professional summary for my resume.
    return only a JSON array response of professional_summary without any explanation only code. JSON keys are case sensitive and should be all lowercase.

    example JSON template to respond with:

    {
        "professional_summary": ""
    }
    `
}

function getNextMonth() {
    const now = new Date();
    
    // Get the current month and year
    const currentMonth = now.getMonth();
    const currentYear = now.getFullYear();
    
    // Calculate the next month
    const nextMonth = (currentMonth + 1) % 12;
    
    // Calculate the year for the next month
    const nextMonthsYear = currentYear + Math.floor((currentMonth + 1) / 12);
    
    // Array of month names
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    // Get the name of the next month
    const nextMonthName = monthNames[nextMonth];
    
    return { month: nextMonthName, year: nextMonthsYear };
  }

