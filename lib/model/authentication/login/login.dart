import 'package:freezed_annotation/freezed_annotation.dart';

part 'login.g.dart';
part 'login.freezed.dart';

@freezed
class Login with _$Login {
  const factory Login({
    required bool error,
    required String message,
    @JsonKey(name: 'loginResult') required LoginResult loginResult,
  }) = _Login;

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
}

@freezed
class LoginResult with _$LoginResult {
  const factory LoginResult({
    required String userId,
    required String name,
    required String token,
  }) = _LoginResult;

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);
}
