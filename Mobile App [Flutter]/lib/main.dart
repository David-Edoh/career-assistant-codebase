import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fotisia/presentation/chat_screen/widget/chat_provider.dart';
import 'package:fotisia/presentation/resume_maker_screen/resume_edit_session_manager.dart';
import 'package:fotisia/presentation/resume_maker_screen/widgets/resume_edit_stt.dart';
import 'package:fotisia/core/utils/scheduler.dart';
import 'package:fotisia/widgets/floating-hearts/provider/floating-hearts-provider.dart';
import 'core/app_export.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/utils/long_wait_animation_provider.dart';
import 'firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:workmanager/workmanager.dart';
import 'core/utils/local_notificattion_service.dart';
import 'package:timezone/data/latest.dart' as tz;


var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();



@pragma('vm:entry-point')
callbackDispatcher() async {
  // await dotenv.load(fileName: ".env");

  Workmanager().executeTask((task, inputData) async {
    await scheduler(task, inputData);
    return Future.value(true);
  });
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  await NotificationService.init();
  tz.initializeTimeZones();

  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
    PrefUtils().init()
  ]).then((value) async {
    runApp(const MyApp());

    await FirebaseMessaging.instance.requestPermission();
  });
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(
        ThemeState(
          themeType: PrefUtils().getThemeData(),
        ),
      ),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => FloatingHeartsProvider()),
              ChangeNotifierProvider(create: (context) => ChatProvider()),
              ChangeNotifierProvider(create: (context) => SpeechToTextProvider()),
              ChangeNotifierProvider(create: (context) => LongLoadingProvider()),
            ],
            child: MaterialApp(
              // builder: (context, child) {
              //   // Add AccessibilityTools to the widget tree. The tools are available
              //   // only in debug mode
              //   return AccessibilityTools(
              //     // enableButtonsDrag: true,
              //     checkFontOverflows: true,
              //     checkImageLabels: true,
              //     child: child,
              //   );
              // },
              theme: theme,
              title: 'fotisia',
              navigatorKey: NavigatorService.navigatorKey,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                AppLocalizationDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale(
                  'en',
                  '',
                ),
              ],
              initialRoute: AppRoutes.initialRoute,
              routes: AppRoutes.routes,
            ),
          );
        },
      ),
    );
  }
}
