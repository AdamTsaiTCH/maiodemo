import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/photo_model.dart';
import 'fetcher.dart';

final photoProvider = FutureProvider.autoDispose<List<PhotoModel>>((ref) async {
  final fetcher = ref.read(apiFetchProvider);
  final cancelToken = CancelToken();
  final rst = await fetcher.get('/photos', cancelToken: cancelToken);
  final photos = (rst.data as List).map((data) {
    return PhotoModel.fromJson(data);
  }).toList();

  return photos;
});
