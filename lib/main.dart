import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite_audio/tflite_audio.dart';
import 'dart:convert'; // JSON文字列を扱うために必要

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _sound = "Press the button to start";
  bool _recording = false;
  late Stream<Map<dynamic, dynamic>> result;

  @override
  void initState() {
    super.initState();
    TfliteAudio.loadModel(
      model: 'assets/soundclassifier.tflite',
      label: 'assets/labels.txt',
      outputRawScores: true, // Rawスコアを出力する
      numThreads: 1,
      isAsset: true,
      inputType: 'rawAudio',
    );
  }

  void _recorder() {
    if (!_recording) {
      setState(() => _recording = true);
      result = TfliteAudio.startAudioRecognition(
        numOfInferences: 1,
        sampleRate: 44100,
        bufferSize: 22016,
      );
      result.listen((event) async {
        // ラベルリストを非同期で取得
        final labels = await fetchLabelList();
        // recognitionResultからスコアのリストを取得
        final rawScores = json.decode(event["recognitionResult"]);
        List<double> scores = List<double>.from(rawScores);

        // スコアをパーセント表示に変換し、それぞれのラベルと結合する
        String recognitionResults = "";
        for (int i = 0; i < scores.length; i++) {
          recognitionResults +=
              "${labels[i]}: ${(scores[i] * 100).toStringAsFixed(2)}%\n";
        }

        setState(() {
          _recording = false;
          _sound = recognitionResults;
        });
      });
    }
  }

  Future<List<String>> fetchLabelList() async {
    final labelData = await rootBundle.loadString('assets/labels.txt');
    return LineSplitter().convert(labelData);
  }

  void _stop() {
    TfliteAudio.stopAudioRecognition();
    setState(() {
      _recording = false;
      _sound = "Press the button to start";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
              ),
              MaterialButton(
                onPressed: _recorder,
                color: _recording ? Colors.grey : Colors.pink,
                textColor: Colors.white,
                child: Icon(Icons.mic, size: 60),
                shape: CircleBorder(),
                padding: EdgeInsets.all(25),
              ),
              Text(
                _sound,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
