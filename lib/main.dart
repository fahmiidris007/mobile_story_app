import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_story_app/data/api/api_service.dart';
import 'package:mobile_story_app/provider/authentication_provider.dart';
import 'package:mobile_story_app/provider/story_detail_provider.dart';
import 'package:mobile_story_app/provider/story_list_provider.dart';
import 'package:mobile_story_app/screen/Authentication/login/login_page.dart';
import 'package:mobile_story_app/screen/Authentication/register/register_page.dart';
import 'package:mobile_story_app/screen/home/home_page.dart';
import 'package:mobile_story_app/screen/story/detail/detail_page.dart';
import 'package:mobile_story_app/screen/story/list/list_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider(
            apiServices: ApiServices(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => StoryListProvider(
            apiServices: ApiServices(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => StoryDetailProvider(
          apiServices: ApiServices(),
        )),
      ],
      child: MaterialApp(
        title: 'Mobile Story App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/list': (context) => const ListPage(),
          '/home': (context) => HomePage(),
          '/detail': (context) => DetailPage(
            id: ModalRoute.of(context)?.settings.arguments as String,
          ),
        },
      ),
    );
  }
}
