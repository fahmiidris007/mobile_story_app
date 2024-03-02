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
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<StoryListProvider>().fetchAllStory();
    });
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
          if (state.state == ResultStateList.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultStateList.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.listStory.length,
              itemBuilder: (context, index) {
                var listStory = state.result.listStory[index];
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
            return Center(child: Text(AppLocalizations.of(context)!.errorList));
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
