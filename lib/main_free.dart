import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:mobile_story_app/main.dart';

void main() {
  FlavorConfig(
    name: "FREE",
    color: Colors.red,
    variables: {
      "canAddLocation": false,
    },
  );
  runApp(const MyApp());
}
