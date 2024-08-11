import 'bloc/splash_bloc.dart';
import 'models/splash_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<SplashBloc>(
        create: (context) =>
            SplashBloc(SplashState(splashModelObj: SplashModel()))
              ..add(SplashInitialEvent()),
        child: const SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
      return Scaffold(
          backgroundColor: theme.colorScheme.tertiary,
          body: SafeArea(
            child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Semantics(
                      label: "Image: Slash image: Fotisia logo",
                      child: CustomImageView(
                          imagePath: ImageConstant.imgLogo, //logo
                          height: getVerticalSize(200),
                          width: getHorizontalSize(200),
                          alignment: Alignment.center,
                          margin: getMargin(bottom: 5)
                      ),
                    ),
                  ],
                )),
          ),
      );
    });
  }
}
