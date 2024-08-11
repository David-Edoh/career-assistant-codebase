import '../job_details_tab_container_screen/widgets/listwallet_one_item_widget.dart';
import 'bloc/job_details_tab_container_bloc.dart';
import 'models/job_details_tab_container_model.dart';
import 'models/listwallet_one_item_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/presentation/applied_job_page/applied_job_page.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_image_1.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';

class JobDetailsTabContainerScreen extends StatefulWidget {
  const JobDetailsTabContainerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  JobDetailsTabContainerScreenState createState() =>
      JobDetailsTabContainerScreenState();
  static Widget builder(BuildContext context) {
    return BlocProvider<JobDetailsTabContainerBloc>(
      create: (context) =>
          JobDetailsTabContainerBloc(JobDetailsTabContainerState(
        jobDetailsTabContainerModelObj: JobDetailsTabContainerModel(),
      ))
            ..add(JobDetailsTabContainerInitialEvent()),
      child: JobDetailsTabContainerScreen(),
    );
  }
}

class JobDetailsTabContainerScreenState
    extends State<JobDetailsTabContainerScreen> with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA70001,
        appBar: CustomAppBar(
          height: getVerticalSize(70),
          leadingWidth: getHorizontalSize(50),
          leading: AppbarImage(
            svgPath: ImageConstant.imgGroup162799,
            margin: getMargin(
              left: 24,
              top: 13,
              bottom: 13,
            ),
          ),
          centerTitle: true,
          title: AppbarTitle(
            text: "lbl_job_details".tr,
          ),
          actions: [
            AppbarImage1(
              svgPath: ImageConstant.imgBookmark,
              margin: getMargin(
                left: 16,
                top: 13,
                right: 16,
                bottom: 13,
              ),
            ),
          ],
        ),
        body: SizedBox(
          height: getVerticalSize(688),
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: getPadding(
                      top: 30,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: getMargin(
                            right: 24,
                          ),
                          padding: getPadding(
                            left: 72,
                            top: 24,
                            right: 72,
                            bottom: 24,
                          ),
                          decoration: AppDecoration.outlineIndigo.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder16,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: getSize(79),
                                width: getSize(79),
                                padding: getPadding(
                                  all: 19,
                                ),
                                decoration: AppDecoration.fillGray.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder39,
                                ),
                                child: CustomImageView(
                                  svgPath: ImageConstant
                                      .imgCardano1Secondarycontainer,
                                  height: getSize(40),
                                  width: getSize(40),
                                  alignment: Alignment.center,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 16,
                                ),
                                child: Text(
                                  "msg_senior_ui_ux_designer".tr,
                                  style: CustomTextStyles.titleSmallBold,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 7,
                                ),
                                child: Text(
                                  "lbl_shopee_sg".tr,
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 1,
                                  top: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomElevatedButton(
                                      height: getVerticalSize(28),
                                      width: getHorizontalSize(69),
                                      text: "lbl_fulltime".tr,
                                      buttonTextStyle:
                                          theme.textTheme.bodySmall!,
                                    ),
                                    CustomElevatedButton(
                                      height: getVerticalSize(28),
                                      width: getHorizontalSize(104),
                                      text: "lbl_two_days_ago".tr,
                                      margin: getMargin(
                                        left: 9,
                                      ),
                                      buttonTextStyle:
                                          theme.textTheme.bodySmall!,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: getVerticalSize(124),
                            child: BlocSelector<
                                JobDetailsTabContainerBloc,
                                JobDetailsTabContainerState,
                                JobDetailsTabContainerModel?>(
                              selector: (state) =>
                                  state.jobDetailsTabContainerModelObj,
                              builder:
                                  (context, jobDetailsTabContainerModelObj) {
                                return ListView.separated(
                                  padding: getPadding(
                                    left: 15,
                                    top: 24,
                                    right: 49,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (
                                    context,
                                    index,
                                  ) {
                                    return SizedBox(
                                      width: getHorizontalSize(54),
                                    );
                                  },
                                  itemCount: jobDetailsTabContainerModelObj
                                          ?.listwalletOneItemList.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    ListwalletOneItemModel model =
                                        jobDetailsTabContainerModelObj
                                                    ?.listwalletOneItemList[
                                                index] ??
                                            ListwalletOneItemModel();
                                    return ListwalletOneItemWidget(
                                      model,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: getVerticalSize(44),
                          width: getHorizontalSize(351),
                          margin: getMargin(
                            top: 26,
                          ),
                          child: TabBar(
                            controller: tabviewController,
                            isScrollable: true,
                            labelColor: theme.colorScheme.primary,
                            labelStyle: TextStyle(
                              fontSize: getFontSize(12),
                              fontFamily: 'Plus Jakarta Sans',
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelColor: appTheme.blueGray300,
                            unselectedLabelStyle: TextStyle(
                              fontSize: getFontSize(12),
                              fontFamily: 'Plus Jakarta Sans',
                              fontWeight: FontWeight.w600,
                            ),
                            indicator: BoxDecoration(
                              color: appTheme.gray100,
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(22),
                              ),
                            ),
                            tabs: [
                              Tab(
                                child: Text(
                                  "lbl_description".tr,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "lbl_requirement".tr,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "msg_responsibilities".tr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: getMargin(
                  top: 449,
                ),
                height: getVerticalSize(269),
                child: TabBarView(
                  controller: tabviewController,
                  children: [
                    AppliedJobPage.builder(context),
                    AppliedJobPage.builder(context),
                    AppliedJobPage.builder(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
