import 'dart:io';
import '../../domain/usecases/approach_usecases.dart';

import 'package:file_picker/file_picker.dart';

class SettingsController {
  Future<String> export() async {
    return await ExportAllApproachesJson().call();
  }

  import() async {
    return await ImportApproachesJson().call();

    // File file = await FilePicker.getFile(allowedExtensions: ['json'], type: FileType.custom);
    // print(file.path);
  }
}
