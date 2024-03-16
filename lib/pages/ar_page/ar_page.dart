import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArPage extends ConsumerWidget {
  const ArPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('POP'),
          ),
          const Center(
            child: Text('AR Page'),
          ),
        ],
      ),
    );
  }
}
