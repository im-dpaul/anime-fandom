import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ExploreRepository {
  Future downloadImage({required String path, bool? save}) async {
    try {
      Dio dio = Dio();
      String filePath;
      if (save != null && save) {
        final name = DateTime.now().millisecondsSinceEpoch;
        filePath = '/storage/emulated/0/Download/image-$name.jpg';
      } else {
        var dir = await getApplicationDocumentsDirectory();
        filePath = '${dir.path}/image.jpg';
      }
      log('File Name in path = $filePath');
      final response = await dio.download(
        path,
        filePath,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return filePath;
      }
    } catch (e) {
      log('Exception -> $e', name: 'ExploreRepository downloadImage()');
    }
  }
}
