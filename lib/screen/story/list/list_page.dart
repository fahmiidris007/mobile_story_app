import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/list';

  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('List Page'),
      ),
    );
  }
}
