const template6 = 
{
  bodyHTML: `<html>

  <head>
      <title>Resume</title>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paper-css/0.4.1/paper.min.css">
  
      <style id="INLINE_PEN_STYLESHEET_ID">
          * {
              padding: 0;
              margin: 0;
          }
  
          body {
              font-family: "Calibri", sans-serif;
              font-size: 12px;
              line-height: 1.5;
              background: #fff;
          }
          ul, ol {
            list-style-position: inside !important;
            padding-left: 0 !important;
          }
          .intro p {
              display: block;
              margin-top: 15px;
              margin-bottom: 15px;
          }
  
          .main img {
              height: 150px;
              width: 150px;
          }
  
          .text-right {
              text-align: right;
          }
  
          .inline-block {
              display: inline-block;
          }
  
          table {
              padding: 15px;
              width: 100%;
          }
  
          .w-10 {
              width: 10%;
          }
  
          .w-20 {
              width: 20%;
          }
  
          .w-30 {
              width: 30%;
          }
  
          .w-40 {
              width: 40%;
          }
  
          .w-50 {
              width: 50%;
          }
  
          .w-60 {
              width: 60%;
          }
  
          .w-70 {
              width: 70%;
          }
  
          .w-80 {
              width: 80%;
          }
  
          .w-90 {
              width: 90%;
          }
  
          .w-100 {
              width: 100%;
          }
  
          .wrapper {
              margin: auto;
              background: #ffffff;
          }
  
          .intro {
              padding: 0 20px;
          }
  
          .intro h1 {
              text-transform: uppercase;
              margin-bottom: 10px;
          }
  
          .section-header {
              border-bottom: solid 3px #666666;
              margin-bottom: 20px;
          }
  
          .section {
              margin-top: 20px;
          }
  
          .section th {
              text-align: left;
              padding: 10px;
          }
  
          .section td {
              padding: 10px;
          }
  
          .list li {
              margin-bottom: 10px;
          }
  
          .sheet {
            height: max-content !important;
            min-height: 296mm;
            padding-bottom: 45px;
          }

            .w-100 { 
                page-break-inside:avoid;
                page-break-after:auto;
                padding-top: 10px;
            }
      </style>
  </head>
  
  <body class="A4" style="padding-top: 40px; padding-bottom: 40px;">
  
      <div class="wrapper sheet">
          <table class="main">
              <tbody>
                  <tr>
                      {{profile_pic_section}}
  
                      <td class="intro w-80">
                          <h1>{{first_name}} {{last_name}}</h1>
                          <p>
                              <span class="w-60 inline-block">
                                  <b>Email:</b> {{email}}
                              </span>
                              <!-- <span class="w-40 text-right">
                                  <b>DOB:</b> January ##, ####
                              </span> -->
                          </p>
                          {{address_section}}
                      </td>
                  </tr>
  
              </tbody>
          </table>
  
          <table>
              <tbody>
                  <tr>
                      <td>
                          <p>
                              <b>About me:</b> {{about_me}}
                          </p>
                      </td>
                  </tr>
              </tbody>
          </table>
  
          {{education_section}}
  
          {{skills_section}}
          
          <div></div>
  
          {{experience_section}}
  
          {{project_section}}

          {{certification_section}}
      </div>
  </body>
  
  </html>`,
  sampleHTML: `<html><head>
  <title>Resume</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paper-css/0.4.1/paper.min.css">

  <style id="INLINE_PEN_STYLESHEET_ID">
      * {
  padding: 0;
  margin: 0;
}

body {
  font-family: "Calibri", sans-serif;
  font-size: 12px;
  line-height: 1.5;
  background: #fff;
}

.intro p {
  display: block;
  margin-top: 15px;
  margin-bottom: 15px;
}

.main img {
  height: 150px;
  width: 150px;
}

.text-right {
  text-align: right;
}

.inline-block {
  display: inline-block;
}

table {
  padding: 15px;
  width: 100%;
}


.w-10 {
  width: 10%;
}

.w-20 {
  width: 20%;
}

.w-30 {
  width: 30%;
}

.w-40 {
  width: 40%;
}

.w-50 {
  width: 50%;
}

.w-60 {
  width: 60%;
}

.w-70 {
  width: 70%;
}

.w-80 {
  width: 80%;
}

.w-90 {
  width: 90%;
}

.w-100 {
  width: 100%;
}

.wrapper {
  margin: auto;
  background: #ffffff;
}

.intro {
  padding: 0 20px;
}

.intro h1 {
  text-transform: uppercase;
  margin-bottom: 10px;
}

.section-header {
  border-bottom: solid 3px #666666;
  margin-bottom: 20px;
}

.section {
  margin-top: 20px;
}

.section th {
  text-align: left;
  padding: 10px;
}

.section td {
  padding: 10px;
}

.list li {
  margin-bottom: 10px;
}

  </style>
</head>
<body class="A4" style="padding-top: 40px; padding-bottom: 40px;">

  <div class="wrapper sheet">
      <table class="main">
          <tbody><tr>
              <td class="w-20">
                  <img src="file:///C:/Users/David/Downloads/resume-template-master/assets/images/daiict-logo.jpg">
              </td>

              <td class="intro w-80">
                  <h1>Kunal Varma</h1>
                  <p>
                      <b>Dhirubhai Ambani Institute of Information and Communication Technology</b>
                  </p>
                  <p>
                      <span class="w-60 inline-block">
                      <b>Email:</b> #########@daiict.ac.in
                  </span>
                      <span class="w-40 text-right">
                      <b>DOB:</b> January ##, ####
                  </span>
                  </p>
                  <p>
                      <b>Address:</b> 4 Privet Drive, Little Whinging, Surrey.
                  </p>
              </td>

          </tr>

      </tbody></table>

      <table class="w-100 section">
          <tbody><tr>
              <td colspan="4" class="section-header">
                  <h3>EDUCATION</h3>
              </td>
          </tr>
          <tr>
              <th colspan="1">Degree</th>
              <th colspan="1">University/Institute</th>
              <th colspan="1">Year</th>
              <th colspan="1">CPI/Aggregate</th>
          </tr>
          <tr>
              <td>
                  <b>BSc. (IT)</b>
              </td>
              <td>
                  Department of Computer Science, Ganpat University, Ahmedabad, Gujarat
              </td>
              <td>
                  2013-2016
              </td>
              <td>
                  8.01
              </td>
          </tr>
          <tr>
              <td>
                  <b>Intermediate/+2</b>
              </td>
              <td>
                  St. Ann's High School, Sabarmati Ahmedabad, Gujarat Board
              </td>
              <td>
                  2011-2013
              </td>
              <td>
                  72.00%
              </td>
          </tr>
          <tr>
              <td>
                  <b>High School</b>
              </td>
              <td>
                  St. Ann's High School, Sabarmati Ahmedabad, Gujarat Board
              </td>
              <td>
                  2010-2011
              </td>
              <td>
                  81.00%
              </td>
          </tr>
      </tbody></table>

      <!-- <table class="w-100 section">
          <tbody><tr>
              <td colspan="2" class="section-header">
                  <h3>SKILLS</h3>
              </td>
          </tr>
          <tr>
              <td class="w-30">
                  <b>Expertise Area/Area(s) of
                  Interest</b>
              </td>
              <td class="w-70">
                  Web Development, API Development, Open Source
              </td>
          </tr>
          <tr>
              <td class="w-30">
                  <b>Programming Language(s)</b>
              </td>
              <td class="w-70">
                  PHP, Java, JavaScript, C
              </td>
          </tr>
          <tr>
              <td class="w-30">
                  <b>Tools and
                  Technologies</b>
              </td>
              <td class="w-70">
                  Laravel, Gulp, NodeJS, Github, Socket.io, VueJS, React JS
              </td>
          </tr>
          <tr>
              <td class="w-30">
                  <b>Technical Elective(s)</b>
              </td>
              <td class="w-70">
                  Software Testing, Cryptography
              </td>
          </tr>
      </tbody></table> -->
      <div></div>
      <table class="w-100 section">
          <tbody><tr>
              <td colspan="3" class="section-header">
                  <h3>PROFESSIONAL EXPERIENCE</h3>
              </td>
          </tr>
          <tr>
              <td class="w-20" valign="top">
                  <p>
                      <b>Pracly</b>
                  </p>
              </td>
              <td class="w-60" valign="top">
                  <p>
                      Pracly provides on-demand business advice for Businesses and Startups.
                  </p>
                  <p>
                      <i>Guide: Vijay Anand</i>
                  </p>
              </td>
              <td class="w-20" valign="top">
                  <p>(Sep, 13 - Feb, 15)</p>
                  <p>Team Size - 5</p>
              </td>
          </tr>
      </tbody></table>
      <table class="w-100 section">
          <tbody><tr>
              <td colspan="2" class="section-header">
                  <h3>PROJECTS</h3>
              </td>
          </tr>

          <tr>
              <td class="w-80" valign="top">
                  <p>
                      <b>Digital India Hackathon </b>
                  </p>
                  <p>
                      An Open For All Hackathon.
                  </p>
              </td>
              <td class="w-20" valign="top">
                  <p>(Feb, 15 - Feb, 17)</p>
                  <p>Team Size - 6</p>
              </td>
          </tr>

          <tr>
              <td class="w-80" valign="top">
                  <p>
                      <b>Dropbox PHP SDK</b>
                  </p>
                  <p>
                      An Unofficial SDK written in PHP for Dropbox’s V2 API. Listed by Dropbox on their website.
                  </p>
              </td>
              <td class="w-20" valign="top">
                  <p>(Jun, 16 -)</p>
              </td>
          </tr>
          <tr>
              <td class="w-80" valign="top">
                  <p>
                      <b>Eloquent</b>
                  </p>
                  <p>
                      An Open Source library to work with Local and Cloud Storage File Systems like Google Drive, Dropbox &amp; OneDrive through a unified API.
                      </p><p>
                          <i>Guide: Prof. X</i>
                      </p>
                  <p></p>
              </td>
              <td class="w-20" valign="top">
                  <p>(Oct, 16 - Nov, 16)</p>
              </td>
          </tr>
      </tbody></table>
      <!-- <table class="w-100 section">
          <tbody><tr>
              <td colspan="2" class="section-header">
                  <h3>POSITION OF RESPONSIBILITY</h3>
              </td>
          </tr>
          <tr>
              <td valign="top">
                  <ul class="list">
                      <li>
                          Member, Student Placement Cell, DAIICT
                      </li>
                      <li>
                          Member, The WebKit Club, DAIICT
                      </li>
                      <li>
                          Member, Google Developers Group, DAIICT
                      </li>
                  </ul>
              </td>
          </tr>
      </tbody></table> -->
      <!-- <table class="w-100 section">
          <tbody><tr>
              <td colspan="2" class="section-header">
                  <h3>AWARDS AND ACHIEVEMENTS</h3>
              </td>
          </tr>
          <tr>
              <td valign="top">
                  <ul class="list">
                      <li>
                          Runner Up @ Hackbaroda
                      </li>
                      <li>
                          Judge at IIT Vishwakarma College’s Hackathon
                      </li>
                  </ul>
              </td>
          </tr>
      </tbody></table> -->

      <!-- <table class="w-100 section">
          <tbody><tr>
              <td colspan="2" class="section-header">
                  <h3>INTERESTS AND HOBBIES</h3>
              </td>
          </tr>
          <tr>
              <td valign="top">
                  <ul class="list">
                      <li>
                          Playing Soccer
                      </li>
                      <li>
                          Contributing to Open Source
                      </li>
                      <li>
                          Attending and Organizing Hackathons
                      </li>
                  </ul>
              </td>
          </tr>
      </tbody></table> -->

  </div>

</body>
</html>`,
  experienceHTML: `<tr>
  <td class="w-20" valign="top">
      <p>
          <b>{{position}}</b>
      </p>
      <p>
          Company: <b>{{company_name}}</b>
      </p>
  </td>
  <td class="w-60" valign="top">
      <p>
          {{description}}
      </p>
  </td>
  <td class="w-20" valign="top">
      <p>({{experience_start_month}}, {{experience_start_year}} - {{experience_end_month}}, {{experience_end_year}})</p>
  </td>
</tr>`,
  educationHTML: `<tr>
  <td>
      <b>{{education_level}} ({{discipline}})</b>
  </td>
  <td>
      {{school_name}}
  </td>
  <td>
      {{education_start_year}} - {{education_end_year}}
  </td>
  <!-- <td>
      8.01
  </td> -->
</tr>`,
  skillHTML: `<span>{{skill}}, </span>`,

  projectsHTML: `<tr>
  <td class="w-80" valign="top">
      <p>
          <b>{{project_title}} </b>
      </p>
      <p>
          {{project_description}}
      </p>
  </td>
  <td class="w-20" valign="top">
      <p>({{project_start_month}}, {{project_start_year}} - {{project_end_month}}, {{project_end_year}})</p>
      <!-- <p>Team Size - 6</p> -->
  </td>
</tr>`,

certificationsHTML: `<tr>
<td class="w-80" valign="top">
    <p>
        <b>{{certification_title}} </b>
    </p>
    <p>
        {{certification_description}}
    </p>
</td>
<td class="w-20" valign="top">
    <p>({{certification_start_month}}, {{certification_start_year}} - {{certification_end_month}}, {{certification_end_year}})</p>
    <!-- <p>Team Size - 6</p> -->
</td>
</tr>`,

experienceSection: `<table class="w-100 section">
<tbody>
    <tr>
        <td colspan="3" class="section-header">
            <h3>PROFESSIONAL EXPERIENCE</h3>
        </td>
    </tr>
    {{experience_list}}
</tbody>
</table>`,
educationSection: `<table class="w-100 section">
<tbody>
    <tr>
        <td colspan="4" class="section-header">
            <h3>EDUCATION</h3>
        </td>
    </tr>
    <tr>
        <th colspan="1">Degree</th>
        <th colspan="1">University/Institute</th>
        <th colspan="1">Year</th>
        <!-- <th colspan="1">CPI/Aggregate</th> -->
    </tr>
    {{education_list}}
</tbody>
</table>`,
projectSection: `<table class="w-100 section">
<tbody>
    <tr>
        <td colspan="2" class="section-header">
            <h3>PROJECTS</h3>
        </td>
    </tr>
    {{projects_list}}
</tbody>
</table>`,
certificationSection: `<table class="w-100 section">
<tbody>
    <tr>
        <td colspan="2" class="section-header">
            <h3>TRAINING / COURSES / CERTIFICATIONS</h3>
        </td>
    </tr>
    {{certifications_list}}
</tbody>
</table>`,
skillsSection: `<table class="w-100 section">
<tbody>
    <tr>
        <td colspan="2" class="section-header">
            <h3>SKILLS</h3>
        </td>
    </tr>
    <tr>
        <td class="w-30">
            <b>Expertise Area/Area(s) of Interest</b>
        </td>
        <td class="w-70">
            {{skills_list}}
        </td>
    </tr>
</table>`,
profilePicSection: `<td class="w-20">
<img
    src="{{profile_picture}}"/>
</td>`,
addressSection: `<p>
<b>Address:</b> {{address}}
</p>`,

// websiteSection: ``,
// referenceSection: ``,
// socialsSection: ``,

// referencesHTML: ``,
// socialsHTML: ``,
  // description: ``,
  // thumbnail: ``,
  createdAt: new Date(),
  updatedAt: new Date()
}

module.exports = template6;