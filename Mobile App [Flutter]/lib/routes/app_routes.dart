import 'package:flutter/material.dart';
import 'package:fotisia/presentation/notifications_general_page/notifications_general_page.dart';
import 'package:fotisia/presentation/notifications_my_proposals_page/notifications_my_proposals_page.dart';
import 'package:fotisia/presentation/resume_edit_screen/resume_edit_screen.dart';
import 'package:fotisia/presentation/splash_screen/splash_screen.dart';
import 'package:fotisia/presentation/onboarding_one_screen/onboarding_one_screen.dart';
import 'package:fotisia/presentation/onboarding_two_screen/onboarding_two_screen.dart';
import 'package:fotisia/presentation/onboarding_three_screen/onboarding_three_screen.dart';
import 'package:fotisia/presentation/sign_up_create_acount_screen/sign_up_create_acount_screen.dart';
import 'package:fotisia/presentation/sign_up_complete_account_screen/sign_up_complete_account_screen.dart';
import 'package:fotisia/presentation/job_type_screen/job_type_screen.dart';
import 'package:fotisia/presentation/speciallization_screen/speciallization_screen.dart';
import 'package:fotisia/presentation/select_a_country_screen/select_a_country_screen.dart';
import 'package:fotisia/presentation/login_screen/login_screen.dart';
import 'package:fotisia/presentation/enter_otp_screen/enter_otp_screen.dart';
import 'package:fotisia/presentation/home_container_screen/home_container_screen.dart';
import 'package:fotisia/presentation/search_screen/search_screen.dart';
import 'package:fotisia/presentation/job_details_tab_container_screen/job_details_tab_container_screen.dart';
import 'package:fotisia/presentation/message_action_screen/message_action_screen.dart';
import 'package:fotisia/presentation/chat_screen/chat_screen.dart';
import 'package:fotisia/presentation/apply_job_screen/apply_job_screen.dart';
import 'package:fotisia/presentation/notifications_my_proposals_tab_container_screen/notifications_my_proposals_tab_container_screen.dart';
import 'package:fotisia/presentation/settings_screen/settings_screen.dart';
import 'package:fotisia/presentation/personal_info_screen/personal_info_screen.dart';
import 'package:fotisia/presentation/experience_setting_screen/experience_setting_screen.dart';
import 'package:fotisia/presentation/new_position_screen/new_position_screen.dart';
import 'package:fotisia/presentation/add_new_education_screen/add_new_education_screen.dart';
import 'package:fotisia/presentation/privacy_screen/privacy_screen.dart';
import 'package:fotisia/presentation/language_screen/language_screen.dart';
import 'package:fotisia/presentation/notifications_screen/notifications_screen.dart';
import 'package:fotisia/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:fotisia/presentation/feeds_page/feeds_page.dart';
import 'package:fotisia/presentation/inbox_chat_screen/chat_screen.dart';
import 'package:fotisia/presentation/message_page/message_page.dart';
import 'package:fotisia/presentation/employment_status_screen/employment_status_screen.dart';
import 'package:fotisia/presentation/education_level_screen/education_level_screen.dart';
import 'package:fotisia/presentation/key_strength_screen/key_strength_screen.dart';
import 'package:fotisia/presentation/career_goals_screen/career_goals_screen.dart';
import 'package:fotisia/presentation/personal_brand_screen/personal_brand_screen.dart';
import 'package:fotisia/presentation/resume_maker_screen/resume_maker_screen.dart';
import 'package:fotisia/presentation/new_project_screen/new_project_screen.dart';
import 'package:fotisia/presentation/new_reference_screen/new_reference_screen.dart';
import 'package:fotisia/presentation/new_social_link_screen/new_social_link_screen.dart';
import 'package:fotisia/presentation/user_profile_page/user_profile_page.dart';
import 'package:fotisia/presentation/single_post_page/single_post_page.dart';
import 'package:fotisia/presentation/streak_info_screen/streak_info_screen.dart';
import 'package:fotisia/presentation/career_roadmap_screen/career_roadmap_screen.dart';
import 'package:fotisia/presentation/job_ad_screen/job_ad_screen.dart';
import 'package:fotisia/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:fotisia/presentation/collect_user_basic_info_screen/collect_user_basic_info_screen.dart';
import 'package:fotisia/presentation/new_resume_certification_screen/new_resume_certification_screen.dart';
import 'package:fotisia/presentation/links_preview_screen/links_preview_screen.dart';


class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String onboardingOneScreen = '/onboarding_one_screen';

  static const String onboardingTwoScreen = '/onboarding_two_screen';

  static const String onboardingThreeScreen = '/onboarding_three_screen';

  static const String signUpCreateAcountScreen =
      '/sign_up_create_acount_screen';

  static const String signUpCompleteAccountScreen =
      '/sign_up_complete_account_screen';

  static const String jobTypeScreen = '/job_type_screen';

  static const String speciallizationScreen = '/speciallization_screen';

  static const String selectACountryScreen = '/select_a_country_screen';

  static const String loginScreen = '/login_screen';

  static const String enterOtpScreen = '/enter_otp_screen';

  static const String homePage = '/home_page';

  static const String homeContainerScreen = '/home_container_screen';

  static const String searchScreen = '/search_screen';

  static const String jobDetailsPage = '/job_details_page';

  static const String jobDetailsTabContainerScreen =
      '/job_details_tab_container_screen';

  static const String messagePage = '/message_page';

  static const String messageActionScreen = '/message_action_screen';

  static const String chatScreen = '/chat_screen';

  static const String inboxChatScreen = '/inbox_chat_screen';

  static const String savedPage = '/saved_page';

  static const String savedDetailJobPage = '/saved_detail_job_page';

  static const String applyJobScreen = '/apply_job_screen';

  static const String appliedJobPage = '/applied_job_page';

  static const String notificationsGeneralPage = '/notifications_general_page';

  static const String notificationsMyProposalsPage =
      '/notifications_my_proposals_page';

  static const String notificationsMyProposalsTabContainerScreen =
      '/notifications_my_proposals_tab_container_screen';

  static const String profilePage = '/profile_page';

  static const String userProfilePage = '/user_profile_page';

  static const String feedsPage = '/feeds_page';

  static const String settingsScreen = '/settings_screen';

  static const String personalInfoScreen = '/personal_info_screen';

  static const String experienceSettingScreen = '/experience_setting_screen';

  static const String newPositionScreen = '/new_position_screen';

  static const String addNewEducationScreen = '/add_new_education_screen';

  static const String addNewProjectScreen = '/add_new_project_screen';

  static const String addNewCertificationScreen = '/add_new_certification_training_course_screen';

  static const String addNewReferenceScreen = '/add_new_reference_screen';

  static const String addNewSocialLinkScreen = '/add_new_social_link_screen';

  static const String employmentStatusScreen = '/employment_status_screen';

  static const String educationLevelScreen = '/education_level_screen';

  static const String keyStrengthScreen = '/key_strength_screen';

  static const String careerGoalsScreen = '/career_goal_screen';

  static const String singlePostScreen = '/single_post_screen';

  static const String privacyScreen = '/privacy_screen';

  static const String personalBranding = '/personal_branding';

  static const String resumeMaker = '/resume_maker';

  static const String editResumeDetails = '/edit_resume_details';

  static const String languageScreen = '/language_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String streakInfoScreen = '/streakInfoRoute';

  static const String careerRoadmap = '/career_road_map';

  static const String jobAdScreen = '/job_ad';

  static const String initialRoute = '/initialRoute';

  static const String forgotPasswordRoute = '/forgotPasswordRoute';

  static const String collectUserDetailsRoute = '/collectUserDetailsRoute';

  static const String linkPreviewScreen = '/linkPreviewScreen';


  static Map<String, WidgetBuilder> get routes => {
        splashScreen: SplashScreen.builder,
        feedsPage: FeedsPage.builder,
        singlePostScreen: SinglePostPage.builder,
        messagePage: MessagePage.builder,
        inboxChatScreen: InboxChatScreen.builder,
        onboardingOneScreen: OnboardingOneScreen.builder,
        onboardingTwoScreen: OnboardingTwoScreen.builder,
        onboardingThreeScreen: OnboardingThreeScreen.builder,
        employmentStatusScreen: EmploymentStatusScreen.builder,
        educationLevelScreen: EducationLevelScreen.builder,
        keyStrengthScreen: KeyStrengthScreen.builder,
        careerGoalsScreen: CareerGoalsScreen.builder,
        signUpCreateAcountScreen: SignUpCreateAcountScreen.builder,
        signUpCompleteAccountScreen: SignUpCompleteAccountScreen.builder,
        jobTypeScreen: JobTypeScreen.builder,
        speciallizationScreen: SpeciallizationScreen.builder,
        selectACountryScreen: SelectACountryScreen.builder,
        loginScreen: LoginScreen.builder,
        enterOtpScreen: EnterOtpScreen.builder,
        homeContainerScreen: HomeContainerScreen.builder,
        searchScreen: SearchScreen.builder,
        jobDetailsTabContainerScreen: JobDetailsTabContainerScreen.builder,
        messageActionScreen: MessageActionScreen.builder,
        chatScreen: ChatScreen.builder,
        userProfilePage: UserProfilePage.builder,
        applyJobScreen: ApplyJobScreen.builder,
        notificationsMyProposalsTabContainerScreen: NotificationsMyProposalsTabContainerScreen.builder,
        settingsScreen: SettingsScreen.builder,
        personalInfoScreen: PersonalInfoScreen.builder,
        experienceSettingScreen: ExperienceSettingScreen.builder,
        newPositionScreen: NewPositionScreen.builder,
        addNewEducationScreen: AddNewEducationScreen.builder,
        addNewProjectScreen: NewProjectScreen.builder,
        addNewCertificationScreen: NewCertificationScreen.builder,
        addNewReferenceScreen: NewReferenceScreen.builder,
        addNewSocialLinkScreen: NewSocialLinktScreen.builder,
        privacyScreen: PrivacyScreen.builder,
        languageScreen: LanguageScreen.builder,
        personalBranding: PersonalBrandScreen.builder,
        resumeMaker: ResumeMakerScreen.builder,
        editResumeDetails: ResumeEditScreen.builder,
        notificationsScreen: NotificationsScreen.builder,
        notificationsGeneralPage: NotificationsGeneralPage.builder,
        notificationsMyProposalsPage: NotificationsMyProposalsPage.builder,
        appNavigationScreen: AppNavigationScreen.builder,
        streakInfoScreen: StreakInfoScreen.builder,
        careerRoadmap: CareerRoadmapScreen.builder,
        jobAdScreen: JobAdScreen.builder,
        initialRoute: SplashScreen.builder,
        forgotPasswordRoute: ForgotPasswordScreen.builder,
        collectUserDetailsRoute: CollectBasicUserInfoScreen.builder,
        linkPreviewScreen: LinksPreviewScreen.builder,
      };
}
