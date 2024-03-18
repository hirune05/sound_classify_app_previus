import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tflite_audio/tflite_audio.dart';
part 'recording_page_controller.freezed.dart';

@freezed
class RecordingState with _$RecordingState {
  const factory RecordingState({
    @Default("Press the button to start") String text,
    @Default(false) bool recording,
    @Default({}) Map<String, double> sounds, //これを後にdetail.dartと連携
    @Default(false) isRecordingCompleted,
  }) = _RecordingState;
}

final recordingProvider =
    StateNotifierProvider<RecordingController, RecordingState>(
  (ref) => RecordingController(),
);

class RecordingController extends StateNotifier<RecordingState> {
  RecordingController() : super(const RecordingState()) {
    _init();
  }

  void _init() {
    TfliteAudio.loadModel(
      model: 'assets/soundclassifier.tflite',
      label: 'assets/labels.txt',
      outputRawScores: true, // Rawスコアを出力する
      numThreads: 1,
      isAsset: true,
      inputType: 'rawAudio',
    );
  }

  void init() {
    state = state.copyWith(
      text: "Press the button to start",
      recording: false,
      sounds: {},
      isRecordingCompleted: false,
    );
  }

  void startRecording() {
    const recording = true;
    state = state.copyWith(recording: recording);
  }

  Future<void> analyseSound() async {
    if (!state.recording) {
      startRecording();
      final sounds = TfliteAudio.startAudioRecognition(
        numOfInferences: 1,
        sampleRate: 44100,
        bufferSize: 22016,
      );
      final sound_kinds = [
        '皿の音',
        '機械音',
        '換気扇の音',
        'キーボードの音',
        '話し声',
      ];
      sounds.listen(
        (event) async {
          // ラベルリストを非同期で取得
          //final labels = await fetchLabelList();
          // recognitionResultからスコアのリストを取得
          final rawScores = json.decode(event["recognitionResult"]);
          List<double> scores = List<double>.from(rawScores);

          // スコアをパーセント表示に変換し、それぞれのラベルと結合する
          String recognitionResults = "";
          for (int i = 0; i < scores.length - 1; i++) {
            recognitionResults +=
                "${sound_kinds[i]}: ${(scores[i] * 100).toStringAsFixed(2)}%\n";
          }
          const recording = false;
          const isRecordingCompleted = true;
          state = state.copyWith(
            recording: recording,
            text: recognitionResults,
            isRecordingCompleted: isRecordingCompleted,
          );
        },
      );
    }
  }

  Future<List<String>> fetchLabelList() async {
    final labelData = await rootBundle.loadString('assets/labels.txt');
    return LineSplitter().convert(labelData);
  }

  void stopRecording() {
    TfliteAudio.stopAudioRecognition();
    const recording = false;
    const text = "Press the button to start";
    state = state.copyWith(recording: recording, text: text);
  }
}
