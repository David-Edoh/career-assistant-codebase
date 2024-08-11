import 'dart:math';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/foundation.dart';
// import '../../data/models/HomePage/career_suggestion_resp.dart';
import '../../data/models/HomePage/subject_suggestion_resp.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/AdmobAdMedium.dart';


class CareerSubjectsScreen extends StatefulWidget {
  CareerSubjectsScreen({Key? key, required this.subject}) : super(key: key);

  SuggestedSubject subject;

  @override
  State<CareerSubjectsScreen> createState() => _CareerSubjectsScreenState();
}


class _CareerSubjectsScreenState extends State<CareerSubjectsScreen> {

  final String _errorImage = "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg";
  late List<Object> dataads;


  bool _getUrlValid(String url) {
    bool _isUrlValid = AnyLinkPreview.isValidLink(
      url,
      protocols: ['http', 'https']
    );
    return _isUrlValid;
  }

  @override
  void initState() {
    dataads = List.from(widget.subject.careerContents as Iterable);

    for(int i = 1 ; i<=(widget.subject.careerContents!.length/4).round(); i ++){
      var min = 1;
      var rm = new Random();
      //generate a random number from 2 to 18 (+ 1)
      var rannumpos = min + rm.nextInt(widget.subject.careerContents!.length - 1);
      //and add the banner ad to particular index of arraylist
      dataads.insert(rannumpos, "Place an ad here");
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: appTheme.whiteA70001,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            height: getVerticalSize(70),
            leadingWidth: getHorizontalSize(50),
            leading: Center(
              child: AppbarImage(
                  svgPath: ImageConstant.imgGroup162799,
                  margin: getMargin(left: 24, top: 13, bottom: 14),
                  onTap: () {
                    onTapArrowbackone(context);
                  }),
            ),
            centerTitle: true,
            title: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              child: Center(
                child: AppbarTitle(
                    text: "${widget.subject.subject} Courses"
                ),
              ),
            )),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                childAspectRatio: 0.55,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: dataads!.map((careerContent) {
                  try{
                    if(careerContent is CareerContent){
                      return _getUrlValid(careerContent.link.toString().fixWhiteSpaceInUrl()) ? SizedBox(
                        // height: 50.0,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.85,
                        child: AnyLinkPreview(
                          // showMultimedia: false,
                          displayDirection: UIDirection.uiDirectionVertical,
                          link: careerContent.link.toString().fixWhiteSpaceInUrl(),
                          backgroundColor: Colors.white,
                          errorBody: careerContent.title ?? widget.subject.toString(),
                          errorTitle: careerContent.title ?? widget.subject.toString(),
                          errorWidget: Card(
                            elevation: 3,
                            color: Colors.white,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusStyle.roundedBorder8,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: CustomImageView(
                                    svgPath: ImageConstant.link,
                                    height: 80,
                                  ),
                                ),
                                Text(widget.subject.subject.toString()),
                              ],
                            ),
                          ),
                          errorImage: _errorImage,
                        ),
                      ) : Text(careerContent.link.toString());
                    } else {
                      return AdMobAd();
                    }

                  }catch(error){
                    return Text("Failed");
                  }
                }
                ).toList(),
              ),
            ),
          ),
        ));

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

  /// Navigates to the jobTypeScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the jobTypeScreen.
  onTapContinue(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.jobTypeScreen,
    );
  }

  onTapArrowbackone(BuildContext context) {
    Navigator.pop(context);
  }
}
