import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArPage extends ConsumerWidget {
  const ArPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR'),
        actions: const [
          Icon(Icons.ios_share, size: 40),
        ],
      ),
      body: const Center(),
    );
  }
}
