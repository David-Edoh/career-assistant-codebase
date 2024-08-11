import 'dart:convert';
import 'package:read_pdf_text/read_pdf_text.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pick_or_save/pick_or_save.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;
import '../../core/utils/long_wait_animation_provider.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/collect_user_basic_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';


class CollectBasicUserInfoScreen extends StatefulWidget {
  const CollectBasicUserInfoScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<CollectBasicUserInfoBloc>(
        create: (context) => CollectBasicUserInfoBloc(CollectBasicUserInfoState(hobbiesController: TextfieldTagsController()))
          ..add(InitializeCollectBasicUserInfoEvent()),
        child: CollectBasicUserInfoScreen());
  }

  @override
  State<CollectBasicUserInfoScreen> createState() => _CollectBasicUserInfoScreenState();
}

class _CollectBasicUserInfoScreenState extends State<CollectBasicUserInfoScreen> {
  String fileName = "Upload your resume (Optional)";
  bool initialMilestoneSet = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return BlocConsumer<CollectBasicUserInfoBloc, CollectBasicUserInfoState>(
        listener: (BuildContext context, state) {
            context.read<LongLoadingProvider>().setLoading(true);
            if(!initialMilestoneSet){
              context.read<LongLoadingProvider>().setLoadingMileStone(0);
              setState(() {
                initialMilestoneSet = true;
              });
            }
        },

        builder: (BuildContext context, state) {
    return BlocBuilder<CollectBasicUserInfoBloc, CollectBasicUserInfoState>(
    builder: (context, state) {

    return Scaffold(
        backgroundColor: appTheme.whiteA70001,
        appBar: CustomAppBar(
            height: getVerticalSize(70),
            leadingWidth: getHorizontalSize(50),
            leading: Semantics(
              label: "Button : Back to key-strength page",
              child: AppbarImage(
                  svgPath: ImageConstant.imgGroup162799,
                  margin: getMargin(left: 24, top: 13, bottom: 14),
                  onTap: () {
                    onTapArrowbackone(context);
                  }),
            ),
            centerTitle: true,
            title: AppbarTitle(text: "Edit Resume Details")),
        body: SafeArea(
          child: SizedBox(
              width: mediaQueryData.size.width,
              child: SingleChildScrollView(
                  child: Padding(
                      padding: getPadding(left: 24, right: 24, bottom: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Center(
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       uploadProfilePic(context);
                            //     },
                            //     child: (state.userPicture != null && state.userPicture!.isNotEmpty) ?
                            //     ClipRRect(
                            //       borderRadius: BorderRadius.circular(getHorizontalSize(44)),
                            //       child: Container(
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(getHorizontalSize(44)),
                            //         ),
                            //         child: Image.memory(
                            //             base64Decode(state.userPicture as String),
                            //             height: getSize(89),
                            //             width: getSize(89),
                            //         ),
                            //       ),
                            //
                            //     ) : CustomImageView(
                            //         url: (state.picturePath != null && state.picturePath!.isNotEmpty) ? state.picturePath : "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png",
                            //         height: getSize(89),
                            //         width: getSize(89),
                            //         radius: BorderRadius
                            //             .circular(
                            //             getHorizontalSize(44)
                            //         )
                            //     ),
                            //   ),
                            // ),
                            //
                            // Center(
                            //   child: Padding(
                            //       padding: getPadding(top: 18),
                            //       child: Text("Professional Picture (optional)",
                            //           style:
                            //           CustomTextStyles.titleSmallPrimary)),
                            // ),

                            // CustomOutlinedButton(
                            //     height: getVerticalSize(52),
                            //     text: "Click to Upload",
                            //     margin: getMargin(top: 9, bottom: 10),
                            //     // rightIcon: Container(
                            //     //     margin: getMargin(left: 30),
                            //     //     child: CustomImageView(
                            //     //         svgPath: ImageConstant
                            //     //             .imgCalendar)),
                            //     buttonStyle: CustomButtonStyles
                            //         .outlineIndigo,
                            //     buttonTextStyle:
                            //     CustomTextStyles
                            //         .titleMediumBluegray400,
                            //     onTap: () {
                            //       uploadProfilePic(context);
                            //     }),

                            Padding(
                                padding: getPadding(top: 18),
                                child: Text("lbl_phone".tr,
                                    style:
                                    CustomTextStyles.titleSmallPrimary)),
                            BlocSelector<CollectBasicUserInfoBloc,
                                CollectBasicUserInfoState,
                                TextEditingController?>(
                                selector: (state) => state.phoneController,
                                builder: (context, phoneController) {
                                  return Semantics(
                                    label: "Input field: Enter your phone number here",
                                    child: CustomTextFormField(
                                        textInputType: TextInputType.phone,
                                        contentPadding: getPadding(top: 20, bottom: 20, left: 10, right: 10),
                                        controller: phoneController,
                                        margin: getMargin(top: 9),
                                        hintText: "lbl_1_1234567890".tr,
                                        hintStyle: CustomTextStyles
                                            .titleMediumBluegray400),
                                  );
                                }),
                            Padding(
                                padding: getPadding(top: 18),
                                child: Text("Address",
                                    style:
                                    CustomTextStyles.titleSmallPrimary)),
                            BlocSelector<CollectBasicUserInfoBloc,
                                CollectBasicUserInfoState,
                                TextEditingController?>(
                                selector: (state) => state.locationController,
                                builder: (context, locationController) {
                                  return Semantics(
                                    label: "Input field: Enter your address number here",
                                    child: CustomTextFormField(
                                        controller: locationController,
                                        margin: getMargin(top: 9),
                                        hintText: "Your address",
                                        hintStyle: CustomTextStyles
                                            .titleMediumBluegray400,
                                        textInputAction: TextInputAction.done,
                                        maxLines: 6,
                                        contentPadding: getPadding(
                                            left: 16,
                                            top: 20,
                                            right: 16,
                                            bottom: 20)),
                                  );
                                }),

                            Padding(
                                padding: getPadding(top: 18),
                                child: Text("Your Hobbies",
                                    style:
                                    CustomTextStyles.titleSmallPrimary)),
                            BlocSelector<CollectBasicUserInfoBloc,
                                CollectBasicUserInfoState,
                                TextfieldTagsController?>(
                                selector: (state) => state.hobbiesController,
                                builder: (context, hobbiesController) {
                                  return Semantics(
                                    label: "Input field: Enter your hobbies here. Separated by a comma.",
                                    child: TextFieldTags(
                                      textfieldTagsController: hobbiesController,
                                      initialTags: state.hobbies,
                                      textSeparators: const [' ', ','],
                                      letterCase: LetterCase.normal,
                                      validator: (String tag) {
                                        // if (tag == 'php') {
                                        //   return 'No, please just no';
                                        // } else if (hobbiesController!.getTags.contains(tag)) {
                                        //   return 'you already entered that';
                                        // }
                                        return null;
                                      },
                                      inputfieldBuilder:
                                          (context, tec, fn, error, onChanged, onSubmitted) {
                                        return ((context, sc, tags, onTagDelete) {
                                          return Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextField(
                                              controller: tec,
                                              focusNode: fn,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black12,
                                                    width: 3.0,
                                                  ),
                                                ),
                                                focusedBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black12,
                                                    width: 3.0,
                                                  ),
                                                ),
                                                helperText: 'Enter hobbies...',
                                                helperStyle: const TextStyle(
                                                  color: Colors.black38,
                                                ),
                                                // hintText: hobbiesController!.hasTags ? '' : "Enter tag...",
                                                errorText: error,
                                                prefixIconConstraints:
                                                BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.74),
                                                prefixIcon: tags.isNotEmpty
                                                    ? SingleChildScrollView(
                                                  controller: sc,
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                      children: tags.map((String tag) {
                                                        return Container(
                                                          decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.all(
                                                              Radius.circular(26.0),
                                                            ),
                                                            color: Colors.black,
                                                          ),
                                                          margin: const EdgeInsets.symmetric(
                                                              horizontal: 5.0),
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 10.0, vertical: 5.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                child: Text(
                                                                  '#$tag',
                                                                  style: const TextStyle(
                                                                      color: Colors.white),
                                                                ),
                                                                onTap: () {
                                                                  // print("$tag selected");
                                                                },
                                                              ),
                                                              const SizedBox(width: 4.0),
                                                              InkWell(
                                                                child: const Icon(
                                                                  Icons.cancel,
                                                                  size: 14.0,
                                                                  color: Color.fromARGB(
                                                                      255, 233, 233, 233),
                                                                ),
                                                                onTap: () {
                                                                  onTagDelete(tag);
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      }).toList()),
                                                )
                                                    : null,
                                              ),
                                              onChanged: onChanged,
                                              onSubmitted: onSubmitted,
                                            ),
                                          );
                                        });
                                      },
                                    ),
                                  );
                                }),

                            Padding(
                                padding: getPadding(top: 18),
                                child: Text("Disability (Optional)",
                                    style:
                                    CustomTextStyles.titleSmallPrimary)),
                            BlocSelector<CollectBasicUserInfoBloc,
                                CollectBasicUserInfoState,
                                TextEditingController?>(
                                selector: (state) => state.disabilityController,
                                builder: (context, disabilityController) {
                                  return Semantics(
                                    label: "Input field: Enter any disability you have here.",
                                    child: CustomTextFormField(
                                        contentPadding: getPadding(top: 20, bottom: 20, left: 10, right: 10),
                                        controller: disabilityController,
                                        margin: getMargin(top: 9),
                                        hintText: "E.g vision Impairment.",
                                        hintStyle: CustomTextStyles.titleMediumBluegray400),
                                  );
                                }),
                            Padding(
                                padding: getPadding(top: 18),
                                child: Text("Resume in pdf (Optional)",
                                    style: CustomTextStyles.titleSmallPrimary)
                            ),
                            Semantics(
                              label: "button: select your resume: $fileName",
                              child: CustomOutlinedButton(
                                  height: 48,
                                  // width: mediaQueryData.size.width * 0.8,
                                  text: fileName,
                                  margin: getMargin(top: 9, bottom: 10),
                                  rightIcon: Icon(
                                    Icons.contact_page_rounded,
                                    semanticLabel: fileName,
                                  ),
                                  buttonStyle: CustomButtonStyles
                                      .outlineIndigo,
                                  buttonTextStyle:
                                  CustomTextStyles
                                      .titleMediumBluegray400,
                                  onTap: () {
                                    uploadResumeData(context);
                                  }),
                            ),
                          ]
                      )
                  )
              )
          ),
        ),

        bottomNavigationBar: CustomElevatedButton(
            text: "Finish",
            margin: getMargin(left: 24, right: 24, top: 10, bottom: 20),
            buttonStyle: CustomButtonStyles.fillPrimary,
            onTap: () {
                context.read<CollectBasicUserInfoBloc>().add(
                  SaveCollectedUserInfoEvent(),
                );
            }
        )

    );
  });
        },
    );
  }

  finishOnboarding(BuildContext context, CollectBasicUserInfoState state) async {
      context.read<CollectBasicUserInfoBloc>().add(
        SaveCollectedUserInfoEvent(
          onSaveUserDetailsError: () {
            _onSaveUserDataEventError(context);
          },
          onSaveUserDetailsSuccess: () {
            NavigatorService.pushNamed(
              AppRoutes.homeContainerScreen,
            );
          },
        ),
      );
    }

Future<void> uploadResumeData(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    String? filePath = result.files.single.path;

    if (filePath != null) {
      setState(() {
        fileName = path.basename(filePath);
      });

      String textList = await ReadPdfText.getPDFtext(filePath);

      context.read<CollectBasicUserInfoBloc>().add(
        SetResumeData(resumeData: textList),
      );
    }
  } else {
    // User canceled the picker
  }
}
}

/// Displays a toast message using the Fluttertoast library.
void _onSaveUserDataEventError(BuildContext context) {
  Fluttertoast.showToast(msg: "An error occurred while trying save your data.", toastLength: Toast.LENGTH_LONG);
}


/// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapArrowbackone(BuildContext context) {
    NavigatorService.goBack();
    // NavigatorService.popAndPushNamed(AppRoutes.resumeMaker);
  }

Future<void> uploadProfilePic(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'jpeg', 'png'],
  );

  if (result != null) {
    String? filePath = result.files.single.path;
    if (filePath != null) {
      _cropImage(filePath, context);
    }
  } else {
    // User canceled the picker
  }
}



  editExperience (BuildContext context, int id) async {
    context.read<CollectBasicUserInfoBloc>().add(
      SaveCollectedUserInfoEvent(),
    );
    const storage = FlutterSecureStorage();
    await storage.write(key: "itemId", value: id.toString());
    NavigatorService.pushNamed(AppRoutes.newPositionScreen).then((value){
      context.read<CollectBasicUserInfoBloc>().add(InitializeCollectBasicUserInfoEvent());
    });
  }



  Future<Null> _cropImage(String path, BuildContext context) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            :
        [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Cropper',
            // initAspectRatio: CropAspectRatioPreset.square,
            // lockAspectRatio: true
          ),
        ],
    );


    context.read<CollectBasicUserInfoBloc>().add(
      SetSelectedImage(value: croppedFile!.path),
    );
  }



class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectBasicUserInfoBloc, CollectBasicUserInfoState>(
        builder: (context, state) {
          // rebuild widget...
          return Text("");
        }
    );
  }
}