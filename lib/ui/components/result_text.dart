import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sound_classify_app/controllers/recording_page_controller.dart';

class ResultText extends ConsumerWidget {
  const ResultText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      ref.watch(recordingProvider).text,
      textAlign: TextAlign.left,
      style: const TextStyle(fontSize: 32),
    );
  }
}
