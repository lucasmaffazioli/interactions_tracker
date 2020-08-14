import '../../domain/usecases/interaction_usecases.dart';

class SettingsController {
  Future<String> export() async {
    return await ExportAllInteractionsJson().call();
  }

  Future<int> import() async {
    return await ImportInteractionsJson().call();
  }
}
