import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sound_classify_app/controllers/hearing_page_controller.dart';
import 'package:sound_classify_app/controllers/recording_page_controller.dart';
import 'package:sound_classify_app/thems/app_colors.dart';

class HearingPage extends ConsumerWidget {
  const HearingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聞いて体験'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildRecordButton(ref),
              Text('録音を始める'),
              buildReplayButton(
                  ref: ref,
                  label: const Text('拡張前', style: TextStyle(fontSize: 20)),
                  filename: 'assets/sounds/sample.mp3'),
              buildReplayButton(
                  ref: ref,
                  label: const Text('拡張後', style: TextStyle(fontSize: 20)),
                  filename: 'assets/sounds/amplication.mp3'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRecordButton(WidgetRef ref) {
    return MaterialButton(
      onPressed: ref.read(recordingProvider.notifier).analyseSound,
      color: ref.watch(recordingProvider).recording
          ? AppColors.gray
          : AppColors.green,
      textColor: Colors.white,
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(25),
      child: const Icon(Icons.mic, size: 60),
    );
  }

  Widget buildReplayButton({
    required WidgetRef ref,
    required Text label,
    required String filename,
  }) {
    return Center(
        child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40, bottom: 20),
          child: label,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.play_arrow,
                size: 40,
              ),
              onPressed: () =>
                  ref.read(hearingProvider.notifier).playSoundFile(filename),
            ),
          ],
        ),
      ],
    ));
  }
}
