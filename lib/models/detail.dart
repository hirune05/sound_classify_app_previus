import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail.freezed.dart';

@freezed
class Detail with _$Detail {
  const Detail._();
  const factory Detail({
    @Default({}) Map<String, double> sounds,
  }) = _Detail;
}
