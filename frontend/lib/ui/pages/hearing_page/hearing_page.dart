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
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildReplayButton(
                  ref: ref,
                  label: const Text('目の前の人との会話。聴覚過敏だとこう聞こえる。なんと言っているか聞こえるかな？',
                      style: TextStyle(fontSize: 20)),
                  filename: 'assets/sounds/amplication.mp3'),
              buildReplayButton(
                  ref: ref,
                  label: const Text('正解は...? 聞いてみよう',
                      style: TextStyle(fontSize: 20)),
                  filename: 'assets/sounds/sample.mp3'),
            ],
          ),
        ),
      ),
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
