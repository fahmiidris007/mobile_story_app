import 'package:flutter/material.dart';
import 'package:mobile_story_app/data/api/api_service.dart';
import 'package:mobile_story_app/model/Authentication/login/login.dart';
import 'package:mobile_story_app/model/Authentication/register/register.dart';
import 'package:mobile_story_app/utils/session_manager.dart';

enum ResultState { loading, success, error }

class AuthenticationProvider extends ChangeNotifier {
  late final ApiServices apiServices;
  bool isLoading = false;

  AuthenticationProvider({required this.apiServices});

  final SessionManager _sessionManager = SessionManager();
  late ResultState _state;
  String _message = '';
  late Login _login;
  late Register _register;

  ResultState get state => _state;

  String get message => _message;

  Login get resultLogin => _login;

  Register get resultRegister => _register;

  Future<void> login(String email, String password) async {
    try {
      _state = ResultState.loading;
      isLoading = true;
      notifyListeners();
      _login = await apiServices.login(email, password);
      if (_login.error) {
        _state = ResultState.error;
        _message = _login.message;
      } else {
        isLoading = false;
        _state = ResultState.success;
        await _sessionManager.setUserToken(_login.loginResult.token);
      }
    } catch (e) {
      isLoading = false;
      _state = ResultState.error;
      _message = 'Network Error, Please try again';
    }
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    try {
      _state = ResultState.loading;
      isLoading = true;
      notifyListeners();
      _register = await apiServices.register(name, email, password);
      if (_register.error) {
        _state = ResultState.error;
        isLoading = false;
        _message = _register.message;
      } else {
        isLoading = false;
        _state = ResultState.success;
      }
    } catch (e) {
      isLoading = false;
      _state = ResultState.error;
      _message = 'Network Error, Please try again';
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _sessionManager.clearUserToken();
  }
}
