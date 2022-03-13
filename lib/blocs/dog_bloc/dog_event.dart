part of 'dog_bloc.dart';

abstract class DogEvent extends Equatable {
  const DogEvent();

  @override
  List<Object> get props => [];
}

class GetDogList extends DogEvent {}
