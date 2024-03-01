import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_story_app/model/Authentication/login/login.dart';
import 'package:mobile_story_app/model/Authentication/register/register.dart';
import 'package:mobile_story_app/model/story/list/story_list.dart';
import 'package:mobile_story_app/utils/session_manager.dart';

class ApiServices {
  static const String baseUrl = 'https://story-api.dicoding.dev/v1/';


  Future<Login> login(String email, String password) async {
    var url = Uri.parse('${baseUrl}login');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return loginFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Register> register(String name, String email, String password) async {
    var url = Uri.parse('${baseUrl}register');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'name': name,
          'email': email,
          'password': password,
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return registerFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<StoryList> getStoryList() async {
    var url = Uri.parse('${baseUrl}stories');
    var sessionManager = SessionManager();
    var token = await sessionManager.getUserToken();
    var headers = {
      'Authorization': 'Bearer $token',
    };
    print(headers);
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      print(
          'Get story list success. Status code: ${response.statusCode}, body: ${response.body}');
      return storyListFromJson(response.body);
    } else {
      print(
          'Get story list failed. Status code: ${response.statusCode}, body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }
}
