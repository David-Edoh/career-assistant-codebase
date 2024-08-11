const template3 =
{
    bodyHTML: `<!doctype html>
    <html>
    
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, minimal-ui">
        <title>Thomas Davis</title>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paper-css/0.4.1/paper.min.css">
    
        <style id="INLINE_PEN_STYLESHEET_ID">
            /* Utils */
            /*----- Colors -----*/
            /*----- Fonts -----*/
            /*----- Dimensions and sizes -----*/
            /* Base */
            @font-face {
                font-family: 'Josefin Sans';
                font-style: normal;
                font-weight: 300;
                src: local('Josefin Sans Light'), local('JosefinSans-Light'), url(https://fonts.gstatic.com/s/josefinsans/v14/Qw3FZQNVED7rKGKxtqIqX5Ecpl5te10k.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Josefin Sans';
                font-style: normal;
                font-weight: 700;
                src: local('Josefin Sans Bold'), local('JosefinSans-Bold'), url(https://fonts.gstatic.com/s/josefinsans/v14/Qw3FZQNVED7rKGKxtqIqX5Ectllte10k.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Lato';
                font-style: italic;
                font-weight: 300;
                src: local('Lato Light Italic'), local('Lato-LightItalic'), url(https://fonts.gstatic.com/s/lato/v16/S6u_w4BMUTPHjxsI9w2_Gwfo.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Lato';
                font-style: italic;
                font-weight: 400;
                src: local('Lato Italic'), local('Lato-Italic'), url(https://fonts.gstatic.com/s/lato/v16/S6u8w4BMUTPHjxsAXC-v.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Lato';
                font-style: italic;
                font-weight: 700;
                src: local('Lato Bold Italic'), local('Lato-BoldItalic'), url(https://fonts.gstatic.com/s/lato/v16/S6u_w4BMUTPHjxsI5wq_Gwfo.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Lato';
                font-style: normal;
                font-weight: 300;
                src: local('Lato Light'), local('Lato-Light'), url(https://fonts.gstatic.com/s/lato/v16/S6u9w4BMUTPHh7USSwiPHA.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Lato';
                font-style: normal;
                font-weight: 400;
                src: local('Lato Regular'), local('Lato-Regular'), url(https://fonts.gstatic.com/s/lato/v16/S6uyw4BMUTPHjx4wWw.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Lato';
                font-style: normal;
                font-weight: 700;
                src: local('Lato Bold'), local('Lato-Bold'), url(https://fonts.gstatic.com/s/lato/v16/S6u9w4BMUTPHh6UVSwiPHA.ttf) format('truetype');
            }
    
            html {
                background: white;
            }
            ul, ol {
                list-style-position: inside !important;
                padding-left: 0 !important;
              }
            body {
                font-family: "Lato", Helvetica, Arial, sans-serif;
                font-weight: 400;
                background: white;
                margin: 50px 0 100px;
                letter-spacing: .3px;
                color: #39424B;
            }
    
            h1,
            h2,
            h3,
            h4,
            h5,
            h6 {
                text-transform: none;
                margin: 0;
            }
    
            h1 {
                font-family: "Josefin Sans", Helvetica, Arial, sans-serif;
                font-weight: 700;
                font-size: 40px;
                letter-spacing: 1px;
            }
    
            h2 {
                font-family: "Josefin Sans", Helvetica, Arial, sans-serif;
                font-weight: 300;
                font-size: 16px;
                letter-spacing: .5px;
            }
    
            h3 {
                font-family: "Lato", Helvetica, Arial, sans-serif;
                font-weight: 300;
                font-size: 14px;
                letter-spacing: .4px;
            }
    
            h3.bold {
                font-weight: 700;
            }
    
            h4 {
                font-family: "Lato", Helvetica, Arial, sans-serif;
                font-weight: 300;
                font-size: 12px;
            }
    
            h4.bold {
                font-weight: 700;
            }
    
            h5 {
                font-family: "Lato", Helvetica, Arial, sans-serif;
                font-weight: 300;
                font-size: 11px;
            }
    
            h5.italic {
                font-style: italic;
            }
    
            h6 {
                font-family: "Lato", Helvetica, Arial, sans-serif;
                font-weight: 400;
                font-size: 10px;
            }
    
            a {
                color: inherit;
                text-decoration: inherit;
            }
    
            a:hover {
                color: #2895F1;
            }
    
            a .fa-external-link {
                font-size: 10px;
                vertical-align: text-top;
            }
    
            p,
            li {
                font-size: 11px;
            }
    
            blockquote {
                font-size: 11px;
                font-family: "Lato", Helvetica, Arial, sans-serif;
                font-weight: 400;
                font-style: italic;
                margin: 10px 25px;
            }
    
            em {
                color: #999;
            }
    
            ul {
                margin: 10px 0 0;
                -webkit-padding-start: 25px;
            }
    
            ul li {
                padding-left: 10px;
            }
    
            ul.minimal {
                list-style: none;
                padding: 0;
            }
    
            ul.minimal li {
                margin-bottom: 3px;
                padding-left: 0;
            }
    
            ul.two-column {
                -webkit-column-count: 2;
                -webkit-column-gap: 28px;
                column-count: 2;
                column-gap: 28px;
            }
    
            ul.two-column li {
                padding-left: 0;
            }
    
            @page {
                size: A4;
            }

            .sheet {
                height: unset !important;
                padding-bottom: 45px;
            }
            
            .item { 
                page-break-inside:avoid;
                page-break-after:auto;
                /* padding-top: 20px; */
            }
    
            .container {
                padding-top: 20px;
            }
    
            .keyline {
                width: 45px;
                margin: 8px 0 10px;
                border-top: 1px solid #56817A;
            }
    
            .pull-left {
                float: left;
            }
    
            .pull-right {
                float: right;
            }
    
            .clearfix:after {
                content: "";
                display: table;
                clear: both;
            }
    
            .profile-pic {
                margin-top: -5px;
                margin-right: 18px;
            }
    
            .profile-pic img {
                height: 52px;
                width: 52px;
                border-radius: 50%;
                border: 2px solid #56817A;
            }
    
            .summary {
                margin: 5px 0 5px;
            }
    
            .sublink {
                font-size: 70%;
                font-weight: 200;
                color: dimgray;
            }
    
            .capitalize {
                text-transform: capitalize;
            }
    
            /* Layouts */
            .page {
                background: white;
                width: 612px;
                min-height: 792px;
                display: block;
                margin: 0 auto;
                border-top: 10px solid #56817A;
                padding: 36px 22px 30px 34px;
                box-shadow: 0 1px 10px rgba(0, 0, 0, 0.5);
            }
    
            .page:after {
                content: "";
                display: table;
                clear: both;
            }
    
            .left-column {
                float: left;
                width: 160px;
                margin-right: 20px;
                word-wrap: break-word;
            }
    
            .right-column {
                width: auto;
                overflow: hidden;
            }
    
            .item {
                margin-bottom: 15px;
            }
    
            .item:last-child {
                margin-bottom: 0;
            }
    
            @media print {
                body {
                    margin: 0;
                }
    
                .page {
                    width: 100%;
                    height: 100%;
                    margin: 0;
                    padding: 36px 0 30px;
                    box-shadow: none;
                }
    
                .page .resume-header,
                .page .resume-content {
                    padding: 0 22px 0 34px;
                }
    
                /* .container {
                    page-break-inside: avoid;
                } */
    
                .work-container .item {
                    page-break-inside: avoid;
                }
    
                .fa-external-link {
                    display: none;
                }
            }
    
            /* Components */
            .info-tag-container {
                margin-bottom: 5px;
            }
    
            .info-tag-container .fa {
                font-size: 14px;
                width: 12px;
                margin-right: 5px;
                text-align: center;
                vertical-align: middle;
            }
    
            .info-tag-container .fa.fa-map-marker {
                font-size: 16px;
            }
    
            .info-tag-container .fa.fa-mobile {
                font-size: 18px;
            }
    
            .info-tag-container .fa.fa-envelope-o {
                font-size: 12px;
            }
    
            .info-tag-container .fa.fa-desktop {
                font-size: 11px;
            }
    
            .info-tag-container .fa.fa-external-link {
                width: auto;
                font-size: inherit;
                vertical-align: text-top;
            }
    
            .info-tag-container .info-text {
                font-size: 12px;
                text-transform: none;
                display: inline-block;
                vertical-align: middle;
                width: 139px;
            }
    
            .references-container .fa {
                font-size: 14px;
            }
    
            .education-container .location {
                padding-bottom: 6px;
                font-weight: 400;
            }
    
            .education-container .specialization {
                text-transform: none;
                font-style: italic;
            }
    
            .flex-container {
                display: flex;
                flex-direction: row;
                flex-wrap: wrap;
            }
    
            .main-skill {
                font-size: 80%;
            }
    
            .skill {
                margin: .15em;
                padding: .15em;
                background: ghostwhite;
                border-radius: 5px;
            }
    
            .sheet {
                height: max-content !important;
                min-height: 296mm;
            }
        </style>
    </head>
    
    <body class="A4">
        <main id="resume" class="page sheet">
            <header class="resume-header clearfix">
                <div class="profile-header pull-left">
                    <h1>{{first_name}} {{last_name}}</h1>
                    <h2>{{occupation}}</h2>
                </div>
                <div class="profile-pic pull-right">
                </div>
            </header>
            <div class="resume-content">
                <aside class="left-column">
                    <div class="container about-container">
                        <div class="title">
                            <h3>About</h3>
                            <div class="keyline"></div>
                        </div>
                        {{address_section}}
    
    
                        <div class="info-tag-container">
                            <i class="fa fa-envelope-o"></i>
    
                            <h6 class="info-text">
                                <a href="{{email}}" target="_blank">
                                    {{email}}
                                </a>
                            </h6>
                        </div>
                        {{website_section}}
                        {{socials_list}}
                        </section>
                        {{skills_section}}
                        
                </aside>
                <div class="right-column">
                    <div class="container summary-container">
                        <div class="title">
                            <h3>Summary</h3>
                            <div class="keyline"></div>
                        </div>
                        <p class="summary">
                            {{about_me}}
                        </p>
                    </div>
                    {{experience_section}}
                    {{education_section}}
                    {{reference_section}}
                </div>
            </div>
        </main>
    </body>
    
    </html>`,
    sampleHTML: `<!doctype html>
    <html>
    
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, minimal-ui">
        <title>Thomas Davis</title>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paper-css/0.4.1/paper.min.css">
    
        <style id="INLINE_PEN_STYLESHEET_ID">
            /* Utils */
            /*----- Colors -----*/
            /*----- Fonts -----*/
            /*----- Dimensions and sizes -----*/
            /* Base */
            @font-face {
                font-family: 'Josefin Sans';
                font-style: normal;
                font-weight: 300;
                src: local('Josefin Sans Light'), local('JosefinSans-Light'), url(https://fonts.gstatic.com/s/josefinsans/v14/Qw3FZQNVED7rKGKxtqIqX5Ecpl5te10k.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Josefin Sans';
                font-style: normal;
                font-weight: 700;
                src: local('Josefin Sans Bold'), local('JosefinSans-Bold'), url(https://fonts.gstatic.com/s/josefinsans/v14/Qw3FZQNVED7rKGKxtqIqX5Ectllte10k.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Lato';
                font-style: italic;
                font-weight: 300;
                src: local('Lato Light Italic'), local('Lato-LightItalic'), url(https://fonts.gstatic.com/s/lato/v16/S6u_w4BMUTPHjxsI9w2_Gwfo.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Lato';
                font-style: italic;
                font-weight: 400;
                src: local('Lato Italic'), local('Lato-Italic'), url(https://fonts.gstatic.com/s/lato/v16/S6u8w4BMUTPHjxsAXC-v.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Lato';
                font-style: italic;
                font-weight: 700;
                src: local('Lato Bold Italic'), local('Lato-BoldItalic'), url(https://fonts.gstatic.com/s/lato/v16/S6u_w4BMUTPHjxsI5wq_Gwfo.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Lato';
                font-style: normal;
                font-weight: 300;
                src: local('Lato Light'), local('Lato-Light'), url(https://fonts.gstatic.com/s/lato/v16/S6u9w4BMUTPHh7USSwiPHA.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Lato';
                font-style: normal;
                font-weight: 400;
                src: local('Lato Regular'), local('Lato-Regular'), url(https://fonts.gstatic.com/s/lato/v16/S6uyw4BMUTPHjx4wWw.ttf) format('truetype');
            }
    
            @font-face {
                font-family: 'Lato';
                font-style: normal;
                font-weight: 700;
                src: local('Lato Bold'), local('Lato-Bold'), url(https://fonts.gstatic.com/s/lato/v16/S6u9w4BMUTPHh6UVSwiPHA.ttf) format('truetype');
            }
    
            html {
                background: white;
            }
    
            body {
                font-family: "Lato", Helvetica, Arial, sans-serif;
                font-weight: 400;
                background: white;
                margin: 50px 0 100px;
                letter-spacing: .3px;
                color: #39424B;
            }
    
            h1,
            h2,
            h3,
            h4,
            h5,
            h6 {
                text-transform: none;
                margin: 0;
            }
    
            h1 {
                font-family: "Josefin Sans", Helvetica, Arial, sans-serif;
                font-weight: 700;
                font-size: 40px;
                letter-spacing: 1px;
            }
    
            h2 {
                font-family: "Josefin Sans", Helvetica, Arial, sans-serif;
                font-weight: 300;
                font-size: 16px;
                letter-spacing: .5px;
            }
    
            h3 {
                font-family: "Lato", Helvetica, Arial, sans-serif;
                font-weight: 300;
                font-size: 14px;
                letter-spacing: .4px;
            }
    
            h3.bold {
                font-weight: 700;
            }
    
            h4 {
                font-family: "Lato", Helvetica, Arial, sans-serif;
                font-weight: 300;
                font-size: 12px;
            }
    
            h4.bold {
                font-weight: 700;
            }
    
            h5 {
                font-family: "Lato", Helvetica, Arial, sans-serif;
                font-weight: 300;
                font-size: 11px;
            }
    
            h5.italic {
                font-style: italic;
            }
    
            h6 {
                font-family: "Lato", Helvetica, Arial, sans-serif;
                font-weight: 400;
                font-size: 10px;
            }
    
            a {
                color: inherit;
                text-decoration: inherit;
            }
    
            a:hover {
                color: #2895F1;
            }
    
            a .fa-external-link {
                font-size: 10px;
                vertical-align: text-top;
            }
    
            p,
            li {
                font-size: 11px;
            }
    
            blockquote {
                font-size: 11px;
                font-family: "Lato", Helvetica, Arial, sans-serif;
                font-weight: 400;
                font-style: italic;
                margin: 10px 25px;
            }
    
            em {
                color: #999;
            }
    
            ul {
                margin: 10px 0 0;
                -webkit-padding-start: 25px;
            }
    
            ul li {
                padding-left: 10px;
            }
    
            ul.minimal {
                list-style: none;
                padding: 0;
            }
    
            ul.minimal li {
                margin-bottom: 3px;
                padding-left: 0;
            }
    
            ul.two-column {
                -webkit-column-count: 2;
                -webkit-column-gap: 28px;
                column-count: 2;
                column-gap: 28px;
            }
    
            ul.two-column li {
                padding-left: 0;
            }
    
            @page {
                size: A4;
            }
    
            .container {
                padding-top: 20px;
            }
    
            .keyline {
                width: 45px;
                margin: 8px 0 10px;
                border-top: 1px solid #56817A;
            }
    
            .pull-left {
                float: left;
            }
    
            .pull-right {
                float: right;
            }
    
            .clearfix:after {
                content: "";
                display: table;
                clear: both;
            }
    
            .profile-pic {
                margin-top: -5px;
                margin-right: 18px;
            }
    
            .profile-pic img {
                height: 52px;
                width: 52px;
                border-radius: 50%;
                border: 2px solid #56817A;
            }
    
            .summary {
                margin: 5px 0 5px;
            }
    
            .sublink {
                font-size: 70%;
                font-weight: 200;
                color: dimgray;
            }
    
            .capitalize {
                text-transform: capitalize;
            }
    
            /* Layouts */
            .page {
                background: white;
                width: 612px;
                min-height: 792px;
                display: block;
                margin: 0 auto;
                border-top: 10px solid #56817A;
                padding: 36px 22px 30px 34px;
                box-shadow: 0 1px 10px rgba(0, 0, 0, 0.5);
            }
    
            .page:after {
                content: "";
                display: table;
                clear: both;
            }
    
            .left-column {
                float: left;
                width: 160px;
                margin-right: 20px;
                word-wrap: break-word;
            }
    
            .right-column {
                width: auto;
                overflow: hidden;
            }
    
            .item {
                margin-bottom: 15px;
            }
    
            .item:last-child {
                margin-bottom: 0;
            }
    
            @media print {
                body {
                    margin: 0;
                }
    
                .page {
                    width: 100%;
                    height: 100%;
                    margin: 0;
                    padding: 36px 0 30px;
                    box-shadow: none;
                }
    
                .page .resume-header,
                .page .resume-content {
                    padding: 0 22px 0 34px;
                }
    
                .container {
                    page-break-inside: avoid;
                }
    
                .work-container .item {
                    page-break-inside: avoid;
                }
    
                .fa-external-link {
                    display: none;
                }
            }
    
            /* Components */
            .info-tag-container {
                margin-bottom: 5px;
            }
    
            .info-tag-container .fa {
                font-size: 14px;
                width: 12px;
                margin-right: 5px;
                text-align: center;
                vertical-align: middle;
            }
    
            .info-tag-container .fa.fa-map-marker {
                font-size: 16px;
            }
    
            .info-tag-container .fa.fa-mobile {
                font-size: 18px;
            }
    
            .info-tag-container .fa.fa-envelope-o {
                font-size: 12px;
            }
    
            .info-tag-container .fa.fa-desktop {
                font-size: 11px;
            }
    
            .info-tag-container .fa.fa-external-link {
                width: auto;
                font-size: inherit;
                vertical-align: text-top;
            }
    
            .info-tag-container .info-text {
                font-size: 12px;
                text-transform: none;
                display: inline-block;
                vertical-align: middle;
                width: 139px;
            }
    
            .references-container .fa {
                font-size: 14px;
            }
    
            .education-container .location {
                padding-bottom: 6px;
                font-weight: 400;
            }
    
            .education-container .specialization {
                text-transform: none;
                font-style: italic;
            }
    
            .flex-container {
                display: flex;
                flex-direction: row;
                flex-wrap: wrap;
            }
    
            .main-skill {
                font-size: 80%;
            }
    
            .skill {
                margin: .15em;
                padding: .15em;
                background: ghostwhite;
                border-radius: 5px;
            }
        </style>
    </head>
    
    <body class="A4">
        <main id="resume" class="page sheet">
            <header class="resume-header clearfix">
                <div class="profile-header pull-left">
                    <h1>Thomas Davis</h1>
                    <h2>Web Developer</h2>
                </div>
                <div class="profile-pic pull-right">
                </div>
            </header>
            <div class="resume-content">
                <aside class="left-column">
                    <div class="container about-container">
                        <div class="title">
                            <h3>About</h3>
                            <div class="keyline"></div>
                        </div>
                        <div class="info-tag-container">
                            <i class="fa fa-map-marker"></i>
    
                            <h6 class="info-text">Melbourne</h6>
                        </div>
    
    
                        <div class="info-tag-container">
                            <i class="fa fa-envelope-o"></i>
    
                            <h6 class="info-text">
                                <a href="mailto:thomasalwyndavis@gmail.com" target="_blank">
                                    thomasalwyndavis@gmail.com
                                </a>
                            </h6>
                        </div>
    
    
                        <div class="info-tag-container">
                            <i class="fa fa-globe"></i>
    
                            <h6 class="info-text">
                                <a href="https://lordajax.com" target="_blank">
                                    lordajax.com
                                </a>
                            </h6>
                        </div>
    
                        <div class="info-tag-container">
                            <i class="fa fa-twitter"></i>
    
                            <h6 class="info-text">
                                <a href="https://twitter.com/ajaxdavis" target="_blank">
                                    ajaxdavis
                                </a>
                            </h6>
                        </div>
                        <div class="info-tag-container">
                            <i class="fa fa-github"></i>
    
                            <h6 class="info-text">
                                <a href="https://github.com/thomasdavis" target="_blank">
                                    thomasdavis
                                </a>
                            </h6>
                        </div>
                        </section>
                        <div class="skills-container">
                            <section class="container">
                                <div class="title">
                                    <h3>Frontend</h3>
                                    <div class="keyline"></div>
                                </div>
                                <h4 class="bold capitalize">Senior</h4>
                                <div class="minimal flex-container">
                                    <h6 class="main-skill skill">HTML / JSX</h6>
                                    <h6 class="main-skill skill">SCSS / CSS / BEM / Styled Components</h6>
                                    <h6 class="main-skill skill">Javascript / Typescript</h6>
                                    <h6 class="main-skill skill">React / Next</h6>
                                    <h6 class="main-skill skill">Redux / Apollo</h6>
                                </div>
                            </section>
                            <section class="container">
                                <div class="title">
                                    <h3>Backend</h3>
                                    <div class="keyline"></div>
                                </div>
                                <h4 class="bold capitalize">Senior</h4>
                                <div class="minimal flex-container">
                                    <h6 class="main-skill skill">Node</h6>
                                    <h6 class="main-skill skill">Ruby</h6>
                                    <h6 class="main-skill skill">Python</h6>
                                    <h6 class="main-skill skill">Postgres</h6>
                                    <h6 class="main-skill skill">Redis</h6>
                                    <h6 class="main-skill skill">Serverless</h6>
                                </div>
                            </section>
                            <section class="container">
                                <div class="title">
                                    <h3>Devops</h3>
                                    <div class="keyline"></div>
                                </div>
                                <h4 class="bold capitalize">Senior</h4>
                                <div class="minimal flex-container">
                                    <h6 class="main-skill skill">AWS</h6>
                                    <h6 class="main-skill skill">G Cloud</h6>
                                    <h6 class="main-skill skill">Heroku</h6>
                                    <h6 class="main-skill skill">Caching</h6>
                                </div>
                            </section>
                        </div>
                        <div class="container interests-container">
                            <div class="title">
                                <h3>Interests</h3>
                                <div class="keyline"></div>
                            </div>
                            <section class="item">
                                <h4 class="bold">Gardening</h4>
                            </section>
                            <section class="item">
                                <h4 class="bold">Music / Jamming</h4>
                            </section>
                            <section class="item">
                                <h4 class="bold">Reading / Writing</h4>
                            </section>
                            <section class="item">
                                <h4 class="bold">Open Source</h4>
                            </section>
                        </div>
                </aside>
                <div class="right-column">
                    <div class="container summary-container">
                        <div class="title">
                            <h3>Summary</h3>
                            <div class="keyline"></div>
                        </div>
                        <p class="summary">
                            I&#x27;m a full stack web developer who can build apps from the ground up. I&#x27;ve worked
                            mostly at startups so I am used to wearing many hats. I am a very product focussed developer who
                            prioritizes user feedback first and foremost. I&#x27;m generally very flexible when
                            investigating new roles.
                        </p>
                    </div>
                    <div class="container work-container">
                        <div class="title">
                            <h3>Experience</h3>
                            <div class="keyline"></div>
                        </div>
                        <section class="item">
                            <div class="section-header clearfix">
                                <h5 class="italic pull-right">
                                    <span class="startDate">June 2013</span>
                                    <span class="endDate"> - January 2016</span>
                                </h5>
                            </div>
    
                            <h4>Developer</h4>
    
    
                            <p class="summary">Worked on many politically charged campaigns against mass surveillance. Not
                                only technically challenging work but also a lot of networking and getting my hands dirty
                                with politics. Our biggest project was &quot;TheDayWeFightBack&quot;..</p>
    
                            <ul>
                                <li>Generated 37,000,000 banner views</li>
                                <li>100, 000 phone calls to congress</li>
                                <li>500, 000 emails</li>
                                <li>250, 000 signatures</li>
                            </ul>
                        </section>
                        <section class="item">
                            <div class="section-header clearfix">
                                <h5 class="italic pull-right">
                                    <span class="startDate">January 2013</span>
                                    <span class="endDate"> - Present</span>
                                </h5>
                            </div>
    
                            <h4>Co-Founder</h4>
    
    
                            <p class="summary">An international directory of civilian drone / UAV operators for hire.
                                Services include aerial photography, aerial video, mapping, surveying, precision
                                agriculture, real estate photography, remote inspections and infrared imaging. Our plan is
                                to be the place to go when looking for UAV/Drone services. The website is built in
                                Backbone.js and API is built with Node.js and Postgres. </p>
    
                            <ul>
                                <li>The site and blog combined have managed to receive over 200,000 visitors in 2014.</li>
                            </ul>
                        </section>
                        <section class="item">
                            <div class="section-header clearfix">
                                <h5 class="italic pull-right">
                                    <span class="startDate">January 2011</span>
                                    <span class="endDate"> - January 2014</span>
                                </h5>
                            </div>
    
                            <h4>Founder</h4>
    
    
                            <p class="summary">I write tutorials and blog post regarding the popular Javascript framework
                                Backbone.js. The tutorials cover a range of topics regarding front end development aimed at
                                beginners, experts and anyone in between.</p>
    
                            <ul>
                                <li>Over two million unique visitors a year</li>
                                <li>25,000+ ebook downloads</li>
                                <li>300,000+ Youtube views</li>
                            </ul>
                        </section>
                        <section class="item">
                            <div class="section-header clearfix">
                                <h5 class="italic pull-right">
                                    <span class="startDate">January 2011</span>
                                    <span class="endDate"> - June 2012</span>
                                </h5>
                            </div>
    
                            <h4>Front-end Developer</h4>
    
    
                            <p class="summary">Ephox is a worldwide company who is heavily involved with the development of
                                TinyMce and enterprise editors. My primary role included building front-end widgets and
                                applications. Worked on a major product using Backbone.js as a base. Heavily involved in
                                UI/UX design and wire-framing. Also spend a lot of time designing API specifications and
                                documentation.</p>
    
                        </section>
                    </div>
                    <div class="container education-container">
                        <div class="title">
                            <h3>Education</h3>
                            <div class="keyline"></div>
                        </div>
                        <section class="item">
                            <div class="section-header clearfix">
                                <h3 class="bold pull-left">
                                    The University of Queensland
                                </h3>
                                <h5 class="italic pull-right">
                                    <span class="startDate">February 2008</span>
                                    <span class="endDate"> - December 2009</span>
                                </h5>
                            </div>
                            <h4>Bachelors Software Engineering (incomplete)</h4>
                        </section>
                    </div>
    
                    <div class="container references-container">
                        <div class="title">
                            <h3>References</h3>
                            <div class="keyline"></div>
                        </div>
                        <section class="item clearfix">
                            <i class="fa fa-quote-left pull-left" aria-hidden="true"></i>
                            <blockquote>
                                Thomas was hired as a lead developer and, upon the leaving of our co-founder took over as
                                CTO of Earbits. Thomas is, hands down, one of those A Players you hear of companies dying to
                                hire. He is incredibly smart, not just at code but about everything from classical music to
                                Chinese language and culture. Thomas is great to work with and, as a well established
                                contributor to open source projects and several successful ventures, commands the respect of
                                engineers at all levels. I would suggest doing anything you can to have him on your team.
                            </blockquote>
    
                            <h5 class="pull-right"> — Joey Flores, Co-founder and CEO of Earbits, Inc.</h5>
                        </section>
                    </div>
                </div>
            </div>
        </main>
    </body>
    
    </html>`,
    experienceHTML: `<section class="item">
    <div class="section-header clearfix">
        <h5 class="italic pull-right">
            <span class="startDate">{{experience_start_month}} {{experience_start_year}}</span>
            <span class="endDate"> - {{experience_end_month}} {{experience_end_year}}</span>
        </h5>
    </div>

    <h4>{{position}} @ {{company_name}}</h4>


    <p class="summary">{{description}}</p>
</section>`,
    educationHTML: `<section class="item">
    <div class="section-header clearfix">
        <h3 class="bold pull-left">
            {{school_name}}
        </h3>
        <h5 class="italic pull-right">
            <span class="startDate">{{education_start_month}} {{education_start_year}}</span>
            <span class="endDate"> - {{education_end_month}} {{education_end_year}}</span>
        </h5>
    </div>

    <h4>{{education_level}} {{discipline}}</h4>

</section>`,
    skillHTML: `<h6 class="main-skill skill">{{skill}}</h6>`,
    socialsHTML: `<div class="info-tag-container">
    <i class="fa fa-link"></i>

    <h6 class="info-text">
        <a href="{{social_link}}" target="_blank">
            {{social_link}}
        </a>
    </h6>
</div>`,
    referencesHTML: `<section class="item clearfix">
<!-- <i class="fa fa-quote-left pull-left" aria-hidden="true"></i> -->

<h2>{{reference_name}}, {{reference_position}} at {{reference_company}}</h2>
<h4>{{reference_email}}</h4>
<h4>{{reference_phonenumber}}</h4>
</section>`,

    experienceSection: `<div class="container work-container">
    <div class="title">
        <h3>Experience</h3>
        <div class="keyline"></div>
    </div>
    {{experience_list}}
</div>`,
    educationSection: `<div class="container education-container">
    <div class="title">
        <h3>Education</h3>
        <div class="keyline"></div>
    </div>
    {{education_list}}
</div>`,
referenceSection: `<div class="container references-container">
<div class="title">
    <h3>References</h3>
    <div class="keyline"></div>
</div>
{{references_list}}
</div>`,
skillsSection: `<div class="skills-container">
<section class="container">
    <div class="minimal flex-container">
        {{skills_list}}
    </div>
</section>
</div>`,
websiteSection: `<div class="info-tag-container">
<i class="fa fa-globe"></i>

<h6 class="info-text">
    <a href="{{website}}" target="_blank">
        {{website}}
    </a>
</h6>
</div>`,
addressSection: `<div class="info-tag-container">
<i class="fa fa-map-marker"></i>

<h6 class="info-text">{{address}}</h6>
</div>`,
    // projectSection: ``,
    // profilePicSection: ``,
    // socialsSection: ``,
    
    // projectsHTML: ``,
    // description: ``,
    // thumbnail: ``,
    createdAt: new Date(),
    updatedAt: new Date(),
}


module.exports = template3;