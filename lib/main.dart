import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nightlight/Onboarding/onboarding.dart';
import 'package:nightlight/SplashScreen/splashscreen.dart';
import 'package:nightlight/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String fcmToken = (await FirebaseMessaging.instance.getToken())!;

  print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<FCM Token: $fcmToken");

  String installationId = await getInstallationId();

  print("<<<<<<<<<<<<<<<<<<<<<Installation ID: $installationId");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasSeenOnboardingScreen =
      prefs.getBool('hasSeenOnboardingScreen') ?? false;
  print('Value In main $hasSeenOnboardingScreen');

  runApp(MyApp(
    hasSeenOnboardingScreen: hasSeenOnboardingScreen,
  ));
}

Future<String> getInstallationId() async {
  String? storedInstallationId = await getStoredInstallationId();

  if (storedInstallationId != null) {
    return storedInstallationId;
  } else {
    String newInstallationId = const Uuid().v4();
    await storeInstallationId(newInstallationId);

    return newInstallationId;
  }
}

Future<String?> getStoredInstallationId() async {
  return null;
}

Future<void> storeInstallationId(String installationId) async {}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboardingScreen;

  const MyApp({super.key, required this.hasSeenOnboardingScreen});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: hasSeenOnboardingScreen
            ? const SplashScreen()
            : const OnboardingOne(),
      ),
    );
  }
}
