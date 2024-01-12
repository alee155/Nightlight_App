import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nightlight/Customthemescreen/Customthemescreen.dart';

class FinalResultScreen extends StatefulWidget {
  final Widget selectedScreen;
  final double timerValue;
  final double selectedBrightness;
  final String selectedAudioPath; // Add this line

  const FinalResultScreen({
    super.key,
    required this.selectedScreen,
    required this.timerValue,
    required this.selectedBrightness,
    required this.selectedAudioPath, // Add this line
  });

  @override
  _FinalResultScreenState createState() => _FinalResultScreenState();
}

class _FinalResultScreenState extends State<FinalResultScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Initialize and start playing the audio
    _initAudioPlayer(widget.selectedAudioPath);
    // Start the timer
    _startTimer();
  }

  Future<void> _initAudioPlayer(String audioPath) async {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>Audio Path: $audioPath');

    try {
      await _audioPlayer.setUrl(audioPath);
      await _audioPlayer.play();
    } catch (e) {
      print('Error initializing audio player: $e');
    }

    _audioPlayer.playerStateStream.listen((PlayerState state) {
      print('Player State: $state');

      if (state.processingState == ProcessingState.completed) {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.play();
      }
    });
  }

  Future<void> _startTimer() async {
    final endTime = DateTime.now().millisecondsSinceEpoch +
        widget.timerValue.toInt() * 60 * 1000;
    final timeDifference = endTime - DateTime.now().millisecondsSinceEpoch;

    await Future.delayed(Duration(milliseconds: timeDifference));

    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
    }

    await Future.delayed(const Duration(seconds: 1));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CustomThemeScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.selectedScreen,
          Positioned(
            top: 40,
            right: 20,
            child: CountdownTimer(
              endTime: DateTime.now().millisecondsSinceEpoch +
                  widget.timerValue.toInt() * 60 * 1000,
              textStyle: const TextStyle(fontSize: 15, color: Colors.white),
              onEnd: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomThemeScreen(),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(1 - widget.selectedBrightness),
            ),
          ),
        ],
      ),
    );
  }
}
