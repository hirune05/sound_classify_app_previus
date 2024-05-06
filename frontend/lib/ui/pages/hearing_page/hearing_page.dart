import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sound_classify_app/thems/app_colors.dart';

class HearingPage extends StatefulWidget {
  const HearingPage();

  @override
  State<HearingPage> createState() => _HearingPageState();
}

class _HearingPageState extends State<HearingPage> {
  final audioPlayer = AudioPlayer();
  bool isRecordingButtonDisabled = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _handleRecordingButtonPressed() {
    setState(() {
      isRecordingButtonDisabled = true;
    });

    _timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        isRecordingButtonDisabled = false;
      });
    });
  }

  Future<void> playAudio() async {
    final audioPlayer = AudioPlayer();
    audioPlayer.play(AssetSource('audio/aftersample.m4a'));
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
            Text(
              '録音をはじめる',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
                color: AppColors.secondaryText,
              ),
            ),
            MaterialButton(
              onPressed: isRecordingButtonDisabled
                  ? null
                  : _handleRecordingButtonPressed,
              color: isRecordingButtonDisabled ? Colors.grey : AppColors.green,
              textColor: Colors.white,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(25),
              child: const Icon(Icons.mic, size: 40),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 60,
              color: AppColors.secondaryText,
            ),
            Text(
              '聴覚過敏の聞こえ方',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: AppColors.secondaryText,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 60,
              color: AppColors.secondaryText,
            ),
            MaterialButton(
              onPressed: playAudio,
              color: AppColors.green,
              textColor: Colors.white,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(25),
              child: const Icon(Icons.mic, size: 40),
            ),
            Text(
              '再生する',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
