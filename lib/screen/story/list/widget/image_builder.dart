import 'package:flutter/material.dart';
import 'package:mobile_story_app/model/story/list/story_list.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    super.key,
    required this.listStory,
  });

  final ListStory listStory;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        listStory.photoUrl,
        width: 100,
        height: 100,
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
    );
  }
}
