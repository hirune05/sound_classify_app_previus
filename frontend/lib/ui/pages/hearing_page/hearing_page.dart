import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sound_classify_app/controllers/audio_recording_page_controller.dart';
import 'package:sound_classify_app/thems/app_colors.dart';

class HearingPage extends ConsumerWidget {
  final audioPlayer = AudioPlayer();
  bool isRecordingButtonDisabled = false;
  Timer? _timer;

  Future<void> playAudio() async {
    final audioPlayer = AudioPlayer();
    audioPlayer.play(AssetSource('audio/aftersample.m4a'));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isRecording = ref.watch(audioRecordingProvider).recording;

    return Scaffold(
      appBar: AppBar(
        title: const Text('聞いて体験'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '録音をはじめる',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
                color: AppColors.secondaryText,
              ),
            ),
            MaterialButton(
              onPressed: isRecording
                  ? null
                  : () => ref
                      .read(audioRecordingProvider.notifier)
                      .startRecording(),
              color: isRecordingButtonDisabled ? Colors.grey : AppColors.green,
              textColor: Colors.white,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(25),
              child: const Icon(Icons.mic, size: 40),
            ),
            if (!isRecording &&
                ref.watch(audioRecordingProvider).audioPath != '')
              ElevatedButton(
                  onPressed:
                      ref.read(audioRecordingProvider.notifier).playRecording,
                  child: const Text('再生する')),
            const Icon(
              Icons.arrow_drop_down,
              size: 60,
              color: AppColors.secondaryText,
            ),
            if (!isRecording &&
                ref.watch(audioRecordingProvider).audioPath != '')
              ElevatedButton(
                  onPressed:
                      ref.read(audioRecordingProvider.notifier).uploadAudioFile,
                  child: const Text('アップロードする')),
            if (!isRecording &&
                ref.watch(audioRecordingProvider).audioPath != '')
              ElevatedButton(
                  onPressed: ref
                      .read(audioRecordingProvider.notifier)
                      .downloadAndPlayAudioFile,
                  child: const Text('ダウンロードして聴く')),
            const Text(
              '聴覚過敏の聞こえ方',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: AppColors.secondaryText,
              ),
            ),
            const Icon(
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
            const Text(
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
