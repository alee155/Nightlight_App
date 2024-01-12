import 'dart:async';

import 'package:firebase_core/firebase_core.dart'; // Import Firebase
import 'package:firebase_remote_config/firebase_remote_config.dart'; // Import Firebase Remote Config
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:nightlight/App_Utils/app_utils.dart';
import 'package:nightlight/HomeScreen/homescreen.dart';
import 'package:nightlight/Onboarding/onboarding.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Firebase.initializeApp();
    initRemoteConfig();
  }

  Future<void> initRemoteConfig() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    int currentAppVersion = int.parse(version.split('.')[0]);
    print('>>>>>>>>>>>>>>>>>Current App Version: $currentAppVersion');

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await remoteConfig.setDefaults(const {"nightlights_version": 1});
    await remoteConfig.fetchAndActivate();
    final latestAppVersion =
        int.parse(remoteConfig.getString("nightlights_version"));
    print('>>>>>>>>>Latest remote config Version: $latestAppVersion');

    if (currentAppVersion < latestAppVersion) {
      showUpdateDialog();
    } else {
      navigateToScreen();
    }
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
    });
  }

  void showUpdateDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Update Available',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: const Text(
            'A new version of the app is available. Please update to continue using the app.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: const Text(
                  'Update Now',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  String packageName = await AppUtils.getPackageName();
                  StoreRedirect.redirect(
                      androidAppId: packageName, iOSAppId: packageName);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: const SplashScreen()));
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void navigateToScreen() {
    SharedPreferences.getInstance().then((prefs) {
      final bool hasSeenOnboarding =
          prefs.getBool('hasSeenOnboardingScreen') ?? false;

      if (hasSeenOnboarding) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingOne()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 30),
            child: Column(
              children: [
                // Inside the build method of your SplashScreen class
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/N.png',
                      width: 100, // Adjust width as needed
                      height: 100, // Adjust height as needed
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      'assets/images/L.png',
                      width: 100, // Adjust width as needed
                      height: 70, // Adjust height as needed
                      fit: BoxFit.contain,
                    ),
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Stack(
                        children: [
                          // White outline
                          GlowText(
                            'Night Light',
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'SpaceGrotesk-Regular.ttf',
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth =
                                    5.0 // Adjust the stroke width as needed
                                ..color = const Color(0xFF00FF00),
                            ),
                          ),
                          // Solid text
                          const Text(
                            'Night Light',
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'SpaceGrotesk-Regular.ttf',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/images/masksplash.png', // Replace 'your_image.png' with the actual asset image path
              width: double.infinity, // Take up full width of the screen
              height: 550, // Adjust height as needed
              fit: BoxFit
                  .cover, // Maintain aspect ratio and cover the entire space
            ),
          ),
        ],
      ),
    );
  }
}
