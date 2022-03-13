import 'package:api_fetch_app/resources/api_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:api_fetch_app/models/dog_model.dart';

part 'detail_dog_event.dart';

part 'detail_dog_state.dart';

class DetailDogBloc extends Bloc<DogEvent, DogState> {
  final DogModel dogModel;

  DetailDogBloc(this.dogModel) : super(DogInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetDogPhoto>((event, emit) async {
      try {
        emit(DogLoading());
        final mResult = await _apiRepository.fetDogWithPicture(dogModel);
        emit(DogLoaded(mResult));
        if (mResult == null) {
          emit(const DogError("ERROR"));
        }
      } on NetworkError {
        emit(const DogError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
