import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:mobile_story_app/main.dart';

void main() {
  FlavorConfig(
    name: "PAID",
    color: Colors.green,
    variables: {
      "canAddLocation": true,
    },
  );
  runApp(const MyApp());
}
