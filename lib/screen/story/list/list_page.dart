import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_story_app/common.dart';
import 'package:mobile_story_app/provider/authentication_provider.dart';
import 'package:mobile_story_app/provider/story_list_provider.dart';
import 'package:mobile_story_app/screen/story/list/widget/card_story.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final listProvider = context.read<StoryListProvider>();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (listProvider.pageItems != null) {
          listProvider.fetchAllStory();
        }
      }
    });
    Future.microtask(() async => listProvider.fetchAllStory());
    // Future.microtask(() {
    //   context.read<StoryListProvider>().fetchAllStory();
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<StoryListProvider>(
        builder: (context, state, _) {
          if (state.state == ResultStateList.loading && state.pageItems == 1) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultStateList.hasData) {
            final story = state.storyList;
            return ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: story.length + (state.pageItems != null ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == story.length && state.pageItems != null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                var listStory = story[index];
                return CardStory(
                  listStory: listStory,
                );
              },
            );
          } else if (state.state == ResultStateList.noData) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else if (state.state == ResultStateList.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context)!.errorList),
            );
          }
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.titleList),
      actions: [
        IconButton(
          onPressed: () {
            context.goNamed('add');
          },
          icon: const Icon(Icons.add_circle_outline),
        ),
        IconButton(
          onPressed: () {
            AppSettings.openAppSettings();
          },
          icon: const Icon(Icons.settings),
        ),
        IconButton(
          onPressed: () {
            context.read<AuthenticationProvider>().logout();
            context.goNamed('login');
          },
          icon: const Icon(Icons.logout_outlined),
        ),
      ],
    );
  }
}
