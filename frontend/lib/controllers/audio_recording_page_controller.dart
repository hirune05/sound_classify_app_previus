import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

part 'audio_recording_page_controller.freezed.dart';

@freezed
class AudioRecordingState with _$AudioRecordingState {
  const factory AudioRecordingState({
    @Default(false) bool recording,
    @Default(false) bool isRecordingCompleted,
    @Default('') String audioPath,
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
      String? path = await audioRecord.stop();
      print('✅AudioPath: $path');
      if (path != null) {
        // "file://"スキームを削除
        final uri = Uri.parse(path);
        final correctPath = uri.toFilePath();

        // 一時ディレクトリのパスを取得
        final directory = await getTemporaryDirectory();
        final newPath = '${directory.path}/record.m4a';

        // コピー先のディレクトリを作成
        final newFile = File(newPath);
        if (!(await newFile.parent.exists())) {
          await newFile.parent.create(recursive: true);
        }

        // ファイルをコピー
        final file = File(correctPath);
        await file.copy(newPath);

        state = state.copyWith(
          recording: false,
          isRecordingCompleted: true,
          audioPath: newPath,
        );
      }
    } catch (e) {
      print('Error Stop Recording:$e');
    }
  }

  Future<void> playRecording() async {
    try {
      // ファイルの存在を確認
      final file = File(state.audioPath);
      if (await file.exists()) {
        // パーミッションを確認
        final permissions = await file.stat();
        print('File permissions: ${permissions.modeString()}');

        // AudioPlayerを再初期化
        audioPlayer = AudioPlayer();

        // ソースURLが有効か確認
        final urlSource =
            DeviceFileSource(state.audioPath); // UrlSourceをDeviceFileSourceに変更
        await audioPlayer.play(urlSource);
      } else {
        print('Error: Audio file does not exist at ${state.audioPath}');
      }
    } catch (e) {
      print('Error Play Recording:$e');
    }
  }

  // Future<void> uploadAudioFile() async {
  //   try {
  //     String filePath = state.audioPath;
  //     File file = File(filePath);
  //     FirebaseStorage storage = FirebaseStorage.instance;
  //     Reference ref = storage.ref().child('audio_files/record.m4a');
  //     UploadTask uploadTask = ref.putFile(file);
  //     await uploadTask;
  //     print('File uploaded to Firebase Storage');
  //   } catch (e) {
  //     print('Error uploading file: $e');
  //   }
  // }
}
