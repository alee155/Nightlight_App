import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nightlight/DefaultScreen/defaultscreen.dart';

class DefulatFinalResult extends StatefulWidget {
  final ScreenModel? selectedScreenModel;
  final String? selectedAudioPath; // Add this line

  const DefulatFinalResult({
    super.key,
    this.selectedScreenModel,
    this.selectedAudioPath,
  });

  @override
  _DefulatFinalResultState createState() => _DefulatFinalResultState();
}

class _DefulatFinalResultState extends State<DefulatFinalResult> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playAudio();
  }

  void _playAudio() async {
    if (widget.selectedAudioPath != null) {
      Fluttertoast.showToast(
        msg: "Music is about here..",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      await _audioPlayer.setUrl(widget.selectedAudioPath!);
      await _audioPlayer.play();

      Fluttertoast.cancel(); // Dismiss the toast after music starts playing
    }
  }

  Future<bool> _onWillPop() async {
    await _audioPlayer
        .stop(); // Stop the audio player when the screen is popped
    return true; // Return true to confirm that the screen should be popped
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: widget.selectedScreenModel?.screenWidget ?? Container(),
      ),
    );
  }
}
