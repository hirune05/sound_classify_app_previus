import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
part 'hearing_page_controller.freezed.dart';

@freezed
class HearingState with _$HearingState {
  const factory HearingState() = _HearingState;
}

final hearingProvider = StateNotifierProvider<HearingController, HearingState>(
  (ref) => HearingController(),
);

class HearingController extends StateNotifier<HearingState> {
  late AudioPlayer _player;
  HearingController() : super(const HearingState()) {
    _init();
  }

  void _init() {
    _setupSession();
  }

  Future<void> _setupSession() async {
    _player = AudioPlayer();
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    await _loadAudioFile('assets/sounds/aftersample.m4a');
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> playSoundFile(String filename) async {
    // 再生終了状態の場合、新たなオーディオファイルを定義し再生できる状態にする
    if (_player.processingState == ProcessingState.completed) {
      await _loadAudioFile(filename);
    }
    await _player.play();
  }

  Future<void> _loadAudioFile(String filename) async {
    try {
      await _player.setAsset(filename); // アセット(ローカル)のファイル
    } catch (e) {
      print(e);
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }
}
