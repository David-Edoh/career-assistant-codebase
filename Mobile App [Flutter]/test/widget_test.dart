// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fotisia/core/utils/pref_utils.dart';
import 'package:fotisia/main.dart';
import 'package:fotisia/presentation/career_roadmap_screen/career_roadmap_screen.dart';
import 'package:fotisia/presentation/home_container_screen/home_container_screen.dart';
import 'package:fotisia/presentation/home_page/home_page.dart';
import 'package:fotisia/presentation/links_preview_screen/links_preview_screen.dart';
import 'package:fotisia/presentation/login_screen/login_screen.dart';
import 'package:fotisia/presentation/settings_screen/settings_screen.dart';
import 'package:fotisia/presentation/splash_screen/splash_screen.dart';
import 'package:fotisia/widgets/app_bar/appbar_circleimage.dart';
import 'package:fotisia/widgets/app_bar/appbar_image_1.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_bottom_bar.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';
import 'dart:io';


Future<void> main() async {
  HttpOverrides.global = _MyHttpOverrides();

  testWidgets('LoginScreen widget test', (WidgetTester tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await dotenv.load(fileName: ".env");

      // setUp(() {
        // WidgetsBinding.instance.renderView.configuration =   TestViewConfiguration.fromView(size: const Size(1200.0, 1980.0), view: null);
      // });
      tester.binding.setSurfaceSize(const Size(1400, 3000));
      tester.view.physicalSize = const Size(1350, 3000);
      tester.view.devicePixelRatio = 1;

      await Future.wait([
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]),
        PrefUtils().init()
      ]);

      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      await tester.pumpUntilFound(tester, find.byType(SplashScreen));
      print("splash screen found");

      //if homepage is found at this point, log the user out...
      try{
        await tester.pumpUntilFound(tester, find.byType(HomePage));
        print("User is logged in, Logging user out");
        await _logout(tester);
      } catch (e){
        print("Great, User not logged in!");
      }

      await tester.pumpUntilFound(tester, find.byType(LoginScreen));

      // Verify that LoginScreen is rendered.
      expect(find.byType(LoginScreen), findsOneWidget);
      print("login screen found");

      // Test AppBar components
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(CustomOutlinedButton),
          findsNWidgets(1)); // Change based on your actual widget count
      expect(find.byType(TextFormField),
          findsNWidgets(2)); // Change based on your actual widget count
      expect(find.byType(CustomElevatedButton), findsOneWidget);

      // Test Login Form
      await tester.enterText(
          find.byType(TextFormField).at(0), 'contact.edoh@gmail.com');
      await tester.enterText(
          find.byType(TextFormField).at(1), 'potatoPassword');
      sleep(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CustomElevatedButton));
      await tester.pumpAndSettle();

      await tester.pumpUntilFound(tester, find.byType(HomeContainerScreen));
      await tester.tap(find.text("Home"));
      sleep(const Duration(seconds: 2));

      // Verify that homepage is rendered
      await tester.pumpUntilFound(tester, find.byType(HomePage));
      expect(find.byType(HomePage), findsOneWidget);
      print("Home screen found");

      //Test AppBar components
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(CustomAppBar), findsOneWidget);
      expect(find.byType(AppbarCircleimage), findsOneWidget);

      //Test Section 1 components
      expect(find.text('Elevate Your Career'), findsOneWidget);
      expect(find.byType(CarouselSlider), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(2)); // Two GestureDetector widgets

      //Test Section 2 components
      // expect(find.text('Your Roadmap'), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(CareerRoadmapScreen), findsOneWidget);

      //Test Section 3 components
      expect(find.text('Opportunities near you'), findsOneWidget);
      expect(find.byType(CarouselSlider), findsNWidgets(2)); // Two CarouselSlider widgets
      expect(find.byType(LinksPreviewScreen), findsOneWidget);

      expect(find.text('Events near you'), findsOneWidget);
      expect(find.byType(CarouselSlider), findsNWidgets(3)); // Three CarouselSlider widgets
      expect(find.byType(LinksPreviewScreen), findsOneWidget);

    }
  );

  // testWidgets('HomePage widget test', (WidgetTester tester) async {
  //
  //   // Verify that HomePage is rendered.
  //   expect(find.byType(HomePage), findsOneWidget);
  //
  // });
}

Future<void> _logout(WidgetTester tester) async {
  // Verify that CustomBottomBar is rendered.
  expect(find.byType(CustomBottomBar), findsOneWidget);
  print("CustomBottomBar found");
  sleep(const Duration(seconds: 3));

  // Example: Test initial selected index
  // expect((tester.widget(find.byType(BottomNavigationBar)) as BottomNavigationBar).currentIndex, 0);

  // Example: Tap on the third item and check the selected index
  await tester.tap(find.text("Profile"));
  await tester.pump();
  expect((tester.widget(find.byType(BottomNavigationBar)) as BottomNavigationBar).currentIndex, 2);
  print("Profile screen found");
  sleep(const Duration(seconds: 6));

  // Verify that the CustomAppBar is rendered.
  expect(find.byType(CustomAppBar), findsOneWidget);

  // Tap on the action button and verify the onTap functionality.
  await tester.tap(find.byType(AppbarImage1));
  await tester.pump();
  await tester.pumpUntilFound(tester, find.byType(SettingsScreen));
  print("Settings screen found");
  sleep(const Duration(seconds: 3));

  // Verify that the GestureDetector with the text "lbl_logout" is rendered.
  expect(find.text("Logout"), findsOneWidget);

  // Tap on the logout button.
  await tester.tap(find.text("Logout"));
  await tester.pump();
  sleep(const Duration(seconds: 3));

  // Accept logout confirmation.
  await tester.tap(find.byType(CustomOutlinedButton));
  await tester.pump();

  sleep(const Duration(seconds: 3));
}

extension PumpUntilFound on WidgetTester {
  Future<void> pumpUntilFound(
      WidgetTester tester,
      Finder finder, {
        Duration timeout = const Duration(seconds: 20),
      }) async {
    final end = DateTime.now().add(timeout);

    do {
      if (DateTime.now().isAfter(end)) {
        throw Exception('Timed out waiting for $finder');
      }

      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 100));
    } while (finder.evaluate().isEmpty);
  }
}

class _MyHttpOverrides extends HttpOverrides {}