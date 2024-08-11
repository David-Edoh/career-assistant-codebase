import '../saved_page/widgets/saved_item_widget.dart';
import 'bloc/saved_bloc.dart';
import 'models/saved_item_model.dart';
import 'models/saved_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<SavedBloc>(
        create: (context) => SavedBloc(SavedState(savedModelObj: SavedModel()))
          ..add(SavedInitialEvent()),
        child: SavedPage());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA70001,
            appBar: CustomAppBar(
                leadingWidth: getHorizontalSize(50),
                height: getVerticalSize(70),
                leading: AppbarImage(
                    svgPath: ImageConstant.imgGroup162799,
                    margin: getMargin(left: 24, top: 13, bottom: 13),
                    onTap: () {
                      onTapArrowbackone(context);
                    }),
                centerTitle: true,
                title: AppbarTitle(text: "lbl_saved".tr)),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 24, right: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: getPadding(top: 30),
                              child: BlocSelector<SavedBloc, SavedState,
                                      SavedModel?>(
                                  selector: (state) => state.savedModelObj,
                                  builder: (context, savedModelObj) {
                                    return ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                              height: getVerticalSize(12));
                                        },
                                        itemCount: savedModelObj
                                                ?.savedItemList.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          SavedItemModel model = savedModelObj
                                                  ?.savedItemList[index] ??
                                              SavedItemModel();
                                          return SavedItemWidget(model);
                                        });
                                  }))),
                      Container(
                          height: getVerticalSize(148),
                          width: getHorizontalSize(327),
                          decoration: BoxDecoration(
                              color: appTheme.gray5001,
                              borderRadius:
                                  BorderRadius.circular(getHorizontalSize(16)),
                              border: Border.all(
                                  color: appTheme.indigo50,
                                  width: getHorizontalSize(1))))
                    ]))));
  }

  /// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapArrowbackone(BuildContext context) {
    NavigatorService.goBack();
  }
}
