import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maiotest/page/photo/photo_view.dart';
import 'package:maiotest/page/photoDB/photo_db_edit_page.dart';

import '../../core/photo_db_provider.dart';
import '../../model/photo_model.dart';

class PhotoDBPage extends ConsumerWidget {
  const PhotoDBPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final photoData = ref.watch(photoDBProvider);

    void edit(PhotoModel photo) async {
      Navigator.of(context)
          .push(
            MaterialPageRoute(
                builder: (_) => PhotoDBEditPage(
                      photo: photo,
                    )),
          )
          .whenComplete(() => ref.refresh(photoDBProvider));
    }

    return Scaffold(
        appBar: AppBar(
            title: Column(
          children: [
            Text("Local Database"),
            Text("點擊前往編輯或刪除"),
          ],
        )),
        body: photoData.when(
            data: (photoData) {
              List<PhotoModel> photoList = photoData.map((e) => e).toList();
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                ),
                itemCount: photoList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      edit(photoList[index]);
                    },
                    child: PhotoView(
                      id: photoList[index].id,
                      title: photoList[index].title,
                      thumbnailUrl: photoList[index].thumbnailUrl,
                    ),
                  );
                },
              );
            },
            error: (error, s) => Text(error.toString()),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
