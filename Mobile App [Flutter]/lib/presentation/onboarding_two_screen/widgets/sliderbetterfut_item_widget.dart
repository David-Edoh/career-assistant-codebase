import '../models/sliderbetterfut_item_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';

// ignore: must_be_immutable
class SliderbetterfutItemWidget extends StatelessWidget {
  SliderbetterfutItemWidget(
    this.sliderbetterfutItemModelObj, {
    Key? key,
    this.onTapLabel,
  }) : super(
          key: key,
        );

  SliderbetterfutItemModel sliderbetterfutItemModelObj;

  VoidCallback? onTapLabel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: getVerticalSize(600),
        padding: getPadding(
          left: 24,
          top: 25,
          right: 24,
          bottom: 25,
        ),
        decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: getHorizontalSize(273),
              margin: getMargin(
                left: 6,
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:  "Tell me more about yourself",
                      style: theme.textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: "",
                      style: theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: getPadding(
                left: 17,
                top: 14,
                right: 17,
              ),
              child: Text(
                "I would like to collect more information about you so I can help you better.",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.titleSmallBluegray300.copyWith(
                  height: 1.57,
                ),
              ),
            ),
            CustomElevatedButton(
              width: getHorizontalSize(101),
              text: "lbl_next".tr,
              margin: getMargin(
                top: 69,
              ),
              buttonStyle: CustomButtonStyles.fillPrimary,
              onTap: () {
                onTapLabel?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}
