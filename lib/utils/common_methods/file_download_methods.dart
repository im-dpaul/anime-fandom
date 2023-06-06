import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloadMethods {
  static Future downloadImage({required String path, bool? save}) async {
    try {
      Dio dio = Dio();
      String filePath;
      String name = DateTime.now().millisecondsSinceEpoch.toString();
      if (save != null && save) {
        name = path.split("/")[3];
        filePath =
            '/storage/emulated/0/Download/Anime Fandom/AnimeFandom-$name.jpg';
      } else {
        var dir = await getApplicationDocumentsDirectory();
        filePath = '${dir.path}/AnimeFandom-$name.jpg';
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
      log('Exception -> $e', name: 'FileDownloadMethods downloadImage()');
    }
  }
}
