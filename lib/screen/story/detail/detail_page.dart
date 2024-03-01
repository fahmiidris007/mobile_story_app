import 'package:flutter/material.dart';
import 'package:mobile_story_app/provider/story_detail_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail';
  final String id;

  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<StoryDetailProvider>().fetchStoryDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryDetailProvider>(builder: (context, state, _) {
      return Scaffold(
        body: _buildBody(state),
      );
    });
  }

  Widget _buildBody(StoryDetailProvider state) {
    if (state.state == ResultState.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.state == ResultState.hasData) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Image.network(state.result.story.photoUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                state.result.story.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                state.result.story.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (state.state == ResultState.noData) {
      return Center(
        child: Material(
          child: Text(state.message),
        ),
      );
    } else if (state.state == ResultState.error) {
      return Center(
        child: Material(
          child: Text(state.message),
        ),
      );
    } else {
      return const Center(
          child: Text('Something went wrong! Please try again later.'));
    }
  }
}
