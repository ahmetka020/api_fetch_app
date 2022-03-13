import 'dart:convert';
import 'dart:developer';

import 'package:api_fetch_app/models/dog_model.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://dog.ceo/api/breeds/list/all';

  Future<List<DogModel>> fetchDogList() async {
    try {
      Response response = await _dio.get(_url);
      List<DogModel> dogModels = [];
      var extractedData = response.data["message"] as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        dogModels.add(DogModel(
          name: key,
          subSpecies: List<String>.from(value as List<dynamic>),
        ));
      });
      return dogModels;
    } catch (error, stacktrace) {
      log("Exception occured: $error stackTrace: $stacktrace");
      return [DogModel.withError("Data not found / Connection issue")];
    }
  }

  Future<DogModel> fetchDogWithPhoto(DogModel dogModel) async {
    final _photoUrl = 'https://dog.ceo/api/breed/${dogModel.name}/images/random';
    try {
      Response response = await _dio.get(_photoUrl);
      var extractedData = response.data["message"]?.toString();
      return DogModel(
        name: dogModel.name,
        subSpecies: dogModel.subSpecies,
        image: extractedData,
      );
    } catch(error, stacktrace) {
      log("Exception occured: $error stackTrace: $stacktrace");
      return DogModel.withError("Data not found / Connection issue");
    }
  }
}
