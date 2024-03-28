import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sound_classify_app/controllers/hearing_page_controller.dart';

class HearingPage extends ConsumerWidget {
  const HearingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聞いて体験'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('アセットを再生'),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: ref.read(hearingProvider.notifier).playSoundFile,
            ),
            IconButton(
              icon: const Icon(Icons.pause),
              onPressed: ref.read(hearingProvider.notifier).pause,
            )
          ],
        ),
      ),
    );
  }
}
