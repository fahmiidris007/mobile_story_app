import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail';

  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Story'),
      ),
      body: const Center(
        child: Text('Detail Story Page'),
      ),
    );
  }
}
