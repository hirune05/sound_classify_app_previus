// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recording_page_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecordingState {
  String get text => throw _privateConstructorUsedError;
  bool get recording => throw _privateConstructorUsedError;
  Map<String, double> get sounds =>
      throw _privateConstructorUsedError; //これを後にdetail.dartと連携
  dynamic get isRecordingCompleted => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecordingStateCopyWith<RecordingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordingStateCopyWith<$Res> {
  factory $RecordingStateCopyWith(
          RecordingState value, $Res Function(RecordingState) then) =
      _$RecordingStateCopyWithImpl<$Res, RecordingState>;
  @useResult
  $Res call(
      {String text,
      bool recording,
      Map<String, double> sounds,
      dynamic isRecordingCompleted});
}

/// @nodoc
class _$RecordingStateCopyWithImpl<$Res, $Val extends RecordingState>
    implements $RecordingStateCopyWith<$Res> {
  _$RecordingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? recording = null,
    Object? sounds = null,
    Object? isRecordingCompleted = freezed,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      recording: null == recording
          ? _value.recording
          : recording // ignore: cast_nullable_to_non_nullable
              as bool,
      sounds: null == sounds
          ? _value.sounds
          : sounds // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      isRecordingCompleted: freezed == isRecordingCompleted
          ? _value.isRecordingCompleted
          : isRecordingCompleted // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordingStateImplCopyWith<$Res>
    implements $RecordingStateCopyWith<$Res> {
  factory _$$RecordingStateImplCopyWith(_$RecordingStateImpl value,
          $Res Function(_$RecordingStateImpl) then) =
      __$$RecordingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String text,
      bool recording,
      Map<String, double> sounds,
      dynamic isRecordingCompleted});
}

/// @nodoc
class __$$RecordingStateImplCopyWithImpl<$Res>
    extends _$RecordingStateCopyWithImpl<$Res, _$RecordingStateImpl>
    implements _$$RecordingStateImplCopyWith<$Res> {
  __$$RecordingStateImplCopyWithImpl(
      _$RecordingStateImpl _value, $Res Function(_$RecordingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? recording = null,
    Object? sounds = null,
    Object? isRecordingCompleted = freezed,
  }) {
    return _then(_$RecordingStateImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      recording: null == recording
          ? _value.recording
          : recording // ignore: cast_nullable_to_non_nullable
              as bool,
      sounds: null == sounds
          ? _value._sounds
          : sounds // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      isRecordingCompleted: freezed == isRecordingCompleted
          ? _value.isRecordingCompleted!
          : isRecordingCompleted,
    ));
  }
}

/// @nodoc

class _$RecordingStateImpl implements _RecordingState {
  const _$RecordingStateImpl(
      {this.text = "Press the button to start",
      this.recording = false,
      final Map<String, double> sounds = const {},
      this.isRecordingCompleted = false})
      : _sounds = sounds;

  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey()
  final bool recording;
  final Map<String, double> _sounds;
  @override
  @JsonKey()
  Map<String, double> get sounds {
    if (_sounds is EqualUnmodifiableMapView) return _sounds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sounds);
  }

//これを後にdetail.dartと連携
  @override
  @JsonKey()
  final dynamic isRecordingCompleted;

  @override
  String toString() {
    return 'RecordingState(text: $text, recording: $recording, sounds: $sounds, isRecordingCompleted: $isRecordingCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordingStateImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.recording, recording) ||
                other.recording == recording) &&
            const DeepCollectionEquality().equals(other._sounds, _sounds) &&
            const DeepCollectionEquality()
                .equals(other.isRecordingCompleted, isRecordingCompleted));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      text,
      recording,
      const DeepCollectionEquality().hash(_sounds),
      const DeepCollectionEquality().hash(isRecordingCompleted));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordingStateImplCopyWith<_$RecordingStateImpl> get copyWith =>
      __$$RecordingStateImplCopyWithImpl<_$RecordingStateImpl>(
          this, _$identity);
}

abstract class _RecordingState implements RecordingState {
  const factory _RecordingState(
      {final String text,
      final bool recording,
      final Map<String, double> sounds,
      final dynamic isRecordingCompleted}) = _$RecordingStateImpl;

  @override
  String get text;
  @override
  bool get recording;
  @override
  Map<String, double> get sounds;
  @override //これを後にdetail.dartと連携
  dynamic get isRecordingCompleted;
  @override
  @JsonKey(ignore: true)
  _$$RecordingStateImplCopyWith<_$RecordingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
