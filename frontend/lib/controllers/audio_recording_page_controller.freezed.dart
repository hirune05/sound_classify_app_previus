// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_recording_page_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioRecordingState {
  bool get recording => throw _privateConstructorUsedError;
  dynamic get isRecordingCompleted => throw _privateConstructorUsedError;
  dynamic get audioPath => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AudioRecordingStateCopyWith<AudioRecordingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioRecordingStateCopyWith<$Res> {
  factory $AudioRecordingStateCopyWith(
          AudioRecordingState value, $Res Function(AudioRecordingState) then) =
      _$AudioRecordingStateCopyWithImpl<$Res, AudioRecordingState>;
  @useResult
  $Res call({bool recording, dynamic isRecordingCompleted, dynamic audioPath});
}

/// @nodoc
class _$AudioRecordingStateCopyWithImpl<$Res, $Val extends AudioRecordingState>
    implements $AudioRecordingStateCopyWith<$Res> {
  _$AudioRecordingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recording = null,
    Object? isRecordingCompleted = freezed,
    Object? audioPath = freezed,
  }) {
    return _then(_value.copyWith(
      recording: null == recording
          ? _value.recording
          : recording // ignore: cast_nullable_to_non_nullable
              as bool,
      isRecordingCompleted: freezed == isRecordingCompleted
          ? _value.isRecordingCompleted
          : isRecordingCompleted // ignore: cast_nullable_to_non_nullable
              as dynamic,
      audioPath: freezed == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioRecordingStateImplCopyWith<$Res>
    implements $AudioRecordingStateCopyWith<$Res> {
  factory _$$AudioRecordingStateImplCopyWith(_$AudioRecordingStateImpl value,
          $Res Function(_$AudioRecordingStateImpl) then) =
      __$$AudioRecordingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool recording, dynamic isRecordingCompleted, dynamic audioPath});
}

/// @nodoc
class __$$AudioRecordingStateImplCopyWithImpl<$Res>
    extends _$AudioRecordingStateCopyWithImpl<$Res, _$AudioRecordingStateImpl>
    implements _$$AudioRecordingStateImplCopyWith<$Res> {
  __$$AudioRecordingStateImplCopyWithImpl(_$AudioRecordingStateImpl _value,
      $Res Function(_$AudioRecordingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recording = null,
    Object? isRecordingCompleted = freezed,
    Object? audioPath = freezed,
  }) {
    return _then(_$AudioRecordingStateImpl(
      recording: null == recording
          ? _value.recording
          : recording // ignore: cast_nullable_to_non_nullable
              as bool,
      isRecordingCompleted: freezed == isRecordingCompleted
          ? _value.isRecordingCompleted!
          : isRecordingCompleted,
      audioPath: freezed == audioPath ? _value.audioPath! : audioPath,
    ));
  }
}

/// @nodoc

class _$AudioRecordingStateImpl implements _AudioRecordingState {
  const _$AudioRecordingStateImpl(
      {this.recording = false,
      this.isRecordingCompleted = false,
      this.audioPath = ''});

  @override
  @JsonKey()
  final bool recording;
  @override
  @JsonKey()
  final dynamic isRecordingCompleted;
  @override
  @JsonKey()
  final dynamic audioPath;

  @override
  String toString() {
    return 'AudioRecordingState(recording: $recording, isRecordingCompleted: $isRecordingCompleted, audioPath: $audioPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioRecordingStateImpl &&
            (identical(other.recording, recording) ||
                other.recording == recording) &&
            const DeepCollectionEquality()
                .equals(other.isRecordingCompleted, isRecordingCompleted) &&
            const DeepCollectionEquality().equals(other.audioPath, audioPath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      recording,
      const DeepCollectionEquality().hash(isRecordingCompleted),
      const DeepCollectionEquality().hash(audioPath));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioRecordingStateImplCopyWith<_$AudioRecordingStateImpl> get copyWith =>
      __$$AudioRecordingStateImplCopyWithImpl<_$AudioRecordingStateImpl>(
          this, _$identity);
}

abstract class _AudioRecordingState implements AudioRecordingState {
  const factory _AudioRecordingState(
      {final bool recording,
      final dynamic isRecordingCompleted,
      final dynamic audioPath}) = _$AudioRecordingStateImpl;

  @override
  bool get recording;
  @override
  dynamic get isRecordingCompleted;
  @override
  dynamic get audioPath;
  @override
  @JsonKey(ignore: true)
  _$$AudioRecordingStateImplCopyWith<_$AudioRecordingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
