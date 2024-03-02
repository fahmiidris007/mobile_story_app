import 'package:flutter/material.dart';
import 'package:mobile_story_app/common.dart';
import 'package:mobile_story_app/provider/story_detail_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
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
        appBar:AppBar(
          title:  Text(AppLocalizations.of(context)!.detailTitle),
        ),
        body: _buildBody(state),
      );
    });
  }

  Widget _buildBody(StoryDetailProvider state) {
    if (state.state == ResultState.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.state == ResultState.hasData) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    state.result.story.photoUrl,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                    scale: 2.0,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      );
                    },
                  ),
                ),
              ),
              Text(
                state.result.story.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.result.story.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
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
      return Center(
          child: Text(AppLocalizations.of(context)!.errorDescription));
    }
  }
}
