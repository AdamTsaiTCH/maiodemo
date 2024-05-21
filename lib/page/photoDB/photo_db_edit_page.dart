import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/photo_db.dart';
import '../../model/photo_model.dart';

final titleProvider = StateProvider<String>((ref) => '');

class PhotoDBEditPage extends ConsumerWidget {
  PhotoDBEditPage({
    Key? key,
    required this.photo,
  }) : super(key: key);

  PhotoModel photo;

  @override
  Widget build(BuildContext context, ref) {
    final formKey = GlobalKey<FormState>();

    Widget recordRow(String title, String value) {
      return Row(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.blue),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 30),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Title or Delete')),
      body:
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                recordRow('ID: ', photo.id.toString()),
                recordRow('Album Id: ', photo.albumId.toString()),
                recordRow('Url: ', photo.url),
                recordRow('Thumbnail Url: ', photo.thumbnailUrl),
                const Divider(color: Colors.white),
                TextFormField(
                  initialValue: photo.title,
                  onChanged: (text) => {
                    ref.read(titleProvider.notifier).update((state) => text),
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(labelText: '請輸入Title'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.white))),
                  onPressed: () async {
                    await PhotoDB.deletephoto(photo.id);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '刪除',
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.white))),
                  onPressed: () async {
                    await PhotoDB.updatePhoto(photo.copyWith(
                        title: ref.read(titleProvider.notifier).state));
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '儲存',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
