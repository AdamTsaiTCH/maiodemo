import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maiotest/database/photo_db.dart';

import '../model/photo_model.dart';

final photoDBProvider = FutureProvider.autoDispose<List<PhotoModel>>((ref) async {
  final rst = await PhotoDB.getPhotos();
  return rst;
});