import 'package:flutter/material.dart';

class HearingPage extends StatelessWidget {
  const HearingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聞いて体験'),
      ),
      body: const Center(
        child: Text('音声解析ページ'),
      ),
    );
  }
}
