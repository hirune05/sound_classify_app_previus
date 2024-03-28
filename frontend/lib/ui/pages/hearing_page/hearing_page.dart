import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class HearingPage extends StatefulWidget {
  const HearingPage({super.key});
  @override
  _AudioRecorderExampleState createState() => _AudioRecorderExampleState();
}

class _AudioRecorderExampleState extends State<HearingPage> {

  FlutterSound flutterSound = FlutterSound();
  bool isRecording = false;
  @override
  void initState() {
    super.initState();
    _initAudioRecording();
  }

  Future<void> _initAudioRecording() async {
    // 録音の権限を要求
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      // 許可されなかった場合の処理
      return;
    }
    FlutterSoundRecorder flutterSound = FlutterSoundRecorder();
    try {
      await flutterSound.openRecorder();
    } catch (err) {
      print('Error opening audio session: $err');
    }
  }
  Future<void> startRecording() async {
    // 録音の権限を要求
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      // 許可されなかった場合の処理
      return;
    }
     final recordingPath = '../../../../assets/audio/recoding.m4a';
     FlutterSoundRecorder flutterSound = FlutterSoundRecorder();
      try {
      await flutterSound.startRecorder(
        toFile: recordingPath,
        codec: Codec.aacADTS,
      );

      setState(() {
        isRecording = true;
      });

      // 5秒後に録音を停止する
      await Future.delayed(Duration(seconds: 5));
      await stopRecording();
    } catch (err) {
      // エラー処理
      print('startRecording error: $err');
    }
  }

    Future<void> stopRecording() async {
      FlutterSoundRecorder flutterSound = FlutterSoundRecorder();
    try {
      await flutterSound.stopRecorder();
      setState(() {
        isRecording = false;
      });
    } catch (err) {
      // エラー処理
      print('stopRecording error: $err');
    }
  }




  Future<void> playAudio() async {
    final audioPlayer = AudioPlayer();
    audioPlayer.play(AssetSource('audio/sample.m4a'));
  }
    
  

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聞いて体験'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isRecording ? null : startRecording,
              child: Text(
                isRecording ? 'Recording...' : '録音をはじめる',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Colors.green; // Use the component's default.
                  },
                ),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                minimumSize: MaterialStateProperty.all<Size>(Size(80, 80)),
                shadowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return states.contains(MaterialState.pressed) ? Colors.transparent : Colors.black; // Use the component's default.
                  },
                ),
                elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                    return states.contains(MaterialState.pressed) ? 0 : 10; // Shadow when not pressed.
                  },
                ),
              ),
            ),
            SizedBox(height: 150),
            ElevatedButton(
              onPressed: playAudio,
              child: Text(
                '再生する',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Colors.green; // Use the component's default.
                  },
                ),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                minimumSize: MaterialStateProperty.all<Size>(Size(80, 80)),
                shadowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return states.contains(MaterialState.pressed) ? Colors.transparent : Colors.black; // Use the component's default.
                  },
                ),
                elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                    return states.contains(MaterialState.pressed) ? 0 : 10; // Shadow when not pressed.
                  },
                ),
              ),
            ),
          ],

        ),
      )

    );
  }
}
