import 'package:api_fetch_app/models/dog_model.dart';
import 'api_repository.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<DogModel>> fetchDogList() {
    return _provider.fetchDogList();
  }

  Future<DogModel> fetDogWithPicture(DogModel dogModel) {
    return _provider.fetchDogWithPhoto(dogModel);
  }
}

class NetworkError extends Error {}
