import 'dart:math';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:fotisia/data/models/HomePage/careeer_content_link.dart';
import '../../data/models/HomePage/career_suggestion_resp.dart';
import '../../data/models/HomePage/event_suggestion_resp.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/card_detail.dart';
import 'bloc/links_preview_bloc.dart';
import 'models/links_preview_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_pin_code_text_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:graphview/GraphView.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:fotisia/widgets/AdmobAdMedium.dart';

import 'widgets/link_card.dart';


class LinksPreviewScreen extends StatefulWidget {
  LinksPreviewScreen({Key? key}) : super(key: key);


  @override
  State<LinksPreviewScreen> createState() => _LinksPreviewScreenState();

  static Widget builder(BuildContext context) {
    return BlocProvider<LinksPreviewBloc>(
        create: (context) => LinksPreviewBloc(LinksPreviewState())
          ..add(LinksPreviewInitialEvent()),
        child: LinksPreviewScreen()
    );
  }
}


class _LinksPreviewScreenState extends State<LinksPreviewScreen> {
  final String _errorImage = "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg";
  late List<Object> dataads =[];
  late List<Link> links = [];
  late String title;

  bool _getUrlValid(String url) {
    bool _isUrlValid = AnyLinkPreview.isValidLink(
        url,
        protocols: ['http', 'https']
    );
    return _isUrlValid;
  }

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    if(links.isEmpty){
      final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
      setState(() {
        links = arguments['links'];
        title = arguments['title'];

        dataads = List.from(links);

        // for(int i = 1 ; i<=(links.length/4).round(); i ++){
        //   var min = 1;
        //   var rm = new Random();
        //   //generate a random number from 2 to 18 (+ 1)
        //   var rannumpos = min + rm.nextInt(links.length - 1);
        //   //and add the banner ad to particular index of arraylist
        //   dataads.insert(rannumpos, "Place an ad here");
        // }
      });
    }


    return Scaffold(
        backgroundColor: appTheme.whiteA70001,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            height: getVerticalSize(70),
            leadingWidth: getHorizontalSize(50),
            leading: Semantics(
              label: "Go back to the home page button",
              child: Center(
                child: AppbarImage(
                    svgPath: ImageConstant.imgGroup162799,
                    margin: getMargin(left: 24, top: 13, bottom: 14),
                    onTap: () {
                      onTapArrowbackone(context);
                    }),
              ),
            ),
            centerTitle: true,
            title: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              child: Center(
                child: AppbarTitle(
                    text: title
                ),
              ),
            )),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: dataads != null ? ListView(
                // childAspectRatio: 0.55,
                // crossAxisCount: 2,
                // mainAxisSpacing: 20,
                // crossAxisSpacing: 20,
                children: dataads!.map((careerContent) {
                  try{
                    if(careerContent is Link){
                      return _getUrlValid(careerContent.link.toString().fixWhiteSpaceInUrl().removeWwwFromUrl()) ? SizedBox(
                        height: mediaQueryData.size.height * 0.4,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.85,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: AnyLinkPreview(
                            bodyMaxLines: 3,
                            bodyTextOverflow: TextOverflow.ellipsis,
                            displayDirection: UIDirection.uiDirectionVertical,
                            link: careerContent.link.toString().fixWhiteSpaceInUrl().removeWwwFromUrl(),
                            backgroundColor: Colors.white,
                            errorBody: careerContent.description ?? links.toString(),
                            errorTitle: careerContent.title ?? links.toString(),
                            errorWidget: Semantics(
                              label: title,
                              child: ImageCard(
                                imageUrl: "https://images.unsplash.com/photo-1708446309501-b73d6199392f?q=80&w=2040&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                title: careerContent.title ?? "",
                                description: careerContent.description ?? "",
                                url: careerContent.link.toString().fixWhiteSpaceInUrl().removeWwwFromUrl()
                              )
                            ),
                            errorImage: "https://images.unsplash.com/photo-1708446309501-b73d6199392f?q=80&w=2040&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          ),
                        ),
                      ) : Text("Invalid link: ${careerContent.link.toString()}");
                    } else { // Place ad
                      return AdMobAd();
                    }
                  } catch (error){
                    return Text("Failed");
                  }
                }
                ).toList(),
              ) : Center(
                child: Text("loading"),
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
