import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../data/models/loginAuth/post_login_auth_resp.dart';
import 'bloc/login_bloc.dart';
import 'models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/core/utils/validation_functions.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';
import 'package:fotisia/domain/googleauth/google_auth_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:signin_with_linkedin/signin_with_linkedin.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(LoginState(loginModelObj: LoginModel()))
          ..add(LoginInitialEvent()),
        child: LoginScreen());
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



// Modify the "scope" below as per your need
final _linkedInConfig = LinkedInConfig(
  clientId: '784sm0uxyxplx0',
  clientSecret: 'xzYo9Y3xDIlkwevg',
  redirectUrl: 'https://fotisia.com',
  scope: ['openid', 'profile', 'email'],
);

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserObject? user;
  bool logoutUser = false;
  AuthCodeObject? authorizationCode;
  bool userProfileGotten = false;
  bool hasheckedPermission = false;
  SpeechToText _speech = SpeechToText();

  void checkPermission() async {
    if(await Permission.speech.request().isGranted){
      // Fluttertoast.showToast(msg: "Audio permission granted");
    }
    if(await Permission.bluetoothConnect.request().isGranted){
      // Fluttertoast.showToast(msg: "Audio permission granted");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    // if(!hasheckedPermission){
    //   checkPermission();
    //   setState(() {
    //     hasheckedPermission = true;
    //   });
    // }

    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
    return Scaffold(
        backgroundColor: appTheme.whiteA70001,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SizedBox(
            height: mediaQueryData.size.height,
            child: Stack(
              // alignment: Alignment.bottomLeft,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Semantics(
                    label: "Image: smiling people",
                    child: CustomImageView(
                      height: mediaQueryData.size.height * 0.5,
                      imagePath: ImageConstant.loginBG,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Container(
                          width: double.maxFinite,
                          padding:
                          getPadding(left: 24, top: 13, right: 24, bottom: 13),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if(state.useEmailLogin == null || state.useEmailLogin == true) Semantics(
                                  label: "button: Back to login option page",
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<LoginBloc>().add(UseSocialLoginEvent());
                                    },
                                    child: SizedBox(
                                      height: 48,
                                      child: Row(
                                        children: [
                                          CustomImageView(
                                              svgPath: ImageConstant.imgGroup162799,
                                              height: getSize(60),
                                              width: getSize(24),
                                              alignment: Alignment.centerLeft,
                                              ),
                                          // Text("Use Social login", style: TextStyle(fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: getPadding(top: 11),
                                  child: Text("msg_hi_welcome_back".tr,
                                      style: theme.textTheme.headlineSmall),
                                ),
                                state.useEmailLogin == null || state.useEmailLogin == false ? Container(
                                  child: Column(
                                    children: [
                                      Semantics(
                                        label: "button: Login using your linkedin account",
                                        child: CustomOutlinedButton(
                                            height: getVerticalSize(70),
                                            text: "Continue with Linkedin",
                                            margin: getMargin(top: 31),
                                            leftIcon: Container(
                                                margin: getMargin(right: 12),
                                                child: CustomImageView(
                                                    height: 25,
                                                    width: 25,
                                                    svgPath: ImageConstant.imgLinkedIn)
                                            ),
                                            buttonStyle: CustomButtonStyles.outlinePrimary,
                                            buttonTextStyle: theme.textTheme.titleMedium!,
                                            onTap: () {
                                              SignInWithLinkedIn.signIn(
                                                context,
                                                config: _linkedInConfig,
                                                onGetAuthToken: (data) {
                                                  print('Auth token data: ${data.toJson()}');
                                                },

                                                onGetUserProfile: (accessToken, user) async {
                                                  if(!userProfileGotten){
                                                    print("caleld");
                                                    setState(() {
                                                      userProfileGotten = true;
                                                    });
                                                    final fcmToken = await FirebaseMessaging.instance.getToken();
                                                    User newUser = User(
                                                        firstName: user.givenName,
                                                        lastName: user.familyName,
                                                        email: user.email,
                                                        profilePic: user.picture,
                                                        picturePath: user.picture,
                                                        authType: "Linkedin",
                                                        fcmToken: fcmToken
                                                    );
                                                    context.read<LoginBloc>().add(
                                                      SocialLoginAuthEvent(
                                                        onLoginEventSuccess: () {
                                                          _onLoginAuthEventSuccess(context);
                                                        },
                                                        onLoginEventError: ([PostLoginAuthResp? error]) {
                                                          _onLoginAuthEventError(context, error);
                                                        },
                                                        user: newUser,
                                                      ),
                                                    );
                                                  }
                                                },

                                                onSignInError: (error) {
                                                  print('Error on sign in: $error');
                                                },
                                              );
                                            }
                                          ),
                                      ),

                                      Semantics(
                                        label: "button: Login using your Google account",
                                        child: CustomOutlinedButton(
                                            height: getVerticalSize(70),
                                            text: "msg_continue_with_google".tr,
                                            margin: getMargin(top: 16),
                                            leftIcon: Container(
                                                margin: getMargin(right: 12),
                                                child: CustomImageView(
                                                    svgPath: ImageConstant.imgGooglesymbol1)),
                                            buttonStyle: CustomButtonStyles.outlinePrimary,
                                            buttonTextStyle: theme.textTheme.titleMedium!,
                                            onTap: () {
                                              onTapContinuewith(context);
                                            }
                                        ),
                                      ),


                                      Padding(
                                          padding: getPadding(left: 33, top: 13, right: 33),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: getPadding(top: 8, bottom: 8),
                                                    child: SizedBox(
                                                        width: getHorizontalSize(62),
                                                        child: Divider())),
                                                Padding(
                                                    padding: getPadding(left: 12),
                                                    child: Text("or",
                                                        style: CustomTextStyles
                                                            .titleSmallBluegray300)),
                                                Padding(
                                                    padding: getPadding(top: 8, bottom: 8),
                                                    child: SizedBox(
                                                        width: getHorizontalSize(74),
                                                        child: Divider(
                                                            indent: getHorizontalSize(12))))
                                              ]
                                          )
                                      ),
                                      Semantics(
                                        label: "or Login using email option.",
                                        child: CustomElevatedButton(
                                            text: "Use Email",
                                            height: getVerticalSize(70),
                                            margin: getMargin(top: 20),
                                            buttonStyle: CustomButtonStyles.fillPrimary,
                                            onTap: () {
                                              context.read<LoginBloc>().add(UseEmailEvent());
                                            }
                                        ),
                                      ),
                                    ],
                                  ),
                                ) : Container(),

                                state.useEmailLogin != null && state.useEmailLogin == true ? Container(
                                  child: Column(
                                    children: [

                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                              padding: getPadding(top: 15),
                                              child: Text("lbl_email".tr,
                                                  style: theme.textTheme.titleSmall))),
                                      BlocBuilder<LoginBloc, LoginState>(
                                          builder: (context, state) {
                                            return Semantics(
                                              label: "Enter your login email here",
                                              child: SizedBox(
                                                height: 68,
                                                child: CustomTextFormField(
                                                    controller: state.emailController,
                                                    margin: getMargin(top: 9),
                                                    hintText: "msg_enter_your_email".tr,
                                                    hintStyle:
                                                    CustomTextStyles.titleMediumBluegray400,
                                                    textInputAction: TextInputAction.done,
                                                    textInputType: TextInputType.emailAddress,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          (!isValidEmail(value,
                                                              isRequired: true))) {
                                                        return "Please enter valid email";
                                                      }
                                                      return null;
                                                    },
                                                    contentPadding: getPadding(
                                                        left: 12,
                                                        top: 15,
                                                        right: 12,
                                                        bottom: 15)
                                                ),
                                              ),
                                            );
                                          }),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: getPadding(top: 18),
                                                child: Text("lbl_password".tr,
                                                    style: theme.textTheme.titleSmall)),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Semantics(
                                              label: "if you've forgotten your password, Click here to reset it.",
                                              child: GestureDetector(
                                                onTap: (){
                                                  NavigatorService.pushNamed(AppRoutes.forgotPasswordRoute);
                                                },
                                                child: SizedBox(
                                                  height: 48,
                                                  child: Padding(
                                                      padding: getPadding(top: 18),
                                                      child: Text(
                                                          "Forgot Password",
                                                          style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.secondary)
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      BlocBuilder<LoginBloc,
                                          LoginState>(
                                          builder: (context, state) {
                                            return Semantics(
                                              label: "Enter your login password here",
                                              child: CustomTextFormField(
                                                  controller: state.passwordController,
                                                  margin: getMargin(top: 9),
                                                  hintText: "msg_create_a_password".tr,
                                                  hintStyle:
                                                  CustomTextStyles.titleMediumBluegray400,
                                                  textInputAction: TextInputAction.done,
                                                  textInputType: TextInputType.visiblePassword,
                                                  suffix: Semantics(
                                                    label: "hide your password",
                                                    child: SizedBox(
                                                      height: 48,
                                                      child: InkWell(
                                                          onTap: () {
                                                            context
                                                                .read<LoginBloc>()
                                                                .add(ChangePasswordVisibilityEvent(
                                                                value: !state.isShowPassword));
                                                          },
                                                          child: Container(
                                                              margin: getMargin(
                                                                  left: 30,
                                                                  top: 14,
                                                                  right: 16,
                                                                  bottom: 14),
                                                              child: CustomImageView(
                                                                  svgPath: state.isShowPassword
                                                                      ? ImageConstant.imgCheckmark
                                                                      : ImageConstant.imgCheckmark))),
                                                    ),
                                                  ),
                                                  suffixConstraints: BoxConstraints(
                                                      maxHeight: getVerticalSize(70)),
                                                  validator: (value) {
                                                    if (value == null || value == "") {
                                                      return "Please enter a password";
                                                    }
                                                    return null;
                                                  },
                                                  obscureText: state.isShowPassword,
                                                  contentPadding:
                                                  getPadding(left: 16, top: 15, bottom: 15)),
                                            );
                                          }),
                                          CustomElevatedButton(
                                              height: 68,
                                              text: "msg_continue_with_email".tr,
                                              margin: getMargin(top: 40),
                                              buttonStyle: CustomButtonStyles.fillPrimary,
                                              onTap: () {
                                                onTapContinuewith1(context);
                                              }
                                          ),
                                    ],
                                  ),
                                ) : Container(),

                                Padding(
                                    padding: getPadding(left: 20, top: 13, right: 20, bottom: 10),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: getPadding(bottom: 1),
                                              child: Text(
                                                  "msg_don_t_have_an_account".tr,
                                                  style: CustomTextStyles
                                                      .titleMediumBluegray300)),
                                          GestureDetector(
                                              onTap: () {
                                                onTapTxtLargelabelmediu(context);
                                              },
                                              child: Padding(
                                                  padding: getPadding(left: 10, right: 10, top:25, bottom: 25),
                                                  child: Text("lbl_sign_up".tr,
                                                      style: theme
                                                          .textTheme.titleMedium))
                                          ),
                                        ])),
                                // GestureDetector(
                                //     onTap: () {
                                //       context.read<LoginBloc>().add(UseSocialLoginEvent());
                                //     },
                                //     child: Container(
                                //       color: theme.colorScheme.primary.withOpacity(0.02),
                                //         child: const Padding(
                                //           padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 8),
                                //           child: Row(
                                //               mainAxisSize: MainAxisSize.min,
                                //             children: [
                                //               Icon(Icons.arrow_back),
                                //               Text(
                                //                 "Use Socials",
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.bold,
                                //                     color: Colors.black
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         )
                                //     )
                                // ),
                                // Container(
                                //     width: getHorizontalSize(245),
                                //     margin: getMargin(
                                //         left: 40, top: 44, right: 40, bottom: 5),
                                //     child: RichText(
                                //         text: TextSpan(children: [
                                //           TextSpan(
                                //               text: "msg_by_signing_up_you2".tr,
                                //               style: CustomTextStyles
                                //                   .titleSmallBluegray400SemiBold),
                                //           TextSpan(
                                //               text: "lbl_terms".tr,
                                //               style: CustomTextStyles
                                //                   .titleSmallErrorContainer),
                                //           TextSpan(
                                //               text: "lbl_and".tr,
                                //               style: CustomTextStyles
                                //                   .titleSmallBluegray400SemiBold),
                                //           TextSpan(
                                //               text: "msg_conditions_of_use".tr,
                                //               style: CustomTextStyles
                                //                   .titleSmallErrorContainer)
                                //         ]),
                                //         textAlign: TextAlign.center)
                                // )
                              ]))),
                ),
              ],
            ),
          ),
        ));
  });
  }

  /// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapImgImage(BuildContext context) {
    NavigatorService.goBack();
  }

  /// Performs a Google sign-in and returns a [GoogleUser] object.
  ///
  /// If the sign-in is successful, the [onSuccess] callback will be called with
  /// a TODO comment needed to be modified by you.
  /// If the sign-in fails, the [onError] callback will be called with the error message.
  ///
  /// Throws an exception if the Google sign-in process fails.
  onTapContinuewith(BuildContext context) async {
    await GoogleAuthHelper().googleSignInProcess().then((googleUser) async {
      if (googleUser != null) {
        final fcmToken = await FirebaseMessaging.instance.getToken();

        //TODO Actions to be performed after signin
        User newUser = User(
            firstName: googleUser.displayName?.split(' ')[0],
            lastName: googleUser.displayName?.split(' ')[1],
            email: googleUser.email,
            profilePic: googleUser.photoUrl,
            picturePath: googleUser.photoUrl,
            authType: "Google",
            fcmToken: fcmToken,
        );
        context.read<LoginBloc>().add(
          SocialLoginAuthEvent(
            onLoginEventSuccess: () {
              _onLoginAuthEventSuccess(context);
            },
            onLoginEventError: ([PostLoginAuthResp? error]) {
              _onLoginAuthEventError(context, error);
            },
            user: newUser,
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('user data is empty')));
      }
    }).catchError((onError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(onError.toString())));
    });
  }

  /// Navigates to the enterOtpScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the enterOtpScreen.
  onTapContinuewith1(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(
        LoginAuthEvent(
          onLoginEventSuccess: () {
            _onLoginAuthEventSuccess(context);
          },
          onLoginEventError: ([PostLoginAuthResp? error]) {
            _onLoginAuthEventError(context, error);
          },
        ),
      );
    }
  }

  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the jobTypeScreen.
  void _onLoginAuthEventSuccess(BuildContext context) {
    NavigatorService.popAndPushNamed(
      AppRoutes.homeContainerScreen,
    );
  }

  /// Displays a toast message using the Fluttertoast library.
  void _onLoginAuthEventError(BuildContext context, [PostLoginAuthResp? error]) {
    Fluttertoast.showToast(msg: error?.message.toString() != null ? (error?.message).toString() :
    "An error occurred while trying to log you in.", toastLength: Toast.LENGTH_LONG);
  }

  /// Navigates to the signUpCreateAcountScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the signUpCreateAcountScreen.
  onTapTxtLargelabelmediu(BuildContext context) {
    NavigatorService.popAndPushNamed(
      AppRoutes.signUpCompleteAccountScreen,
    );
  }
}

class AuthCodeObject {
  AuthCodeObject({required this.code, required this.state});

  final String? code;
  final String? state;
}

class UserObject {
  UserObject({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImageUrl,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? profileImageUrl;
}