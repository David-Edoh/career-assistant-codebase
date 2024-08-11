import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

class DotSection extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Dot(),
            Dot(),
            Dot(),
            Dot(),
            Dot(),
            Dot(),
            // Dot(),
          ],
        ),
        // Journey icon here...
        // ...
        Column(
          children: [
            Semantics(
              label: "Image: keep walking graphics",
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomImageView(
                  svgPath: ImageConstant.footsteps,
                  height: 15,
                  width: 15,
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            Semantics(
              label: "Image: keep walking graphics",
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomImageView(
                  svgPath: ImageConstant.footsteps,
                  height: 15,
                  width: 15,
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

Widget Dot() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2.0),
    width: 4.0,
    height: 4.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey,
    ),
  );
}