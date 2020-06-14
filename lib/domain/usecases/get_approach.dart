// Isto aqui NÃO CONHECE o banco de dados
import 'package:cold_app/data/services/local_datastore.dart';
import 'package:cold_app/domain/entities/approach/approach.dart';

class GetApproach {
  Future<Approach> call(String uid) {
    return LocalDatastore().getApproach(uid);
  }
}
