part of 'detail_dog_bloc.dart';

abstract class DogState extends Equatable {
  const DogState();

  @override
  List<Object?> get props => [];
}

class DogInitial extends DogState {}

class DogLoading extends DogState {}

class DogLoaded extends DogState {
  final DogModel dogModel;
  const DogLoaded(this.dogModel);
}

class DogError extends DogState {
  final String? message;
  const DogError(this.message);
}