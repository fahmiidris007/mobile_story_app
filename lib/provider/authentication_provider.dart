import 'package:flutter/material.dart';
import 'package:mobile_story_app/data/api/api_service.dart';
import 'package:mobile_story_app/model/Authentication/login/login.dart';
import 'package:mobile_story_app/model/Authentication/register/register.dart';

enum ResultState { Loading, Success, Error }

class AuthenticationProvider extends ChangeNotifier{
  late final ApiServices apiServices;

  AuthenticationProvider({required this.apiServices});

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
      _state = ResultState.Loading;
      notifyListeners();
      _login = await apiServices.login(email, password);
      if (_login.error) {
        _state = ResultState.Error;
        _message = _login.message;
      } else {
        _state = ResultState.Success;
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Login failed, please try again later';
    }
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      _register = await apiServices.register(name, email, password);
      if (_register.error) {
        _state = ResultState.Error;
        _message = _register.message;
      } else {
        _state = ResultState.Success;
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Register failed, please try again later';
    }
    notifyListeners();
  }
}