import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

class HearingPage extends StatefulWidget {
  const HearingPage({Key? key}) : super(key: key);

  @override
  State<HearingPage> createState() => _HearingPageState();
}

class _HearingPageState extends State<HearingPage> {
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _startPlaying();
  }

  @override
  void dispose() {
    audioPlayer.release();
    super.dispose();
  }

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

  // 再生開始
  Future<void> _startPlaying() async {
    // 再生開始
    await audioPlayer.play('aftersample.m4a');
  }

}
