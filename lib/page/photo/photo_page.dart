import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maiotest/page/photo/photo_view.dart';

import '../../core/photo_provider.dart';
import '../../database/photo_db.dart';
import '../../model/photo_model.dart';

class PhotoPage extends ConsumerWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final photoData = ref.watch(photoProvider);

    void addPhotoToDB(PhotoModel photo) async {
      await PhotoDB.addTodo(photo);
      Fluttertoast.showToast(
          msg: "${photo.id} 已添加至本地資料庫",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    return Scaffold(
        appBar: AppBar(title: Column(
          children: [
            Text("Request API"),
            Text('長按加入Local Database')
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
                    onLongPress: (){
                      addPhotoToDB(photoList[index]);
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
            loading: () =>
            const Center(
              child: CircularProgressIndicator(),
            )));
  }
}
