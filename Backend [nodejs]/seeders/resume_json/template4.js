const template4 = {
    bodyHTML: `<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>IIITD Resume</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/7.0.0/normalize.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paper-css/0.4.1/paper.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro:ital,wght@0,200;0,300;0,400;0,600;0,700;0,900;1,200;1,300;1,400;1,600;1,700;1,900&display=swap');
    
            /* @page {
    size: A4;
    } */
    
            * {
                font-family: 'Source Sans Pro' !important;
                padding: 0;
                margin: 0;
            }
    
            #page1 {
                height: 100%;
                width: 100%;
                display: flex;
                flex-direction: column;
                justify-content: flex-start;
                /* Changed from space-around to flex-start */
            }
    
            #page2 {
                height: 100%;
                width: 100%;
                display: flex;
                flex-direction: column;
                justify-content: flex-start;
                /* Changed from space-between to flex-start */
            }
            ul, ol {
              list-style-position: inside !important;
              padding-left: 0 !important;
            }
            h1,
            h2,
            h3,
            h4,
            h5,
            h6,
            p {
                margin: 0 !important;
                padding: 0 !important;
            }
    
            p,
            ul,
            li,
            table,
            th,
            td {
                font-size: 10.75pt;
                line-height: 1.25;
            }
    
            #header {
                width: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: space-evenly;
                height: 120px;
                margin-top: -10px;
            }
    
            #name {
                text-transform: uppercase;
                font-weight: 700 !important;
                font-size: 27pt;
            }
    
            p {
                font-size: 10.75pt;
            }
    
            a {
                color: #124ee8;
            }
    
            strong {
                font-weight: 600 !important;
            }
    
            .section {
                width: 100%;
                overflow: hidden;
                display: flex;
                flex-direction: column;
                justify-content: space-evenly;
            }
    
            .iiitd-logo {
                position: absolute;
                display: block;
                top: 30px;
                right: 30px;
                width: 100px;
            }
    
            .section-title {
                font-size: 10.75pt;
                text-transform: uppercase;
                width: 100%;
                background: #dbdddf;
                padding: 5px 5px 6px 0px !important;
                padding-bottom: 5px !important;
                padding-left: 6px !important;
                margin-bottom: 6px !important;
            }
    
            .section-title h3 {
                width: min-content;
            }
    
            #education .section-element {
                flex-direction: row;
                justify-content: space-between;
            }
    
            .section-element {
                width: 98%;
                margin: 3px auto;
                display: flex;
            }
    
            .left,
            .right {
                display: flex;
                flex-direction: column;
            }
    
            .left p,
            .right p {
                margin: 1px 0 !important;
            }
    
            .right p {
                text-align: right;
            }
    
            #skill-grid {
                width: 98%;
                margin: 8px auto;
                display: grid;
                grid-template-columns: 180px auto;
                gap: 10px;
                font-size: 10.5pt;
            }
    
            .grid-row {
                line-height: 1.25;
                display: contents;
            }
    
            #work-experience .section-element,
            #projects .section-element {
                flex-direction: column;
                width: 98%;
                margin: 5px auto;
            }
    
            #projects .section-element {
                margin: 3px auto !important;
            }
    
            .heading {
                width: 100%;
                margin: 0 auto;
                display: flex;
                flex-direction: row;
                justify-content: space-between;
            }
    
            ul {
                width: 98%;
                margin: 0 auto;
                list-style: disc;
                list-style-position: inside;
                text-indent: -20px;
                margin-left: 22px;
            }
    
            li {
                margin: 2px 0;
            }
    
            ul li::marker {
                font-size: 0.825em;
            }
    
            .underline {
                text-decoration: underline;
            }
    
            #por-list {
                text-indent: 0;
                margin-left: 5px;
            }
    
            #por-grid {
                width: 98%;
                margin: 0 auto;
                display: grid;
                grid-template-columns: auto 120px;
                font-size: 10.5pt;
            }
    
            #por-grid li {
                margin: 2px 0;
            }
    
            #por-grid .duration {
                text-align: right;
            }
    
            #awards ul,
            #interests ul {
                text-indent: -17px;
                margin-left: 22px;
            }

            .sheet {
              height: max-content !important;
              min-height: 296mm;
              padding-bottom: 45px;
            }            
    
            @media print {
                body {
                    -webkit-print-color-adjust: exact;
                }

                
              .section-element { 
                  page-break-inside:avoid;
                  page-break-after:auto;
                  padding-top: 10px;
              }
            }
        </style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/js-yaml/4.1.0/js-yaml.min.js"></script>
    </head>
    
    <body class="A4" data-new-gr-c-s-check-loaded="14.1145.0" data-gr-ext-installed="" style="background: #ffffff;">
        <section class="sheet padding-10mm">
            <div id="page1">
                <div id="header">
                    <h1 id="name">{{first_name}} {{last_name}}</h1>
                    <p>
                        {{phone_number_section}}
                        <strong>Email:</strong>
                        <a id="email">{{email}}</a>
                    </p>
                    {{socials_section}}
                    <p>
                        <!-- <strong>DOB:</strong>
                <span id="dob">11 June 2001</span> | -->
                {{website_section}}
                    </p>
                </div>
                {{education_section}}
                {{skills_section}}
                {{experience_section}}
                {{project_section}}
                {{certification_section}}
            </div>
        </section>
    </body>
    
    </html>`,
    sampleHTML: `<html lang="en"><head>
    <meta charset="utf-8">
    <title>IIITD Resume</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/7.0.0/normalize.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paper-css/0.4.1/paper.css">
    <style>
@import url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro:ital,wght@0,200;0,300;0,400;0,600;0,700;0,900;1,200;1,300;1,400;1,600;1,700;1,900&display=swap');

/* @page {
size: A4;
} */

* {
  font-family: 'Source Sans Pro' !important;
  padding: 0;
  margin: 0;
}

#page1 {
  height: 100%;
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: flex-start; /* Changed from space-around to flex-start */
}

#page2 {
  height: 100%;
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: flex-start; /* Changed from space-between to flex-start */
}

h1,
h2,
h3,
h4,
h5,
h6,
p {
  margin: 0 !important;
  padding: 0 !important;
}

p,
ul,
li,
table,
th,
td {
  font-size: 10.75pt;
  line-height: 1.25;
}

#header {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-evenly;
  height: 120px;
  margin-top: -10px;
}

#name {
  text-transform: uppercase;
  font-weight: 700 !important;
  font-size: 27pt;
}

p {
  font-size: 10.75pt;
}

a {
  color: #124ee8;
}

strong {
  font-weight: 600 !important;
}

.section {
  width: 100%;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;
}

.iiitd-logo {
  position: absolute;
  display: block;
  top: 30px;
  right: 30px;
  width: 100px;
}

.section-title {
  font-size: 10.75pt;
  text-transform: uppercase;
  width: 100%;
  background: #dbdddf;
  padding: 5px 5px 6px 0px !important;
  padding-bottom: 5px !important;
  padding-left: 6px !important;
  margin-bottom: 6px !important;
}

.section-title h3 {
  width: min-content;
}

#education .section-element {
  flex-direction: row;
  justify-content: space-between;
}

.section-element {
  width: 98%;
  margin: 3px auto;
  display: flex;
}

.left,
.right {
  display: flex;
  flex-direction: column;
}

.left p,
.right p {
  margin: 1px 0 !important;
}

.right p {
  text-align: right;
}

#skill-grid {
  width: 98%;
  margin: 8px auto;
  display: grid;
  grid-template-columns: 180px auto;
  gap: 10px;
  font-size: 10.5pt;
}

.grid-row {
  line-height: 1.25;
  display: contents;
}

#work-experience .section-element,
#projects .section-element {
  flex-direction: column;
  width: 98%;
  margin: 5px auto;
}

#projects .section-element {
  margin: 3px auto !important;
}

.heading {
  width: 100%;
  margin: 0 auto;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}

ul {
  width: 98%;
  margin: 0 auto;
  list-style: disc;
  list-style-position: inside;
  text-indent: -20px;
  margin-left: 22px;
}

li {
  margin: 2px 0;
}

ul li::marker {
  font-size: 0.825em;
}

.underline {
  text-decoration: underline;
}

#por-list {
  text-indent: 0;
  margin-left: 5px;
}

#por-grid {
  width: 98%;
  margin: 0 auto;
  display: grid;
  grid-template-columns: auto 120px;
  font-size: 10.5pt;
}

#por-grid li {
  margin: 2px 0;
}

#por-grid .duration {
  text-align: right;
}

#awards ul,
#interests ul {
  text-indent: -17px;
  margin-left: 22px;
}

@media print {
  body {
    -webkit-print-color-adjust: exact;
  }
}
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/js-yaml/4.1.0/js-yaml.min.js"></script>
  </head>
  <body class="A4" data-new-gr-c-s-check-loaded="14.1145.0" data-gr-ext-installed="">
    <section class="sheet padding-10mm">
      <img src="https://iiitd-resume.vercel.app/images/iiitd.png" class="iiitd-logo">
      <div id="page1">
        <div id="header">
          <h1 id="name">Ananya Lohani</h1>
          <p>
            <span id="roll-number">2019018</span> | <strong>Email:</strong>
            <a id="email" href="mailto:ananya19018@iiitd.ac.in">ananya19018@iiitd.ac.in</a>
          </p>
          <p>
            <strong>GitHub:</strong>
            <a id="github" target="_blank" href="https://ananya.li/gh">@ananyalohani</a> |
            <strong>LinkedIn:</strong>
            <a id="linkedin" target="_blank" href="https://ananya.li/linkedin">@ananyalohani</a>
          </p>
          <p>
            <strong>DOB:</strong>
            <span id="dob">11 June 2001</span> |
            <strong>Website:</strong>
            <a id="website" target="_blank" href="https://lohani.dev">lohani.dev</a>
          </p>
        </div>
        <div id="education" class="section">
          <h3 class="section-title">Education</h3>
        <div class="section-element">
            <div class="left">
              <p>
                <strong>
                  Indraprastha Institute of Information Technology, Delhi</strong>
              </p>
              <p>B.Tech. CSE</p>
              <p>2019 - 2023 (Present)</p>
            </div>
            <div class="right">
              <p><strong>CGPA:</strong> 9.35*</p>
              <p>(Till 4th Semester)</p>
            </div>
          </div><div class="section-element">
            <div class="left">
              <p>
                <strong>
                  CRPF Public School, Rohini</strong>
              </p>
              <p>CBSE Standard 12, PCM + CS</p>
              <p>2017 - 2019</p>
            </div>
            <div class="right">
              <p><strong>Percentage:</strong> 96%</p>
              <p></p>
            </div>
          </div></div>
        <div id="skills" class="section">
          <h3 class="section-title">Skills</h3>
          <div id="skill-grid"><div class="grid-row">
            <div class="grid-item"><strong>Expertise Area</strong></div>
            <div class="grid-item">Data Structures and Algorithms, Full Stack Development, Object Oriented Programming</div>
          </div><div class="grid-row">
            <div class="grid-item"><strong>Programming Languages</strong></div>
            <div class="grid-item">Java, JavaScript - 15k lines<br>C/C++ - 10k lines<br>Python, TypeScript - 5k lines</div>
          </div><div class="grid-row">
            <div class="grid-item"><strong>Tools and Technologies</strong></div>
            <div class="grid-item">Git, Next.js, ReactJS, NodeJS, GatsbyJS, GraphQL, HTML, CSS, TailwindCSS, Svelte, MongoDB, Mongoose, Firebase, MySQL</div>
          </div><div class="grid-row">
            <div class="grid-item"><strong>Technical Electives</strong></div>
            <div class="grid-item">Data Structures and Algorithms, Analysis and Design of Algorithms, Advanced Programming in Java, Computer Organization, Operating Systems, Discrete Maths, Database Management Systems</div>
          </div></div>
        </div>
        <div id="work-experience" class="section">
          <h3 class="section-title">Work Experience</h3>
        <div class="section-element">
            <div class="heading">
              <div class="left">
                <p><strong>Microsoft Engage</strong> | <a href="https://microsoft.acehacker.com/engage2021/">Website</a> </p>
                <p>Mentor: Mr. Shanav Asija, Senior SWE at Microsoft</p>
              </div>
              <div class="right">
                <p>Jun’ 21 - Present</p>
              </div>
            </div>
            <ul>
              
              <li>Awarded the opportunity to attend exclusive webinars and AMA sessions by Microsoft.</li><li>Designed, constructed and deployed a fully-featured video calling platform.</li>
            </ul>
          </div><div class="section-element">
            <div class="heading">
              <div class="left">
                <p><strong>Web Developer, O<span>f</span><span>f</span>icial Website of CSE Department IIIT Delhi</strong> | <a href="https://ananya.li/iiitd-cse">Website</a> (Ongoing)</p>
                <p>Supervisor: Dr. Koteswar Rao Jerripothula</p>
              </div>
              <div class="right">
                <p>Feb’ 21 - Present</p>
              </div>
            </div>
            <ul>
              <li><strong class="underline">Tech Stack:</strong> GatsbyJS, GraphQL, NetlifyCMS, CSS</li>
              <li>Designed and developed the o<span>f</span><span>f</span>icial website of the CSE department using GatsbyJS.</li><li>Deployed a headless CMS using NetlifyCMS and improved the management of website content and articles.</li>
            </ul>
          </div><div class="section-element">
            <div class="heading">
              <div class="left">
                <p><strong>Web Design Intern, Vinci Stationery</strong> | <a href="https://vincistationery.com">Website</a> </p>
                <p>Founder: Ms. Anisha Mata</p>
              </div>
              <div class="right">
                <p>Jan’ 21 - Feb’ 21</p>
              </div>
            </div>
            <ul>
              <li><strong class="underline">Tech Stack:</strong> Wix, JavaScript, Velo API</li>
              <li>Redesigned and restructured the o<span>f</span><span>f</span>icial e-commerce website of the company that brought in 200+ new users.</li><li>Delivered custom elements by using <strong>Velo API by Wix</strong>, like a custom product carousel.</li>
            </ul>
          </div><div class="section-element">
            <div class="heading">
              <div class="left">
                <p><strong>[Volunteer] Web Developer, Rising Star Khilte Chehre (NGO)</strong> | <a href="https://risingstarkhiltechehre.org">Website</a> </p>
                <p>Founder: Mr. Nishant Jain</p>
              </div>
              <div class="right">
                <p>May’ 21 - Present</p>
              </div>
            </div>
            <ul>
              <li><strong class="underline">Tech Stack:</strong> Wordpress, CSS, MySQL</li>
              <li>Improved accessibility by making the website colorblind-safe. Fixed UI bugs.</li><li>Building an authentication system for various stakeholders of the NGO.</li>
            </ul>
          </div></div>
      </div>
    </section>
    <!-- <section class="sheet padding-10mm">
      <div id="page2">
        <div id="projects" class="section">
          <h3 class="section-title">Projects</h3>
        <div class="section-element">
            <div class="heading">
              <div class="left">
                <p><strong>Microsoft Teams Clone</strong> | <a href="https://msft.lohani.dev/">Website</a>  | <a href="https://github.com/ananyalohani/teams">GitHub</a>  <em></em></p>
                <p>Capstone Project of Microsoft Engage 2021</p>
              </div>
              <div class="right">
                <p>Jun’ 21 - Present</p>
                <p>Individual</p>
              </div>
            </div>
            <ul>
              <li><strong class="underline">Tech Stack:</strong> Next.js, Tailwind CSS, Socket.io, Express, MongoDB, Mongoose, Twilio Video</li>
              <li>Designed and developed a fully-featured clone of Microsoft Teams using Agile methods.</li><li>Supports video call, group chat, authentication, network quality status, background filters, etc.</li><li>Equipped to handle 25+ participants exchanging media via an SFU provided by Twilio.</li>
            </ul>
          </div><div class="section-element">
            <div class="heading">
              <div class="left">
                <p><strong>IIITD Playbook</strong> | <a href="https://iiitdplaybook.web.app/homepage">Website</a>  | <a href="https://ananya.li/pb">GitHub</a>  <em></em></p>
                <p>Student Initiative</p>
              </div>
              <div class="right">
                <p>Jan’ 21 - Present</p>
                <p>Team Size: 5</p>
              </div>
            </div>
            <ul>
              <li><strong class="underline">Tech Stack:</strong> ReactJS, Google Firebase, CSS, Material-UI</li>
              <li>IIITD Playbook provides multiple strategies, experiences, and stories to guide the current students of the college.</li><li>Coded the homepage, supplies, quickbites, and internship pages and redesigned the footer.</li><li>Optimized the performance of the website by hosting static assets on Statically.</li><li>Mentored new members on the web development team.</li>
            </ul>
          </div><div class="section-element">
            <div class="heading">
              <div class="left">
                <p><strong>Mausam</strong> | <a href="https://ananya.li/mausam">Website</a>  | <a href="https://github.com/ananyalohani/mausam">GitHub</a>  <em></em></p>
                <p>Personal Project</p>
              </div>
              <div class="right">
                <p>May’ 21</p>
                <p>Individual</p>
              </div>
            </div>
            <ul>
              <li><strong class="underline">Tech Stack:</strong> React with TypeScript, TailwindCSS, SWR</li>
              <li>Mausam is a web app that fetches the weather data for the next 6 days from Metaweather API.</li><li>Engineered a search bar with autocompletion that fetches cities from OpenStreetMap API.</li>
            </ul>
          </div><div class="section-element">
            <div class="heading">
              <div class="left">
                <p><strong>Color Switch</strong> | <a href="https://github.com/ananyalohani/color-switch-java">GitHub</a>  <em></em></p>
                <p>Guide: Dr. Vivek Kumar</p>
              </div>
              <div class="right">
                <p>Nov’ 20 - Dec’ 20</p>
                <p>Team Size: 2</p>
              </div>
            </div>
            <ul>
              <li><strong class="underline">Tech Stack:</strong> Java, JavaFX, FXML, CSS, Gradle</li>
              <li>Developed a clone of the popular Play Store app Color Switch for desktop using object-oriented and event-driven programming.</li><li>Utilised the Serializable Interface in Java to save games.</li>
            </ul>
          </div><div class="section-element">
            <div class="heading">
              <div class="left">
                <p><strong>Perceptris</strong> | <a href="https://github.com/ananyalohani/Perceptris">GitHub</a>  <em>(Top 3 out of 100+ teams)</em></p>
                <p>Guide: Dr. Aman Parnami</p>
              </div>
              <div class="right">
                <p>Aug' 19 - Sep' 19</p>
                <p>Team Size: 3</p>
              </div>
            </div>
            <ul>
              <li><strong class="underline">Tech Stack:</strong> Arduino, Processing, C++</li>
              <li>Built a multiplayer, gesture-controlled version of the game Tetris using ultrasonic, touch and piezoelectric sensors.</li>
            </ul>
          </div></div>
        <div id="por" class="section">
          <h3 class="section-title">Positions of Responsibility</h3>
          <div id="por-grid">
          <div class="grid-row">
            <ul class="grid-item"><li><strong>Mentor</strong> at CollabConnect, a mentorship startup for students, founded by IIITD students.</li></ul>
            <span class="grid-item duration">Jul’ 21 - Present</span>
          </div>
        
          <div class="grid-row">
            <ul class="grid-item"><li><strong>Mentored</strong> the web development team of IIITD Playbook, consisting of 5 members.</li></ul>
            <span class="grid-item duration">Jan’ 21 - Present</span>
          </div>
        
          <div class="grid-row">
            <ul class="grid-item"><li><strong>Webmaster</strong> of the o<span>f</span><span>f</span>icial website of CSE department of IIIT Delhi.</li></ul>
            <span class="grid-item duration">Feb’ 21 - Present</span>
          </div>
        
          <div class="grid-row">
            <ul class="grid-item"><li><strong>President</strong> of Audiobytes, leading 80+ members of the music club of IIIT Delhi.</li></ul>
            <span class="grid-item duration">May’ 21 - Present</span>
          </div>
        
          <div class="grid-row">
            <ul class="grid-item"><li><strong>Cultural Council Member</strong>, organised events in IIITD with participation of 500+ students.</li></ul>
            <span class="grid-item duration">Jun’ 20 - Present</span>
          </div>
        
          <div class="grid-row">
            <ul class="grid-item"><li><strong>Event Head</strong> at Odyssey 2020 (cultural fest). Organised Acapellujah in a team of 3 with participation of 40+ colleges and amassed a sponsorship amount of INR 2 Lacs.</li></ul>
            <span class="grid-item duration">Oct’ 19 - Jan’ 20</span>
          </div>
        </div>
        </div>
        <div id="awards" class="section">
          <h3 class="section-title">Awards and Achievements</h3>
          <ul id="awards-list"><li><strong>Dean's List Award</strong> for Academic Excellence 2021.</li><li><strong>99.879th Percentile</strong> in JEE Main 2019 (Top 0.2%).</li><li><strong>Gold Medal</strong> in Intraschool Mathematics Olympiad 2018.</li><li>Awarded <strong>Distinction</strong> (highest grade) in Grade 3, Trinity Rock &amp; Pop Vocals exam in 2015.</li></ul>
        </div>
        <div id="interests" class="section">
          <h3 class="section-title">Interests and Hobbies</h3>
          <ul id="interests-list"><li><strong>Music</strong> - Active member of Audiobytes since 2019.</li><li><strong>Art</strong> - Made an <a href="https://www.instagram.com/lohani_art/">Instagram account</a> and <a href="https://www.youtube.com/channel/UCD027JiYyUAsKUrKOlms2iA">Youtube channel</a> dedicated to art.</li></ul>
        </div>
        <div>
          <p>
            <strong>Declaration:</strong> The above information is correct to
            the best of my knowledge.
          </p>
          <p id="signature">Ananya Lohani</p>
          <p id="last-updated">Date: 16 July 2021</p>
        </div>
      </div>
    </section> -->
  
</body></html>`,
    experienceHTML: `<div class="section-element">
    <div class="heading">
        <div class="left">
            <p><strong>{{position}}</strong> |  {{company_name}} </p>
            <p>Address: {{company_address}}</p>
        </div>
        <div class="right">
            <p>{{experience_start_month}}' {{experience_start_year}} - {{experience_end_month}}' {{experience_end_year}}</p>
        </div>
    </div>
    {{description}}
</div>`,
    educationHTML: `<div class="section-element">
    <div class="left">
      <p>
        <strong>
            {{school_name}}
        </strong>
      </p>
      <p>{{education_level}} {{discipline}}</p>
      <p>{{education_start_month}}' {{education_start_year}} - {{education_end_month}}' {{education_end_year}}</p>
    </div>
    <!-- <div class="right">
      <p><strong>CGPA:</strong> 9.35*</p>
      <p>(Till 4th Semester)</p>
    </div> -->
  </div>`,
    skillHTML: `<span>{{skill}}, </span>`,
    socialsHTML: `<strong> {{social_name}}:</strong>
    <a id="linkedin" target="_blank" href="">{{social_link}}</a>`,
    projectsHTML: `<div class="section-element">
    <div class="heading">
        <div class="left">
            <p><strong>{{project_title}}</strong> </p>
        </div>
        <div class="right">
            <p>{{project_start_month}}' {{project_start_year}} - {{project_end_month}}' {{project_end_year}}</p>
        </div>
    </div>
    {{project_description}}
</div>`,

certificationsHTML: `<div class="section-element">
<div class="heading">
    <div class="left">
        <p><strong>{{certification_title}}</strong> </p>
    </div>
    <div class="right">
        <p>{{certification_start_month}}' {{certification_start_year}} - {{certification_end_month}}' {{certification_end_year}}</p>
    </div>
</div>
{{certification_description}}
</div>`,

    experienceSection: `<div id="work-experience" class="section">
    <h3 class="section-title">Work Experience</h3>
    {{experience_list}}
</div>`,
    educationSection: `<div id="education" class="section">
    <h3 class="section-title">Education</h3>
    {{education_list}}
</div>`,
    projectSection: `<div id="work-experience" class="section">
    <h3 class="section-title">Projects</h3>
    {{projects_list}}
</div>`,
certificationSection: `<div id="work-experience" class="section">
<h3 class="section-title">TRAINING / COURSES / CERTIFICATIONS</h3>
{{certifications_list}}
</div>`,
    skillsSection: `<div id="skills" class="section">
    <h3 class="section-title">Skills</h3>
    <div id="skill-grid">
        <div class="grid-row">
            <div class="grid-item"><strong>{{skills_list}}</strong></div>
        </div>
    </div>
</div>`,
    websiteSection: `<strong>Website:</strong>
    <a id="website" target="_blank" href="https://lohani.dev">{{website}}</a>`,
    
    socialsSection: `<p>
    {{socials_list}}
</p>`,
phoneNumberSection: `<strong>Phone Number:</strong>
<span id="roll-number">{{phone_number}}</span> |`,

    // profilePicSection: `<img src="{{profile_picture}}" class="iiitd-logo"/>`,
    // referenceSection: ``,
    // referencesHTML: ``,
    // description: ``,
    // thumbnail: ``,
    createdAt: new Date(),
    updatedAt: new Date(),
}

module.exports = template4;