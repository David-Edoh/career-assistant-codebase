
const template2 = {
    bodyHTML: `<!DOCTYPE html>
    <html lang="en">
    <head>
        <title>Resume template</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- BOX ICONS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">

        <!-- CSS -->
        <link rel="stylesheet" href="assets/css/styles.css">

        <!-- Favicon -->
        <link rel="icon" href="assets/img/muhammad.jpg"  type="image/jpg">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paper-css/0.4.1/paper.min.css">
  
        <style id="INLINE_PEN_STYLESHEET_ID">
    /* GOOGLE FONTS */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');

/* VARIABLES CSS */
:root {
  --header-height: 3rem;

  /* Colors */
  --title-color: #0b0a0a;
  --text-color: #403a3a;
  --text-color-light: #707070;
  --container-color: #fafafa;
  --container-color-alt: #f0efef;
  --body-color: #fcfcfc;

  /* Font and typography */
  --body-font: 'Poppins', sans-serif;
  --h1-font-size: 1.5rem;
  --h2-font-size: 1.25rem;
  --h3-font-size: 1rem;
  --normal-font-size: 0.938rem;
  --small-font-size: 0.875rem;
  --smaller-font-size: 0.813rem;

  /* Font weight */
  --font-medium: 500;
  --font-semi-bold: 600;

  /* Margins */
  --mb-1: 0.5rem;
  --mb-2: 1rem;
  --mb-3: 1.5rem;

  /* z index */
  --z-tooltip: 10;
  --z-fixed: 100;
}

/* BASE */
*,
::before,
::after {
  box-sizing: border-box;
}

html {
  scroll-behavior: smooth;
}
ul, ol {
  list-style-position: inside !important;
  padding-left: 0 !important;
}
section { 
  page-break-inside:avoid;
  page-break-after:auto;
  /* padding-top: 20px; */
}

/* Variables Dark theme */
body.dark-theme{
  --title-color: #F2F2F2;
  --text-color: #BFBFBF;
  --container-color: #212121;
  --container-color-alt: #181616;
  --body-color: #2B2B2B;
}


/* Button Dark/Light */
.change-theme{
  position: absolute;
  right: 0;
  top: 2.2rem;
  display: flex;
  color: var(--text-color);
  font-size: 1.2rem;
  cursor: pointer;
}

.change-theme:hover{
  color: var(--text-color);
}
/* Font size variables to scale cv */
body.scale-cv{
  --h1-font-size: .938rem;
  --h2-font-size: .938rem;
  --h3-font-size: .875rem;
  --normal-font-size: 0.813rem;
  --small-font-size: 0.75rem;
  --smaller-font-size: 0.688rem;
}
/* Generate PDF button */
.generate-pdf{
  display: none;
  position: absolute;
  top: 2.2rem;
  left: 0;
  font-size: 1.2rem;
  color: var(--text-color);
  cursor: pointer;
}

.generate-pdf:hover{
  color: var(--title-color);
}
/* Classes modified to reduce size and print on A4 sheet */
.scale-cv .change-theme,
.scale-cv .generate-pdf{
  display: none;
}

.scale-cv .bd-container{
  max-width: 700px;
}

.scale-cv .section{
  padding: 1.5rem 0 .80rem;
}

.scale-cv .section-title{
  margin-bottom: .75rem;
}

.scale-cv .resume_left,
.scale-cv .resume_right{
  padding: 0 1rem;
}

.scale-cv .home_img{
  width: 85px;
  height: 85px;
}

.scale-cv .home_container{
  gap: 1rem;
}

.scale-cv .home_data{
  gap: .10rem;
}

.scale-cv .profile_description {
  font-size: 12px;
}

.scale-cv .home_address,
.scale-cv .social_container{
  gap: .55rem;
}

.scale-cv .home_icon,
.scale-cv .social_icon,
.scale-cv .interests_icon{
  font-size: 1rem;
}

.scale-cv .education_container,
.scale-cv .experience_container,
.scale-cv .certificate_container{
  gap: 0;
}

.scale-cv .education_time,
.scale-cv .experience_time{
  padding-right: 1rem;
}

.scale-cv .education_rounder,
.scale-cv .experience_rounder{
  width: 11px;
  height: 11px;
  margin-top: .2rem;
}

.scale-cv .education_line{
  width: 1px;
  height: 70px;
  transform: translate(5px, 0);
}

.scale-cv .education_title,
.scale-cv .education_studies{
  font-size: 12px;
}

.scale-cv .experience_line{
  width: 1px;
  height: 130px;
  transform: translate(5px, 0);
}

.scale-cv .education_data,
.scale-cv .experience_data{
  gap: .20rem;
  font-size: 12px;
}


.scale-cv .skills_name{
  margin-bottom: var(--mb-1);
  font-size: 13px;
}

.scale-cv .interests_container{
  column-gap: 1.5rem;
  font-size: 10px;
}

body {
  margin: 0 0 var(--header-height) 0;
  padding: 0;
  font-family: var(--body-font);
  font-size: var(--normal-font-size);
  background-color: var(--body-color);
  color: var(--text-color);
}

h1,
h2,
h3,
ul,
p {
  margin: 0;
}

h1,
h2,
h3 {
  color: var(--title-color);
  font-weight: var(--font-medium);
}

ul {
  padding: 0;
  list-style: none;
}

a {
  text-decoration: none;
}

img {
  max-width: 100%;
  height: auto;
}

/* CLASS CSS */
.section {
  padding: 1rem 0;
}

.section-title {
  font-size: var(--h2-font-size);
  color: var(--title-color);
  font-weight: var(--font-semi-bold);
  text-transform: uppercase;
  letter-spacing: 0.35rem;
  text-align: center;
  margin-bottom: var(--mb-3);
}

/* LAYOUT */
.bd-container {
  max-width: 968px;
  width: calc(100% - 3rem);
  margin-left: var(--mb-3);
  margin-right: var(--mb-3);
}

.bd-grid {
  display: grid;
  gap: 1.5rem;
}

.l-header {
  width: 100%;
  position: fixed;
  bottom: 0;
  left: 0;
  z-index: var(--z-fixed);
  background-color: var(--body-color);
  box-shadow: 0 -1px 4px rgba(0, 0, 0, 0.1);
  transition: 0.3s;
}

/* NAV */
.nav {
  height: var(--header-height);
  display: flex;
  justify-content: space-between;
  align-items: center;
}


/* HOME */
.home{
  position: relative;
}
.home_container{
  gap: 3rem;
}

.home_data{
  gap: .5rem;
  text-align: center;
}

.home_img{
  width: 120px;
  height: 120px;
  margin: auto;
  border-radius: 50%;
  justify-content: center;
  margin-bottom: var(--mb-1);
}

.home_title {
  font-size: var(--h1-font-size);
}

.home_profession{
  font-size: var(--normal-font-size);
  margin-bottom: var(--mb-1);
}

.home_address{
  gap: 1rem;
}

.home_information{
  display: flex;
  align-items: center;
  font-size: var(--smaller-font-size);
}

.home_icon {
  font-size: 1.2rem;
  margin-right: 25rem;
}

.home_button-movil{
  display: inline-block;
  border: 2px solid var(--text-color);
  color: var(--title-color);
  padding: 1rem 2rem;
  border-radius: 25rem;
  transition: .3s;
  font-weight: var(--font-medium);
  margin-top: var(--mb-3);
}

.home_button-movil:hover{
  background-color: var(--text-color);
  color: var(--container-color);
}

/* SOCIAL */
.social_container{
  grid-template-columns: max-content;
  gap: 1rem;
}

.social_link{
  display: inline-flex;
  align-items: center;
  font-size: var(--small-font-size);
  color: var(--text-color);
}

.social_link:hover{
  color: var(--title-color);
}

.social_icon{
  font-size: 1.2rem;
  margin-right: .25rem;
}
/* PROFILE */
.profile_description{
  text-align: center;
}
/* EDUCATION AND EXPERIENCE */
.education_content,
.experience_content{
  display: flex;
}

.education_time,
.experience_time{
  padding-right: 1rem;
}

.education_rounder,
.experience_rounder{
  position: relative;
  display: block;
  width: 16px;
  height: 16px;
  background-color: var(--text-color-light);
  border-radius: 50%;
  margin-top: .25rem;
}

.education_line,
.experience_line{
  display: block;
  width: 2px;
  height: 110%;
  background-color: var(--text-color-light);
  transform: translate(7px, 0);
}

.education_data,
.experience_data{
  gap: .5rem;
}

.education_title,
.experience_title{
  font-size: var(--h3-font-size);
}

.education_studies,
.experience_company{
  font-size: var(--small-font-size);
  color: var(--title-color);
}

.education_year{
  font-size: var(--smaller-font-size);
}
/* SKILLS AND LANGUAGES */
.skills_content,
.languages_content{
  grid-template-columns: repeat(2, 1fr);
}

.languages_content{
  gap: 0;
}

.skills_name,
.languages_name{
  display: flex;
  align-items: center;
  margin-bottom: var(--mb-3);
}

.skills_circle,
.languages_circle{
  display: inline-block;
  width: 5px;
  height: 5px;
  background-color: var(--text-color);
  border-radius: 50%;
  margin-right: .75rem;
}
/* CERTIFICATES */
.certificate_title{
  font-size: var(--h3-font-size);
  margin-bottom: var(--mb-1);
}
/* REFERENCES */
.references_content{
  gap: .25rem;
}

.references_subtitle{
  color: var(--text-color-light);
}

.references_subtitle,
.references_contact{
  font-size: var(--smaller-font-size);
}
/* INTERESTS */
.interests_container{
  grid-template-columns: repeat(3, 1fr);
  margin-top: var(--mb-2);
}

.interests_content{
  display: flex;
  flex-direction: column;
  align-items: center;
}

.interests_icon{
  font-size: 1.5rem;
  color: var(--text-color-light);
  margin-bottom: .25rem;
}
/* Scroll top */
.scrolltop{
  position: fixed;
  right: 1rem;
  bottom: 5rem;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: .3rem;
  background-color: var(--container-color-alt);
  border-radius: .4rem;
  z-index: var(--z-tooltip);
  transition: .4s;
  /* visibility: hidden; */
}

.scrolltop_icon{
  font-size: 1.2rem;
  color: var(--text-color);
}

.show-scroll{
  visibility: visible;
  bottom: 5rem;
}
/*========== MEDIA QUERIES ==========*/
 /* For small devices, menu two columns  */
/* @media screen and (max-width: 320px){
  .nav_list{
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem .5rem;
  }
} */


/* Classes modified for large screen size */
/* @media screen and (min-width: 968px){ */
  body{
  /* margin: 3rem 0; */
  }

  .sheet{
    min-height: 296mm;
    height: max-content !important;
  }

  .bd-container{
    margin: auto;
    margin-right: auto;
  }

  .l-header,
  .scrolltop{
    display: none;
  }

  .resume{
    display: grid;
    grid-template-columns: .5fr 1fr;
    height: 100%;
    min-height: 296mm;
  }

  .resume__left{
    background-color: var(--container-color-alt);
  }

  .resume__left,
  .resume__right{
    padding: 0 1.5rem;
  }

  .generate-pdf{
    display: inline-block;
  }

  .section-title,
  .profile_description{
    text-align: initial;
    gap: 0;
  }

  .home__container{
    gap: 1.5rem;
  }

  .home_button-movil{
    display: none;
  }

  .references_container{
    grid-template-columns: repeat(2, 1fr);
  }

  .languages_content{
    grid-template-columns: repeat(3, max-content);
    column-gap: 3.5rem;
  }

  .interests_container{
    grid-template-columns: repeat(4, max-content);
    column-gap: 3.5rem;
  }
/* } */
</style>
    </head>
    <body class="A4">
        <main class="l-main bd-container sheet">
            <!-- All elements within this div, is generated in PDF -->
            <div class="resume" id="area-cv">
                <div class="resume__left">
                    <!-- HOME -->
                    <section class="home" id="home">
                        <div class="home_containter section bd-grid">
                            <div class="home_data bd-grid">
                                {{profile_pic_section}}
                                <h1 class="home_title">{{first_name}} <b>{{last_name}}</b></h1>
                                <h3 class="home_profession">{{occupation}}</h3>
                            </div>
                            <div class="home_address bd-grid">
                                {{address_section}}
                                <span class="home_information">
                                    <i class="bx bx-envelope"> &nbsp; </i> {{email}}
                                </span>
                                {{phone_number_section}}
                            </div>
                        </div>
                    </section>          
                    
                    <!-- SOCIAL -->
                    {{socials_section}}
                    <!-- PROFILE -->
                    <section class="profile section" id="profile">
                        <h2 class="section-title">Profile</h2>
                        <p class="profile_description">
                            {{about_me}}
                        </p>
                    </section>
                    
                    <!-- EDUCATION -->
                    {{education_section}}
                    <!-- SKILLS  -->
                    {{skills_section}}
                </div>
                <div class="resume__right">
                    <!-- EXPERIENCE -->
                    {{experience_section}}
                    <!-- PROJECTS -->
                    {{project_section}}
                    {{certification_section}}
                    <!-- REFERENCES -->
                    {{reference_section}}
                </div>
            </div>        
        </main> 
    </body> <br>
</html>`,
    sampleHTML: `<!DOCTYPE html>
    <html lang="en">
    <head>
        <title>Resume template</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- BOX ICONS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">

        <!-- CSS -->
        <link rel="stylesheet" href="assets/css/styles.css">

        <!-- Favicon -->
        <link rel="icon" href="assets/img/muhammad.jpg"  type="image/jpg">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paper-css/0.4.1/paper.min.css">
  
        <style id="INLINE_PEN_STYLESHEET_ID">
    /* GOOGLE FONTS */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');

/* VARIABLES CSS */
:root {
  --header-height: 3rem;

  /* Colors */
  --title-color: #0b0a0a;
  --text-color: #403a3a;
  --text-color-light: #707070;
  --container-color: #fafafa;
  --container-color-alt: #f0efef;
  --body-color: #fcfcfc;

  /* Font and typography */
  --body-font: 'Poppins', sans-serif;
  --h1-font-size: 1.5rem;
  --h2-font-size: 1.25rem;
  --h3-font-size: 1rem;
  --normal-font-size: 0.938rem;
  --small-font-size: 0.875rem;
  --smaller-font-size: 0.813rem;

  /* Font weight */
  --font-medium: 500;
  --font-semi-bold: 600;

  /* Margins */
  --mb-1: 0.5rem;
  --mb-2: 1rem;
  --mb-3: 1.5rem;

  /* z index */
  --z-tooltip: 10;
  --z-fixed: 100;
}

/* BASE */
*,
::before,
::after {
  box-sizing: border-box;
}

html {
  scroll-behavior: smooth;
}

/* Variables Dark theme */
body.dark-theme{
  --title-color: #F2F2F2;
  --text-color: #BFBFBF;
  --container-color: #212121;
  --container-color-alt: #181616;
  --body-color: #2B2B2B;
}


/* Button Dark/Light */
.change-theme{
  position: absolute;
  right: 0;
  top: 2.2rem;
  display: flex;
  color: var(--text-color);
  font-size: 1.2rem;
  cursor: pointer;
}

.change-theme:hover{
  color: var(--text-color);
}
/* Font size variables to scale cv */
body.scale-cv{
  --h1-font-size: .938rem;
  --h2-font-size: .938rem;
  --h3-font-size: .875rem;
  --normal-font-size: 0.813rem;
  --small-font-size: 0.75rem;
  --smaller-font-size: 0.688rem;
}
/* Generate PDF button */
.generate-pdf{
  display: none;
  position: absolute;
  top: 2.2rem;
  left: 0;
  font-size: 1.2rem;
  color: var(--text-color);
  cursor: pointer;
}

.generate-pdf:hover{
  color: var(--title-color);
}
/* Classes modified to reduce size and print on A4 sheet */
.scale-cv .change-theme,
.scale-cv .generate-pdf{
  display: none;
}

.scale-cv .bd-container{
  max-width: 700px;
}

.scale-cv .section{
  padding: 1.5rem 0 .80rem;
}

.scale-cv .section-title{
  margin-bottom: .75rem;
}

.scale-cv .resume_left,
.scale-cv .resume_right{
  padding: 0 1rem;
}

.scale-cv .home_img{
  width: 85px;
  height: 85px;
}

.scale-cv .home_container{
  gap: 1rem;
}

.scale-cv .home_data{
  gap: .10rem;
}

.scale-cv .profile_description {
  font-size: 12px;
}

.scale-cv .home_address,
.scale-cv .social_container{
  gap: .55rem;
}

.scale-cv .home_icon,
.scale-cv .social_icon,
.scale-cv .interests_icon{
  font-size: 1rem;
}

.scale-cv .education_container,
.scale-cv .experience_container,
.scale-cv .certificate_container{
  gap: 0;
}

.scale-cv .education_time,
.scale-cv .experience_time{
  padding-right: 1rem;
}

.scale-cv .education_rounder,
.scale-cv .experience_rounder{
  width: 11px;
  height: 11px;
  margin-top: .2rem;
}

.scale-cv .education_line{
  width: 1px;
  height: 70px;
  transform: translate(5px, 0);
}

.scale-cv .education_title,
.scale-cv .education_studies{
  font-size: 12px;
}

.scale-cv .experience_line{
  width: 1px;
  height: 130px;
  transform: translate(5px, 0);
}

.scale-cv .education_data,
.scale-cv .experience_data{
  gap: .20rem;
  font-size: 12px;
}


.scale-cv .skills_name{
  margin-bottom: var(--mb-1);
  font-size: 13px;
}

.scale-cv .interests_container{
  column-gap: 1.5rem;
  font-size: 10px;
}

body {
  margin: 0 0 var(--header-height) 0;
  padding: 0;
  font-family: var(--body-font);
  font-size: var(--normal-font-size);
  background-color: var(--body-color);
  color: var(--text-color);
}

h1,
h2,
h3,
ul,
p {
  margin: 0;
}

h1,
h2,
h3 {
  color: var(--title-color);
  font-weight: var(--font-medium);
}

ul {
  padding: 0;
  list-style: none;
}

a {
  text-decoration: none;
}

img {
  max-width: 100%;
  height: auto;
}

/* CLASS CSS */
.section {
  padding: 1rem 0;
}

.section-title {
  font-size: var(--h2-font-size);
  color: var(--title-color);
  font-weight: var(--font-semi-bold);
  text-transform: uppercase;
  letter-spacing: 0.35rem;
  text-align: center;
  margin-bottom: var(--mb-3);
}

/* LAYOUT */
.bd-container {
  max-width: 968px;
  width: calc(100% - 3rem);
  margin-left: var(--mb-3);
  margin-right: var(--mb-3);
}

.bd-grid {
  display: grid;
  gap: 1.5rem;
}

.l-header {
  width: 100%;
  position: fixed;
  bottom: 0;
  left: 0;
  z-index: var(--z-fixed);
  background-color: var(--body-color);
  box-shadow: 0 -1px 4px rgba(0, 0, 0, 0.1);
  transition: 0.3s;
}

/* NAV */
.nav {
  height: var(--header-height);
  display: flex;
  justify-content: space-between;
  align-items: center;
}


/* HOME */
.home{
  position: relative;
}
.home_container{
  gap: 3rem;
}

.home_data{
  gap: .5rem;
  text-align: center;
}

.home_img{
  width: 120px;
  height: 120px;
  margin: auto;
  border-radius: 50%;
  justify-content: center;
  margin-bottom: var(--mb-1);
}

.home_title {
  font-size: var(--h1-font-size);
}

.home_profession{
  font-size: var(--normal-font-size);
  margin-bottom: var(--mb-1);
}

.home_address{
  gap: 1rem;
}

.home_information{
  display: flex;
  align-items: center;
  font-size: var(--smaller-font-size);
}

.home_icon {
  font-size: 1.2rem;
  margin-right: 25rem;
}

.home_button-movil{
  display: inline-block;
  border: 2px solid var(--text-color);
  color: var(--title-color);
  padding: 1rem 2rem;
  border-radius: 25rem;
  transition: .3s;
  font-weight: var(--font-medium);
  margin-top: var(--mb-3);
}

.home_button-movil:hover{
  background-color: var(--text-color);
  color: var(--container-color);
}

/* SOCIAL */
.social_container{
  grid-template-columns: max-content;
  gap: 1rem;
}

.social_link{
  display: inline-flex;
  align-items: center;
  font-size: var(--small-font-size);
  color: var(--text-color);
}

.social_link:hover{
  color: var(--title-color);
}

.social_icon{
  font-size: 1.2rem;
  margin-right: .25rem;
}
/* PROFILE */
.profile_description{
  text-align: center;
}
/* EDUCATION AND EXPERIENCE */
.education_content,
.experience_content{
  display: flex;
}

.education_time,
.experience_time{
  padding-right: 1rem;
}

.education_rounder,
.experience_rounder{
  position: relative;
  display: block;
  width: 16px;
  height: 16px;
  background-color: var(--text-color-light);
  border-radius: 50%;
  margin-top: .25rem;
}

.education_line,
.experience_line{
  display: block;
  width: 2px;
  height: 110%;
  background-color: var(--text-color-light);
  transform: translate(7px, 0);
}

.education_data,
.experience_data{
  gap: .5rem;
}

.education_title,
.experience_title{
  font-size: var(--h3-font-size);
}

.education_studies,
.experience_company{
  font-size: var(--small-font-size);
  color: var(--title-color);
}

.education_year{
  font-size: var(--smaller-font-size);
}
/* SKILLS AND LANGUAGES */
.skills_content,
.languages_content{
  grid-template-columns: repeat(2, 1fr);
}

.languages_content{
  gap: 0;
}

.skills_name,
.languages_name{
  display: flex;
  align-items: center;
  margin-bottom: var(--mb-3);
}

.skills_circle,
.languages_circle{
  display: inline-block;
  width: 5px;
  height: 5px;
  background-color: var(--text-color);
  border-radius: 50%;
  margin-right: .75rem;
}
/* CERTIFICATES */
.certificate_title{
  font-size: var(--h3-font-size);
  margin-bottom: var(--mb-1);
}
/* REFERENCES */
.references_content{
  gap: .25rem;
}

.references_subtitle{
  color: var(--text-color-light);
}

.references_subtitle,
.references_contact{
  font-size: var(--smaller-font-size);
}
/* INTERESTS */
.interests_container{
  grid-template-columns: repeat(3, 1fr);
  margin-top: var(--mb-2);
}

.interests_content{
  display: flex;
  flex-direction: column;
  align-items: center;
}

.interests_icon{
  font-size: 1.5rem;
  color: var(--text-color-light);
  margin-bottom: .25rem;
}
/* Scroll top */
.scrolltop{
  position: fixed;
  right: 1rem;
  bottom: 5rem;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: .3rem;
  background-color: var(--container-color-alt);
  border-radius: .4rem;
  z-index: var(--z-tooltip);
  transition: .4s;
  /* visibility: hidden; */
}

.scrolltop_icon{
  font-size: 1.2rem;
  color: var(--text-color);
}

.show-scroll{
  visibility: visible;
  bottom: 5rem;
}
/*========== MEDIA QUERIES ==========*/
 /* For small devices, menu two columns  */
/* @media screen and (max-width: 320px){
  .nav_list{
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem .5rem;
  }
} */


/* Classes modified for large screen size */
/* @media screen and (min-width: 968px){ */
  body{
    margin: 3rem 0;
  }

  .bd-container{
    margin: auto;
    margin-right: auto;
  }

  .l-header,
  .scrolltop{
    display: none;
  }

  .resume{
    display: grid;
    grid-template-columns: .5fr 1fr;
    height: 100%;
  }

  .resume__left{
    background-color: var(--container-color-alt);
  }

  .resume__left,
  .resume__right{
    padding: 0 1.5rem;
  }

  .generate-pdf{
    display: inline-block;
  }

  .section-title,
  .profile_description{
    text-align: initial;
    gap: 0;
  }

  .home__container{
    gap: 1.5rem;
  }

  .home_button-movil{
    display: none;
  }

  .references_container{
    grid-template-columns: repeat(2, 1fr);
  }

  .languages_content{
    grid-template-columns: repeat(3, max-content);
    column-gap: 3.5rem;
  }

  .interests_container{
    grid-template-columns: repeat(4, max-content);
    column-gap: 3.5rem;
  }
/* } */
</style>
    </head>
    <body class="A4">
        <main class="l-main bd-container sheet">
            <!-- All elements within this div, is generated in PDF -->
            <div class="resume" id="area-cv">
                <div class="resume__left">
                    <!-- HOME -->
                    <section class="home" id="home">
                        <div class="home_containter section bd-grid">
                            <div class="home_data bd-grid">
                                <img src="https://fahadulshadhin.github.io/Resume-template/img/profile-image.jpg" alt="" class="home_img center">
                                <h1 class="home_title">MUHAMMAD <b>ESSA</b></h1>
                                <h3 class="home_profession">Web Developer</h3>
                                <!-- Button to generate and download the pdf. Available for desktop. -->
                                <div>
                                    <a download="" href="assets/pdf/Muhammadessa-resume.pdf" class="home_button-movil">Download</a>
                                </div>
                            </div>
                            <div class="home_address bd-grid">
                                <span class="home_information">
                                    <i class="bx bx-map"> &nbsp; </i> Peshawar, Pakistan 
                                </span>
                                <span class="home_information">
                                    <i class="bx bx-envelope"> &nbsp; </i> iMuhammadessa@gmail.com
                                </span>
                                <span class="home_information">
                                    <i class="bx bx-phone"> &nbsp; </i> +92 (345) 9257074
                                </span>
                            </div>
                        </div>
                        
                        <!-- Theme change button -->
                        <!-- <i class="bx bx-moon change-theme" title="Theme" id="theme-button"></i> -->
                        <!-- Button to generate and download the pdf. Available for desktop -->
                        <!-- <i class="bx bx-download generate-pdf" title="Generate PDF" id="resume-button"></i> -->
                    </section>          
                    
                    <!-- SOCIAL -->
                    <section class="social section">
                        <h2 class="section-title">SOCIAL</h2>
                        <div class="social_container bd-grid">
                            <a href="https://www.linkedin.com/in/imuhammadessa/" target="_blank" class="social_link">
                                <i class="bx bxl-linkedin-square social_icon"></i> @imuhammadessa
                            </a>
                            <a href="https://github.com/imuhammadessa/" target="_blank" class="social_link">
                                <i class="bx bxl-github social_icon"></i> @imuhammadessa
                            </a>
                            <a href="https://twitter.com/imuhammadessa" target="_blank" class="social_link">
                                <i class="bx bxl-twitter social_icon"></i> @imuhammadessa
                            </a>
                        </div>
                    </section>
                    <!-- PROFILE -->
                    <section class="profile section" id="profile">
                        <h2 class="section-title">Profile</h2>
                        <p class="profile_description">
                            I am a person, very responsible for work during working hours assigned by a company. I am very goal oriented, result driven, detailed and focused person. I have several years of experiences & achievements in this field.
                        </p>
                    </section>
                    
                  

                </div>
                <div class="resume__right">
                    <!-- EXPERIENCE -->
                    <section class="experience section" id="experience">
                        <h2 class="section-title">Experience</h2>
                        <div class="experience_container bd-grid">
                            <div class="experience_content">
                                <div class="experience_time">
                                    <span class="experience_rounder"></span>
                                    <span class="experience_line"></span>
                                </div>
                                <div class="experience_data bd-grid">
                                    <h3 class="experience_title">WEB DEVELOPER</h3>
                                    <span class="experience_company">April 2021 - Till date | <a href="https://itartificer.com/">IT Artificer</a> </span>
                                    <p class="experience_description">
                                        After getting some experience, I hired as <b>Jr. Web Developer</b> at <a href="https://itartificer.com/">IT Artificer</a> in April 2021. ITA serving its Services all over the world especially in middle-east. ITA mainly focusing on delivering high quality software solutions which enable customers to achieve their critical IT objectives.
                                    </p>
                                </div>
                            </div>
                            <div class="experience_content">
                                <div class="experience_time">
                                    <span class="experience_rounder"></span>
                                    <!-- <span class="experience_line"></span> -->
                                </div>
                                <div class="experience_data bd-grid">
                                    <h3 class="experience_title">FRONTEND DEVELOPER</h3>
                                    <span class="experience_company">Nov 2020 - Dec 2020 | <a href="https://interns.pk/">Interns Pakistan</a></span>
                                    <p class="experience_description">
                                        As soon I graduated I selected as <b>Frontend Developer</b> at <a href="https://interns.pk/">Interns Pakistan</a> in November 2020. Interns Pakistan is a company who helping fresh graduates remotely by providing an internships. I awarded the best intern award by Interns Pakistan.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- REFERENCES -->
                    <section class="references section" id="references">
                        <h2 class="section-title">References</h2>
                        <div class="references_container bd-grid">
                            <div class="references_content bd-grid">
                                <span class="references_subtitle">CEO IT-Artificer</span>
                                <h3 class="references_title">Mr. Haider Ali</h3>
                                <ul class="references_contact">
                                    <li>Phone:  +92-333-9296314</li>
                                    <li>Email:  thehaider@yahoo.com</li>
                                </ul>
                            </div>
                            <div class="references_content bd-grid">
                                <span class="references_subtitle">Professor</span>
                                <h3 class="references_title">Dr. Irshad Ahmad</h3>
                                <ul class="references_contact">
                                    <li>Phone:  091-9222258</li>
                                    <li>Email:  Irshad.ahmad@icp.edu.pk</li>
                                </ul>
                            </div>
                        </div>
                    </section>

                </div>
            </div>        
        </main> 

        <!-- SCROLL TOP -->
            <a href="#" class="scrolltop" id="scrolltop">
                <i class="bx bx-up-arrow-alt scrolltop_icon"></i>
            </a>

        <!-- HTML2PDF -->
        <script src="assets/js/html2pdf.bundle.min.js"></script>
        
        <!-- MAIN JS -->
        <script src="assets/js/main.js"></script>
    </body> <br>
</html>`,
    experienceHTML: `<div class="experience_content">
    <div class="experience_time">
        <span class="experience_rounder"></span>
        <span class="experience_line"></span>
    </div>
    <div class="experience_data bd-grid">
        <h3 class="experience_title">{{position}}</h3>
        <span class="experience_company">{{experience_start_month}} {{experience_start_year}} - {{experience_end_month}} {{experience_end_year}} | {{position}} </span>
        <p class="experience_description">
            {{description}}
        </p>
    </div>
</div>`,
    educationHTML: `<div class="education_content">
    <div class="education_time">
        <span class="education_rounder"></span>
        <span class="education_line"></span>
    </div>
    <div class="education_data bd-grid">
        <h3 class="education_title">{{education_level}} {{discipline}}</h3>
        <span class="education_studies">{{school_name}}</span>
        <span class="education_year">{{education_start_month}} {{education_start_year}} - {{education_end_month}} {{education_end_year}}</span>
    </div>
</div>`,
    skillHTML: `<li class="skills_name">
    <span class="skills_circle"></span> {{skill}}
</li>`,
    socialsHTML: `<a href="https://www.linkedin.com/in/imuhammadessa/" target="_blank" class="social_link">
    <i class="bx bx-link social_icon"></i> {{social_link}}
</a>`,
    projectsHTML: `<div class="experience_content">
    <div class="experience_time">
        <span class="experience_rounder"></span>
        <span class="experience_line"></span>
    </div>
    <div class="experience_data bd-grid">
        <h3 class="experience_title">{{project_title}}</h3>
        <span class="experience_company">{{project_start_month}} {{project_start_year}} - {{project_end_month}} {{project_end_year}} </span>
        <p class="experience_description">
            {{project_description}}
        </p>
    </div>
</div>`,
certificationsHTML: `<div class="experience_content">
<div class="experience_time">
    <span class="experience_rounder"></span>
    <span class="experience_line"></span>
</div>
<div class="experience_data bd-grid">
    <h3 class="experience_title">{{certification_title}}</h3>
    <span class="experience_company">{{certification_start_month}} {{certification_start_year}} - {{certification_end_month}} {{certification_end_year}} </span>
    <p class="experience_description">
        {{certification_description}}
    </p>
</div>
</div>`,
    referencesHTML: `<div class="references_content bd-grid">
    <span class="references_subtitle">{{reference_position}} {{reference_company}}</span>
    <h3 class="references_title">{{reference_name}}</h3>
    <ul class="references_contact">
        <li>Phone:  {{reference_phonenumber}}</li>
        <li>Email:  {{reference_email}}</li>
    </ul>
</div>`,
    experienceSection: `<section class="experience section" id="experience">
    <h2 class="section-title">Experience</h2>
    <div class="experience_container bd-grid">
        {{experience_list}}
    </div>
</section>`,
    educationSection: `<section class="education section" id="education">
    <h2 class="section-title">Education</h2>
    <div class="education_container bd-grid">
        {{education_list}}
    </div>
</section>`,
    projectSection: `<section class="experience section" id="experience">
    <h2 class="section-title">Projects</h2>
    <div class="experience_container bd-grid">
        {{projects_list}}
    </div>
</section>`,
certificationSection: `<section class="experience section" id="experience">
<h2 class="section-title">TRAINING / COURSES / CERTIFICATIONS</h2>
<div class="experience_container bd-grid">
    {{certifications_list}}
</div>
</section>`,
    skillsSection: `<section class="skills section" id="skills">
    <h2 class="section-title">Skills</h2>
    <div class="skills_content bd-grid">
        <ul class="skills_data">
            {{skills_list}}
        </ul>
    </div>
</section>`,
    // websiteSection: ``,
    referenceSection: `<section class="references section" id="references">
    <h2 class="section-title">References</h2>
    <div class="references_container bd-grid">
        {{references_list}}
    </div>
</section>`,
    profilePicSection: `<img src="{{profile_picture}}" alt="" class="home_img center">`,
    socialsSection: `<section class="social section">
    <h2 class="section-title">SOCIAL</h2>
    <div class="social_container bd-grid">
        {{socials_list}}
    </div>
</section>`,
    addressSection: `<span class="home_information">
      <i class="bx bx-map"> &nbsp; </i> {{address}}
  </span>`,
    phoneNumberSection: `<span class="home_information">
      <i class="bx bx-phone"> &nbsp; </i> {{phone_number}}
  </span>`,
    // description: ``,
    // thumbnail: ``,
    createdAt: new Date(),
    updatedAt: new Date()
  }

  module.exports = template2;