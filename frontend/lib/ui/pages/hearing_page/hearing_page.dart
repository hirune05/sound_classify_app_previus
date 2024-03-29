import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class HearingPage extends StatefulWidget {
  const HearingPage({Key? key}) : super(key: key);
  @override
  State<HearingPage> createState() => _HearingPageState();
}

class _HearingPageState extends State<HearingPage> {
  Future<void> playAudio() async {
    final audioPlayer = AudioPlayer();
    audioPlayer.play(AssetSource('audio/sample.m4a'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('聞いて体験'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: null,
                child: Text(
                  '録音をはじめる',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.green; // Use the component's default.
                    },
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(Size(80, 80)),
                  shadowColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return states.contains(MaterialState.pressed)
                          ? Colors.transparent
                          : Colors.black; // Use the component's default.
                    },
                  ),
                  elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                      return states.contains(MaterialState.pressed)
                          ? 0
                          : 10; // Shadow when not pressed.
                    },
                  ),
                ),
              ),
              SizedBox(height: 150),
              ElevatedButton(
                onPressed: playAudio,
                child: Text(
                  '再生する',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.green; // Use the component's default.
                    },
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(Size(80, 80)),
                  shadowColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return states.contains(MaterialState.pressed)
                          ? Colors.transparent
                          : Colors.black; // Use the component's default.
                    },
                  ),
                  elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                      return states.contains(MaterialState.pressed)
                          ? 0
                          : 10; // Shadow when not pressed.
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
