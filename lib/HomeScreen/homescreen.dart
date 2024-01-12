import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nightlight/Customthemescreen/Customthemescreen.dart';
import 'package:nightlight/DefaultScreen/defaultscreen.dart';
import 'package:nightlight/Drawer/drawer.dart';
import 'package:nightlight/Rating/show_rating_dialog.dart';
import 'package:page_transition/page_transition.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  bool isLoading = false;

  void _showLoadingAnimation() => setState(() => isLoading = true);

  void _hideLoadingAnimation() => setState(() => isLoading = false);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        RatingDialogManager.showRatingDialog(context);
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          foregroundColor: Colors.white,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const MyDrawer(),
        body: Stack(
          children: [
            // Background Image
            SizedBox.expand(
              child: Image.asset(
                'assets/images/homescreen.png', // Replace with your image asset
                fit: BoxFit.fill,
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Center(
                child: Column(
                  children: [
                    _buildElevatedButton(
                        'Custom Theme',
                        const CustomThemeScreen(),
                        PageTransitionType.leftToRight,
                        duration: const Duration(milliseconds: 500)),
                    const SizedBox(height: 16),
                    _buildElevatedButton('Default Theme',
                        const MyDefaultScreen(), PageTransitionType.leftToRight,
                        duration: const Duration(milliseconds: 500)),
                    const SizedBox(height: 50),
                    isLoading
                        ? LoadingAnimationWidget.discreteCircle(
                            color: Colors.lightBlue,
                            size: 30,
                            secondRingColor: Colors.yellow,
                            thirdRingColor: Colors.redAccent)
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildElevatedButton(
      String text, Widget destination, PageTransitionType transitionType,
      {required Duration duration}) {
    return ElevatedButton(
      onPressed: () {
        _showLoadingAnimation();
        // Simulate some async task
        Future.delayed(const Duration(seconds: 2), () {
          _hideLoadingAnimation();
          Navigator.push(
            context,
            PageTransition(
              type: transitionType,
              child: destination,
              duration: duration,
            ),
          );
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: Colors.white, width: 2.0),
      ),
      child: Text(
        text,
        style: const TextStyle(fontFamily: 'Poppins-Regular.ttf', fontSize: 19),
      ),
    );
  }
}
