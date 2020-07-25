import '../../domain/usecases/approach_usecases.dart';

class SettingsController {
  Future<String> export() async {
    return await ExportAllApproachesJson().call();
  }

  Future<int> import() async {
    return await ImportApproachesJson().call();
  }
}
