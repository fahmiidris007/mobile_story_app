import 'package:http/http.dart' as http;
import 'package:mobile_story_app/model/Authentication/login/login.dart';
import 'package:mobile_story_app/model/Authentication/register/register.dart';

class ApiServices {
  static const String baseUrl = 'https://story-api.dicoding.dev/v1/';

  Future<Login> login(String email, String password) async {
    var url = Uri.parse('${baseUrl}login');
    var response = await http.post(url, headers: {
      'Content-Type': 'application/json',
    }, body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      print('Login success. Status code: ${response.statusCode}, body: ${response.body}');
      return loginFromJson(response.body);
    } else {
      print('Login failed. Status code: ${response.statusCode}, body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  Future<Register> register(String name, String email, String password) async {
    var url = Uri.parse('${baseUrl}register');
    var response = await http.post(url, headers: {
      'Content-Type': 'application/json',
    }, body: {
      'name': name,
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      print('Register success. Status code: ${response.statusCode}, body: ${response.body}');
      return registerFromJson(response.body);
    } else {
      print('Register failed. Status code: ${response.statusCode}, body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }
}
