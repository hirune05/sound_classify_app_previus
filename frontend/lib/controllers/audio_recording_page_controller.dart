import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record/record.dart';
import 'package:sound_classify_app/models/detail.dart';
import 'package:tflite_audio/tflite_audio.dart';
import 'package:geolocator/geolocator.dart';
part 'audio_recording_page_controller.freezed.dart';

@freezed
class AudioRecordingState with _$AudioRecordingState {
  const factory AudioRecordingState({
    @Default(false) bool recording,
    @Default(false) isRecordingCompleted,
    @Default('') audioPath,
  }) = _AudioRecordingState;
}

final audioRecordingProvider =
    StateNotifierProvider<AudioRecordingController, AudioRecordingState>(
  (ref) => AudioRecordingController(),
);

class AudioRecordingController extends StateNotifier<AudioRecordingState> {
  AudioRecordingController() : super(const AudioRecordingState()) {
    _init();
  }

  late Record audioRecord;
  late AudioPlayer audioPlayer;

  Timer? _timer;

  void _init() {
    audioPlayer = AudioPlayer();
    audioRecord = Record();
    state = state.copyWith(
      recording: false,
      isRecordingCompleted: false,
    );
  }

  void init() {
    state = state.copyWith(
      recording: false,
      isRecordingCompleted: false,
    );
  }

  void startRecording() async {
    const recording = true;
    state = state.copyWith(recording: recording);
    try {
      if (await audioRecord.hasPermission()) {
        // Start recording to file
        await audioRecord.start();
        _timer = Timer(const Duration(seconds: 3), () {
          stopRecording();
        });
      }
    } catch (e) {
      print('Error Start Recording:$e');
    }
  }

  void stopRecording() async {
    try {
      print('✅AudioPath: ${state.audioPath}');
      String? path = await audioRecord.stop();
      state = state.copyWith(
        recording: false,
        isRecordingCompleted: true,
        audioPath: path,
      );
    } catch (e) {
      print('Error Stop Recording:$e');
    }
    // const recording = false;
    // state = state.copyWith(
    //   recording: recording,
    // );
    // await record.stop();
  }

  Future<void> playRecording() async {
    try {
      Source urlSource = UrlSource(state.audioPath);
      await audioPlayer.play(urlSource);
    } catch (e) {
      print('Error Play Recording:$e');
    }
  }
}
