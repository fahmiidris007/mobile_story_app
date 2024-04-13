import 'package:flutter/material.dart';
import 'package:mobile_story_app/model/story/list/story_list.dart';
import 'package:mobile_story_app/screen/story/detail/detail_page.dart';
import 'package:mobile_story_app/screen/story/list/widget/image_builder.dart';

class CardStory extends StatelessWidget {
  final ListStory listStory;

  const CardStory({super.key, required this.listStory});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: ImageBuilder(listStory: listStory),
        title: Text(listStory.name),
        subtitle: Text(listStory.description),
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName,
              arguments: listStory.id);
        },
      ),
    );
  }
}