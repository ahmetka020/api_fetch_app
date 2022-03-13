class DogModel {
  String? name;
  List<String>? subSpecies;
  String? image;
  String? error;

  DogModel({
    this.name,
    this.subSpecies,
    this.error,
    this.image,
  });

  DogModel.withError(String errorMessage) {
    error = errorMessage;
  }
}
