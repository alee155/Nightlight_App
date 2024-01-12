import 'package:flutter/material.dart';
import 'package:nightlight/HomeScreen/homescreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback onNext;
  final int pageIndex;
  final int activePageIndex;
  final double indicatorSize;
  final String buttonText;

  const OnboardingPage({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onNext,
    required this.pageIndex,
    required this.activePageIndex,
    this.indicatorSize = 10.0,
    this.buttonText = 'Next', // Default text for the button
  }) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 250),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('hasSeenOnboardingScreen', true);
                        bool updatedvalue =
                            prefs.getBool('hasSeenOnboardingScreen') ?? false;
                        print(
                            'hasSeenOnboardingScreen in onboarding screen $updatedvalue');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomeScreen()),
                        );
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 350,
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 40),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: widget.onNext,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF3BCC3B),
              side: const BorderSide(
                color: Colors.white, // White border for the ElevatedButton
                width: 2,
              ),
              minimumSize: const Size(150, 50),
            ),
            child: Text(
              widget.buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i <= 3; i++)
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  width: widget.indicatorSize,
                  height: widget.indicatorSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == widget.activePageIndex
                        ? const Color(0xFF3BCC3B)
                        : Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingOne extends StatefulWidget {
  const OnboardingOne({Key? key}) : super(key: key);

  @override
  _OnboardingOneState createState() => _OnboardingOneState();
}

class _OnboardingOneState extends State<OnboardingOne> {
  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      imagePath: 'assets/images/boarding1.png',
      title: 'Welcome to Night Light',
      description: 'Your personalized night time\n'
          'companion. Experience the comfort\n'
          'with our innovative app designed to\n'
          'enhance your night.',
      onNext: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const OnboardingTwo(),
          ),
        );
      },
      pageIndex: 1,
      activePageIndex: 1,
      indicatorSize: 15.0,
    );
  }
}

class OnboardingTwo extends StatefulWidget {
  const OnboardingTwo({Key? key}) : super(key: key);

  @override
  _OnboardingTwoState createState() => _OnboardingTwoState();
}

class _OnboardingTwoState extends State<OnboardingTwo> {
  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      imagePath: 'assets/images/boarding2.png',
      title: 'Customize Your Night',
      description: 'Choose from unique themes with\n'
          'adjustable sounds, colors, shapes\n'
          'and timers. Or relax with our default\n'
          'theme featuring serene screens and\n'
          'calming sounds.',
      onNext: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const OnboardingThree(),
          ),
        );
      },
      pageIndex: 2,
      activePageIndex: 2,
      buttonText: 'Next', // Set text for the button in OnboardingTwo
      indicatorSize: 15.0,
    );
  }
}

class OnboardingThree extends StatefulWidget {
  const OnboardingThree({Key? key}) : super(key: key);

  @override
  _OnboardingThreeState createState() => _OnboardingThreeState();
}

class _OnboardingThreeState extends State<OnboardingThree> {
  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      imagePath: 'assets/images/boarding3.png',
      title: 'Peaceful Sleep',
      description: 'Embrace the serenity of night.\n'
          'Night Light illuminating your dreams,\n'
          'calming your evenings, and guiding\n'
          'you to a peaceful sleep. ',
      onNext: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('hasSeenOnboardingScreen', true);
        bool updatedvalue = prefs.getBool('hasSeenOnboardingScreen') ?? false;
        print('hasSeenOnboardingScreen in onboarding screen $updatedvalue');
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const MyHomeScreen(),
          ),
        );
      },
      pageIndex: 3,
      activePageIndex: 3,
      buttonText: 'Start', // Set text for the button in OnboardingThree
      indicatorSize: 15.0,
    );
  }
}
