part of 'dog_bloc.dart';

abstract class DogState extends Equatable {
  const DogState();

  @override
  List<Object?> get props => [];
}

class DogInitial extends DogState {}

class DogLoading extends DogState {}

class DogLoaded extends DogState {
  final List<DogModel> dogModels;
  const DogLoaded(this.dogModels);
}

class DogError extends DogState {
  final String? message;
  const DogError(this.message);
}