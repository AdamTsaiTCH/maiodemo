import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoView extends StatelessWidget {

  const PhotoView({
    Key? key,
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  }) : super(key: key);

  final int id;
  final String title;
  final String thumbnailUrl;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(thumbnailUrl),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                id.toString(),
                style: const TextStyle(
                    color: Colors.white, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                title.replaceAll('', '\u200B'),
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
