import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nightlight/BottomNav/CustomBottomBar.dart';
import 'package:nightlight/Customizeanimations/animation1.dart';
import 'package:nightlight/Customizeanimations/animation10.dart';
import 'package:nightlight/Customizeanimations/animation11.dart';
import 'package:nightlight/Customizeanimations/animation12.dart';
import 'package:nightlight/Customizeanimations/animation13.dart';
import 'package:nightlight/Customizeanimations/animation14.dart';
import 'package:nightlight/Customizeanimations/animation15.dart';
import 'package:nightlight/Customizeanimations/animation16.dart';
import 'package:nightlight/Customizeanimations/animation2.dart';
import 'package:nightlight/Customizeanimations/animation3.dart';
import 'package:nightlight/Customizeanimations/animation4.dart';
import 'package:nightlight/Customizeanimations/animation5.dart';
import 'package:nightlight/Customizeanimations/animation6.dart';
import 'package:nightlight/Customizeanimations/animation7.dart';
import 'package:nightlight/Customizeanimations/animation8.dart';
import 'package:nightlight/Customizeanimations/animation9.dart';
import 'package:nightlight/ResultScreen/FinalResult.dart';
import 'package:screen_brightness/screen_brightness.dart';

class CustomThemeScreen extends StatefulWidget {
  const CustomThemeScreen({super.key});

  @override
  _CustomThemeScreenState createState() => _CustomThemeScreenState();
}

class _CustomThemeScreenState extends State<CustomThemeScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final PageController _pageController = PageController();
  int visit = 0;
  int tappedColorIndex = -1;
  double _timerValue = 1.0;
  bool loadingAudio = false;
  List<bool> loadingStates = [];
  Widget selectedScreen = Container();
  File? pickedFile;
  double brightnessValue = 1.0;
  String? selectedAudioPath;
  double selectedBrightness = 1.0;

  final List<String> listViewImages = [
    'style1.jpeg',
    'style2.jpeg',
    'style3.jpeg',
    'style4.jpeg',
    'style5.jpeg',
    'style6.jpeg',
    'style7.jpeg',
    'style8.jpeg',
    'style9.jpeg',
    'style10.jpeg',
    'style11.jpeg',
    'style12.jpeg',
    'style13.jpeg',
    'style14.jpeg',
    'style15.jpeg',
    'style16.jpeg',
  ];

  final List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.cyan,
    Colors.pink,
    Colors.teal,
    Colors.amber,
    Colors.indigo,
    Colors.brown,
    Colors.lime,
    Colors.deepOrange,
    Colors.lightGreen,
    Colors.deepPurple,
    Colors.amberAccent,
    Colors.lightBlue,
    Colors.deepOrangeAccent,
    Colors.blueGrey,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.yellowAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.cyanAccent,
    Colors.pinkAccent,
    Colors.tealAccent,
    Colors.amberAccent,
    Colors.indigoAccent,
    Colors.brown,
    Colors.limeAccent,
    Colors.deepOrangeAccent,
    Colors.lightGreenAccent,
    Colors.deepPurpleAccent,
    Colors.amberAccent,
    Colors.lightBlueAccent,
    Colors.deepOrangeAccent,
    Colors.blueGrey,
  ];

  final List<String> audioPaths = [
    'https://github.com/IT-Wing-Technologies/Ali-Repository/raw/main/baby.mp3',
    'https://github.com/IT-Wing-Technologies/Ali-Repository/raw/main/drive.mp3',
    'https://github.com/IT-Wing-Technologies/Ali-Repository/raw/main/paris.mp3',
    'https://github.com/IT-Wing-Technologies/Ali-Repository/raw/main/science.mp3',
    'https://github.com/IT-Wing-Technologies/Ali-Repository/raw/main/titanium.mp3',
  ];

  final List<String> listViewMusicImages = [
    'music1.jpeg',
    'music2.jpeg',
    'music3.jpg',
    'music4.jpg',
    'music5.jpg',
  ];

  final List<Widget> screens = [
    const Screen1(selectedColor: Colors.red),
    const MyAnimatedBackground(selectedColor: Colors.red),
    const BubbleLensFour(),
    const Screen4(selectedColor: Colors.yellow),
    const BallAnimation5(),
    const Screen6(selectedColor: Colors.orange),
    const Screen7(),
    const Screen8(),
    const Screen9(selectedColor: Colors.red),
    const Screen10(),
    const Screen11(selectedColor: Colors.red),
    const Screen12(),
    const Screen13(),
    const Screen14(),
    const Screen15(),
    const Screen16(),
  ];

  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  int selectedAudioIndex = -1;

  @override
  void initState() {
    super.initState();
    loadingStates = List.generate(audioPaths.length, (index) => false);
    // Inside your initState method, add this listener to handle audio playback
    _assetsAudioPlayer.playlistAudioFinished.listen((finished) {
      if (finished == true) {
        setState(() {
          selectedAudioIndex = -1;
        });
      }
    });
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
      setState(() {
        selectedBrightness = brightness;
      });
    } catch (e) {
      debugPrint(e.toString());
      throw 'Failed to set brightness';
    }
  }

  Widget buildImagesListView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
      scrollDirection: Axis.horizontal,
      itemCount: listViewImages.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              tappedColorIndex = index;
            });
            _pageController.jumpToPage(index);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
              left: 8,
              top: 25,
              bottom: 25,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: tappedColorIndex == index
                        ? const Color(
                            0xFF00FF00) // Set red border for the selected container
                        : Colors.white,
                    width: tappedColorIndex == index ? 4.0 : 2.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/${listViewImages[index]}',
                    fit: BoxFit.fill,
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildColorsListView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
      scrollDirection: Axis.horizontal,
      itemCount: colorList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              // Update the tapped index
              tappedColorIndex = index;
            });
            List<Color> selectedColors = [
              colorList[(index + 0) % colorList.length],
              colorList[(index + 1) % colorList.length],
              colorList[(index + 2) % colorList.length],
            ];
            screens[0] = Screen1(selectedColor: colorList[index]);
            screens[1] = MyAnimatedBackground(selectedColor: colorList[index]);
            screens[2] = BubbleLensFour(selectedColors: selectedColors);
            screens[3] = Screen4(selectedColor: colorList[index]);
            screens[4] = BallAnimation5(selectedColors: selectedColors);
            screens[5] = Screen6(selectedColor: colorList[index]);
            screens[8] = Screen9(selectedColor: colorList[index]);

            screens[11] = Screen11(selectedColor: colorList[index]);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
              left: 8,
              top: 25,
              bottom: 25,
            ),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: tappedColorIndex == index
                      ? const Color(0xFF00FF00)
                      : Colors.white,
                  width: tappedColorIndex == index ? 4.0 : 2.0,
                ),
                color: colorList[index],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSlider() {
    if (_timerValue == 0.0) {
      // If the user has not set a timer, consider it as 1 minute
      setState(() {
        _timerValue = 1.0;
      });
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Timer",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          '${_timerValue.toInt()} Mins',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        ),
        const SizedBox(height: 10.0),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 10.0,
            trackShape: const RoundedRectSliderTrackShape(),
            activeTrackColor: const Color(0xFF00FF00),
            inactiveTrackColor: Colors.grey,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 14.0,
              pressedElevation: 8.0,
            ),
            thumbColor: Colors.white,
            overlayColor: const Color(0xFF00FF00),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 32.0),
            tickMarkShape: const RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: Colors.white,
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.black,
            valueIndicatorTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          child: Slider(
            min: 0.0,
            max: 30.0,
            divisions: 30,
            value: _timerValue ?? 1.0,
            onChanged: (value) {
              setState(() {
                _timerValue = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildMusicListView() {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
      scrollDirection: Axis.horizontal,
      children: [
        GestureDetector(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.audio,
            );

            if (result != null) {
              pickedFile = File(result.files.single.path!);
              print('Picked audio file and Stored: ${pickedFile!.path}');

              setState(() {
                selectedAudioPath = pickedFile!.path;
                selectedAudioIndex = -1;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
              left: 8,
              top: 25,
              bottom: 25,
            ),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/addmusic.png',
                  fit: BoxFit.contain,
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        for (int index = 0; index < audioPaths.length; index++)
          GestureDetector(
            onTap: () async {
              pickedFile =
                  null; // Reset pickedFile when selecting an audio from the list

              setState(() {
                selectedAudioPath = audioPaths[index];
                selectedAudioIndex = index;
                // Set loading state for the selected index to true
                loadingStates[index] = true;
              });

              _assetsAudioPlayer.open(
                Audio.network(selectedAudioPath!),
                autoStart: true,
                showNotification: true,
              );

              _assetsAudioPlayer.isPlaying.listen((bool isPlaying) {
                if (isPlaying) {
                  setState(() {
                    // Set loading state for the selected index to false
                    loadingStates[index] = false;
                  });
                }
              });
            },
            onDoubleTap: () {
              _assetsAudioPlayer.stop();
              setState(() => selectedAudioIndex = -1);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 8,
                top: 25,
                bottom: 25,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: selectedAudioIndex == index
                          ? const Color(0xFF00FF00)
                          : Colors.white,
                      width: 2.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/${listViewMusicImages[index]}',
                          fit: BoxFit.fill,
                          height: 50,
                          width: 50,
                        ),
                        if (loadingStates[index])
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LoadingAnimationWidget.discreteCircle(
                              color: Colors.lightBlue,
                              size: 30,
                              secondRingColor: Colors.yellow,
                              thirdRingColor: Colors.redAccent,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildBrightnessSlider() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Brightness",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Icon for low brightness
            const Icon(
              Icons.brightness_low,
              color: Colors.grey,
            ),

            Icon(
              Icons.brightness_high,
              color: brightnessValue >= 0.5 ? Colors.yellow : Colors.grey,
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 10.0,
            trackShape: const RoundedRectSliderTrackShape(),
            activeTrackColor:
                brightnessValue >= 0.5 ? Colors.yellow : Colors.grey,
            inactiveTrackColor: Colors.grey,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 14.0,
              pressedElevation: 8.0,
            ),
            thumbColor: Colors.white,
            overlayColor: brightnessValue >= 0.5 ? Colors.yellow : Colors.grey,
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 32.0),
            tickMarkShape: const RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: Colors.white,
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.black,
            valueIndicatorTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          child: Slider(
            min: 0.0,
            max: 1.0,
            value: brightnessValue,
            onChanged: (value) {
              setState(() {
                brightnessValue = value;
                setBrightness(value);
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey, // Add this line
      home: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: BottomNavigationBarWidget(
          visit: visit,
          onTap: (int index) {
            setState(() {
              visit = index;
            });
          },
        ),
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                'assets/images/allscreen.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 450,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: screens.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              width: 350,
                              height: 450,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                              child: screens[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: screenWidth * 1,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      border: const Border(
                        top: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: visit == 0
                        ? buildImagesListView()
                        : visit == 2
                            ? buildSlider()
                            : visit == 3
                                ? buildMusicListView()
                                : visit ==
                                        4 // Check if the fifth tab is selected
                                    ? selectedScreen = buildBrightnessSlider()
                                    : buildColorsListView(),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              color: Colors.black.withOpacity(0.8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 00),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: const CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.transparent,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.arrow_back_ios_new,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 270),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: TextButton(
                                onPressed: () {
                                  if (_timerValue <= 0.0) {
                                    // Show toast message if timer is not set
                                    Fluttertoast.showToast(
                                      msg: "Please set a valid timer value",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else if (selectedAudioPath == null) {
                                    // Show toast message if no audio is selected
                                    Fluttertoast.showToast(
                                      msg: "Please select an audio file",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FinalResultScreen(
                                          selectedScreen: screens[
                                              _pageController.page!.round()],
                                          timerValue: _timerValue,
                                          selectedBrightness:
                                              selectedBrightness,
                                          selectedAudioPath:
                                              selectedAudioPath!, // Pass the selected audio path
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  "Apply",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}
