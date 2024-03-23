import 'package:freezed_annotation/freezed_annotation.dart';

part 'register.g.dart';
part 'register.freezed.dart';

@freezed
class Register with _$Register {
  const factory Register({
    required bool error,
    required String message,
  }) = _Register;

  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);
}
