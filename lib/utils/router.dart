import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_story_app/screen/authentication/login/login_page.dart';
import 'package:mobile_story_app/screen/authentication/register/register_page.dart';
import 'package:mobile_story_app/screen/home/home_page.dart';
import 'package:mobile_story_app/screen/story/add/add_story_page.dart';
import 'package:mobile_story_app/screen/story/detail/detail_page.dart';
import 'package:mobile_story_app/screen/story/list/list_page.dart';
import 'package:mobile_story_app/screen/story/maps/maps_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: 'register',
            name: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
        ]),
    GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => HomePage(),
        routes: [
          GoRoute(
            path: 'list',
            name: 'list',
            builder: (context, state) => const ListPage(),
          ),
          GoRoute(
            path: 'detail/:id',
            name: 'detail',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return DetailPage(id: id!);
            },
          ),
          GoRoute(
              path: 'add',
              name: 'add',
              builder: (context, state) => const AddStoryPage(),
              routes: [
                GoRoute(
                    path: 'maps',
                    name: 'maps',
                    builder: (context, state) {
                      return const MapsPage();
                    }),
              ]),
        ]),
  ],
  errorPageBuilder: (context, state) {
    return MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('Route not found: ${state.uri}'),
        ),
      ),
    );
  },
  initialLocation: '/',
  debugLogDiagnostics: true,
);
