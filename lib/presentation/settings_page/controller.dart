import 'dart:io';
import '../../domain/usecases/approach_usecases.dart';

import 'package:file_picker/file_picker.dart';

class SettingsController {
  export() async {
    // File file;

    GetAllApproachesJson().call();
  }

  import() async {
    File file = await FilePicker.getFile(allowedExtensions: ['json'], type: FileType.custom);
    print(file.path);
  }
}
