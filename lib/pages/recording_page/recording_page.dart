import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecordingPage extends ConsumerWidget {
  const RecordingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => context.go('/home/ar'),
            child: Text('Go to AR Page'),
          ),
          Center(
            child: Text('Recording Page'),
          ),
        ],
      ),
    );
  }
}
