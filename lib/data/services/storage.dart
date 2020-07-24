import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Storage {
  // Future<String> saveFile(String fileName, String content) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   File file = File('${directory.path}/$fileName.txt');
  //   file = await file.writeAsString('$content');
  //   return file.path;
  // }

  Future<String> saveExternalFile(String fileName, String content) async {
    final directory = await getExternalStorageDirectory();
    File file = File('${directory.path}/$fileName');
    file = await file.writeAsString('$content');
    return file.path;
  }
}
