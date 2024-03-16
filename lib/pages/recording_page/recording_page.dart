import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sound_classify_app/controllers/recording_page_controller.dart';

class RecordingPage extends ConsumerWidget {
  const RecordingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MaterialButton(
            onPressed: ref.read(recordingProvider.notifier).analyseSound,
            color: ref.watch(recordingProvider).recording
                ? Colors.grey
                : Colors.pink,
            textColor: Colors.white,
            child: Icon(Icons.mic, size: 60),
            shape: CircleBorder(),
            padding: EdgeInsets.all(25),
          ),
          Text(
            ref.watch(recordingProvider).text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          ref.watch(recordingProvider).isRecordingCompleted
              ? ElevatedButton(
                  onPressed: () => context.go('/home/ar'),
                  child: const Text('ARで見る'),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
