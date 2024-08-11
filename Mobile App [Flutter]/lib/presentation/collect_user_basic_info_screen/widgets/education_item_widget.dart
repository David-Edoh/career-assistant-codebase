import '../models/education_item_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class EducationItemWidget extends StatelessWidget {
  EducationItemWidget(
    this.educationItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  EducationItemModel educationItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: getPadding(
              left: 12,
              top: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  educationItemModelObj.internshipuiuxTxt,
                  style: CustomTextStyles.titleSmallPrimarySemiBold,
                ),
                Padding(
                  padding: getPadding(
                    top: 6,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: getPadding(
                          top: 1,
                        ),
                        child: Text(
                          "lbl_shopee_sg".tr,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 3,
                          top: 1,
                        ),
                        child: Text(
                          "lbl".tr,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 4,
                        ),
                        child: Text(
                          educationItemModelObj.zipcodeTxt,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomIconButton(
          height: getSize(48),
          width: getSize(48),
          padding: getPadding(
            all: 8,
          ),
          child: CustomImageView(
            svgPath: ImageConstant.imgEditsquare,
            height: getSize(12),
            width: getSize(12),
          ),
        ),
      ],
    );
  }
}
