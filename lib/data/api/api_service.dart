import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_story_app/model/authentication/login/login.dart';
import 'package:mobile_story_app/model/authentication/register/register.dart';
import 'package:mobile_story_app/model/story/add/add_story.dart';
import 'package:mobile_story_app/model/story/detail/story_detail.dart';
import 'package:mobile_story_app/model/story/list/story_list.dart';
import 'package:mobile_story_app/utils/session_manager.dart';

class ApiServices {
  static const String baseUrl = 'https://story-api.dicoding.dev/v1/';
  var sessionManager = SessionManager();

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
      return Login.fromJson(jsonDecode(response.body));
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
      return Register.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<StoryList> getStoryList([int page = 1, int size = 10]) async {
    var url = Uri.parse('${baseUrl}stories?page=$page&size=$size');
    var token = await sessionManager.getUserToken();
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final listResponse = StoryList.fromJson(jsonDecode(response.body));
      return listResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<StoryDetail> getStoryDetail(String id) async {
    var url = Uri.parse('${baseUrl}stories/$id');
    var token = await sessionManager.getUserToken();
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return StoryDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<AddStory> postStory(
      String description, List<int> photo, double lat, double lon) async {
    var url = Uri.parse('${baseUrl}stories');
    var token = await sessionManager.getUserToken();
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['description'] = description
      ..files.add(
        http.MultipartFile.fromBytes(
          'photo',
          photo,
          filename: 'photo.jpg',
        ),
      )
      ..fields['lat'] = lat.toString()
      ..fields['lon'] = lon.toString();
    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return AddStory.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
