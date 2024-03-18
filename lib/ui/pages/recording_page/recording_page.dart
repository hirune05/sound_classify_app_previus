import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sound_classify_app/controllers/recording_page_controller.dart';
import 'package:sound_classify_app/thems/app_colors.dart';

class RecordingPage extends ConsumerWidget {
  const RecordingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SoundFit'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: ref.read(recordingProvider.notifier).analyseSound,
              color: ref.watch(recordingProvider).recording
                  ? AppColors.gray
                  : AppColors.green,
              textColor: Colors.white,
              child: Icon(Icons.mic, size: 60),
              shape: CircleBorder(),
              padding: EdgeInsets.all(25),
            ),
            Text(
              ref.watch(recordingProvider).text,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 32),
            ),
            ref.watch(recordingProvider).isRecordingCompleted
                ? ElevatedButton(
                    onPressed: () => context.go('/home/ar'),
                    child: const Text('ARで見る'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      backgroundColor: AppColors.pink,
                      textStyle: const TextStyle(fontSize: 24),
                      fixedSize: const Size(160, 52),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
