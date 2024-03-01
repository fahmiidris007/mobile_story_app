import 'package:flutter/material.dart';
import 'package:mobile_story_app/screen/story/list/list_page.dart';
import 'package:mobile_story_app/screen/Authentication/login/login_page.dart';
import 'package:mobile_story_app/utils/session_manager.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  final SessionManager _sessionManager = SessionManager();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _sessionManager.getUserToken(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.data != null) {
              return const ListPage();
            } else {
              return const LoginPage();
            }
          }
        }
      },
    );
  }
}