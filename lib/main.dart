import 'package:flutter/material.dart';
import 'package:mobile_story_app/data/api/api_service.dart';
import 'package:mobile_story_app/provider/add_story_provider.dart';
import 'package:mobile_story_app/provider/authentication_provider.dart';
import 'package:mobile_story_app/provider/story_detail_provider.dart';
import 'package:mobile_story_app/provider/story_list_provider.dart';
import 'package:mobile_story_app/utils/router.dart';
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
        ChangeNotifierProvider(
          create: (context) => StoryDetailProvider(
            apiServices: ApiServices(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AddStoryProvider(
            apiServices: ApiServices(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Mobile Story App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
