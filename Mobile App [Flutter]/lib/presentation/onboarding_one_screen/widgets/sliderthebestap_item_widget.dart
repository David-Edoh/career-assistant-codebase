import '../models/sliderthebestap_item_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';

// ignore: must_be_immutable
class SliderthebestapItemWidget extends StatelessWidget {
  SliderthebestapItemWidget(
    this.sliderthebestapItemModelObj, {
    Key? key,
    this.onTapLabel,
  }) : super(
          key: key,
        );

  SliderthebestapItemModel sliderthebestapItemModelObj;

  VoidCallback? onTapLabel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: getPadding(
          left: 39,
          top: 32,
          right: 39,
          bottom: 32,
        ),
        decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: getHorizontalSize(246),
              child: RichText(
                text:  TextSpan(
                  text: "Hi...",
                  style: theme.textTheme.headlineSmall,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: getHorizontalSize(246),
              child: RichText(
                text:  TextSpan(
                  text: "I'm Sia.",
                  style: theme.textTheme.headlineSmall,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Your personal success assistant.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.titleSmallBluegray300.copyWith(
                height: 1.57,
              ),
            ),
            Text(
              "My job is to make sure you win!!!",
              // maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.titleSmallBluegray300.copyWith(
                height: 1.57,
              ),
            ),
            CustomElevatedButton(
              width: getHorizontalSize(101),
              text: "Next",
              margin: getMargin(
                top: 85,
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
