import 'package:flutter/material.dart';
import 'package:mobile_story_app/model/story/list/story_list.dart';
import 'package:mobile_story_app/provider/authentication_provider.dart';
import 'package:mobile_story_app/provider/story_list_provider.dart';
import 'package:mobile_story_app/screen/home/home_page.dart';
import 'package:mobile_story_app/screen/story/detail/detail_page.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/list';

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
      appBar: AppBar(
        title: const Text('Story List'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthenticationProvider>().logout();
              Navigator.pushNamed(context, HomePage.routeName);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Padding(
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
              return const Center(child: Text('Please try again later'));
            }
          },
        ),
      ),
    );
  }
}

class CardStory extends StatelessWidget {
  final ListStory listStory;

  const CardStory({super.key, required this.listStory});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(listStory.photoUrl),
        title: Text(listStory.name),
        subtitle: Text(listStory.description),
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName, arguments: listStory);
        },
      ),
    );
  }
}