import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation1.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation10.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation11.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation12.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation13.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation14.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation15.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation16.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation2.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation3.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation4.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation5.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation6.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation7.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation8.dart';
import 'package:nightlight/DefaultAnimations/defaultanimation9.dart';
import 'package:nightlight/ResultScreen/DefulatFinalResult.dart';

class ScreenModel {
  final String screenName;
  final Widget screenWidget;

  ScreenModel(this.screenName, this.screenWidget);
}

class MyDefaultScreen extends StatefulWidget {
  const MyDefaultScreen({super.key});

  @override
  _MyDefaultScreenState createState() => _MyDefaultScreenState();
}

class _MyDefaultScreenState extends State<MyDefaultScreen> {
  List<bool> isSelectedList = List.generate(16, (index) => false);
  late final List<Function()> onTapFunctions;
  ScreenModel? selectedScreenModel;
  String? selectedAudioPath;
  bool isMusicPlaying = false;
  bool loadingAudio = false;
  List<bool> loadingStates = [];
  _MyDefaultScreenState() {
    onTapFunctions = List.generate(16, (index) {
      return () {
        // Do something when tapped, you can add your logic here.
        print('Tapped on item $index');
      };
    });
  }

  final List<String> imagePaths =
      List.generate(16, (index) => 'style${index + 1}.jpeg');

  final List<String> listViewImages = [
    'music1.jpeg',
    'music2.jpeg',
    'music3.jpg',
    'music4.jpg',
    'music5.jpg'
  ];

  final List<String> audioPaths = [
    'https://github.com/IT-Wing-Technologies/Ali-Repository/raw/main/baby.mp3',
    'https://github.com/IT-Wing-Technologies/Ali-Repository/raw/main/drive.mp3',
    'https://github.com/IT-Wing-Technologies/Ali-Repository/raw/main/paris.mp3',
    'https://github.com/IT-Wing-Technologies/Ali-Repository/raw/main/science.mp3',
    'https://github.com/IT-Wing-Technologies/Ali-Repository/raw/main/titanium.mp3',
  ];

  void _navigateToScreen(String animationscreen, int index) {
    final screens = {
      'Screen 1': ScreenModel('Screen 1', const Screen1('Screen 1')),
      'Screen 2':
          ScreenModel('Screen 2', const MyAnimatedBackground('Screen 2')),
      'Screen 3': ScreenModel('Screen 3', const BubbleLensFour('Screen 3')),
      'Screen 4': ScreenModel('Screen 4', const Screen4('Screen 4')),
      'Screen 5': ScreenModel('Screen 5', const BallAnimation5('Screen 5')),
      'Screen 6': ScreenModel('Screen 6', const Screen6('Screen 6')),
      'Screen 7': ScreenModel('Screen 7', const Screen7('Screen 7')),
      'Screen 8': ScreenModel('Screen 8', const Screen8('Screen 8')),
      'Screen 9': ScreenModel(
          'Screen 9', const DefScreen9('Screen 9', selectedColor: Colors.red)),
      'Screen 10': ScreenModel('Screen 10', const Screen10('Screen 10')),
      'Screen 11': ScreenModel('Screen 11', const Screen11('Screen 11')),
      'Screen 12': ScreenModel('Screen 12', const Screen12('Screen 12')),
      'Screen 13': ScreenModel('Screen 13', const Screen13('Screen 13')),
      'Screen 14': ScreenModel('Screen 14', const Screen14('Screen 14')),
      'Screen 15': ScreenModel('Screen 15', const Screen15('Screen 15')),
      'Screen 16': ScreenModel('Screen 16', const Screen16('Screen 16')),
    };

    final screenModel = screens[animationscreen];
    if (screenModel != null) {
      setState(() {
        selectedScreenModel = screenModel;
      });
    }
  }

  int tappedIndex = -1;

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

  void showLoadingIndicator(int index) {
    setState(() {
      tappedIndex = index; // Update tapped index
    });
  }

  void showLoadingAnimation(int index) {
    setState(() {
      tappedIndex = index; // Update tapped index
    });
  }

  String _getAudioTitle(int index) {
    final audioTitles = ['Baby', 'Drive', 'Paris', 'Science', 'Titanium'];
    if (index >= 0 && index < audioTitles.length) {
      return audioTitles[index];
    } else {
      return 'Unknown Title';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/allscreen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 100, 20, 80),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  onTapFunctions[index].call();
                  _navigateToScreen('Screen ${index + 1}', index);
                  setState(() {
                    // Deselect all items in the list
                    for (int i = 0; i < isSelectedList.length; i++) {
                      isSelectedList[i] = false;
                    }
                    // Select the tapped item
                    isSelectedList[index] = true;
                  });
                },
                child: GridTile(
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                      // Use isSelectedList to determine border color
                      border: Border.all(
                        color: isSelectedList[index]
                            ? const Color(0xFF00FF00)
                            : Colors.white,
                        width: isSelectedList[index] ? 4.0 : 2.0,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/${imagePaths[index]}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 700.sp),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          color: Colors.black.withOpacity(0.8),
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10),
                            scrollDirection: Axis.horizontal,
                            itemCount: audioPaths.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
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

                                  _assetsAudioPlayer.isPlaying
                                      .listen((bool isPlaying) {
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
                                      right: 8.0, left: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: selectedAudioIndex == index
                                              ? const Color(
                                                  0xFF00FF00) // Green color when condition is met
                                              : Colors
                                                  .white, // White color when condition is not met
                                          width: selectedAudioIndex == index
                                              ? 4.0
                                              : 2.0, // Increase width when condition is met
                                        ),
                                      ),
                                      child: ClipRRect(
                                        
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/${listViewImages[index]}',
                                              fit: BoxFit.fill,
                                              height: 50,
                                              width: 50,
                                            ),
                                            if (loadingStates[index])
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: LoadingAnimationWidget
                                                    .discreteCircle(
                                                  color: Colors.lightBlue,
                                                  size: 30,
                                                  secondRingColor:
                                                      Colors.yellow,
                                                  thirdRingColor:
                                                      Colors.redAccent,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 130,
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
                                if (selectedScreenModel != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DefulatFinalResult(
                                        selectedScreenModel:
                                            selectedScreenModel,
                                        selectedAudioPath: selectedAudioPath,
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
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Default Theme",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter-VariableFont_slnt,wght.ttf',
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
    );
  }
}
