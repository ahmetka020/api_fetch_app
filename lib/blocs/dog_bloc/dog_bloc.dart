import 'package:api_fetch_app/resources/api_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:api_fetch_app/models/dog_model.dart';

part 'dog_event.dart';

part 'dog_state.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  DogBloc() : super(DogInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetDogList>((event, emit) async {
      try {
        emit(DogLoading());
        final mList = await _apiRepository.fetchDogList();
        emit(DogLoaded(mList));
        if (mList.isEmpty) {
          emit(const DogError("ERROR"));
        }
      } on NetworkError {
        emit(const DogError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
