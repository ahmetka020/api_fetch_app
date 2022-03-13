import 'package:api_fetch_app/blocs/detail_dog_bloc/detail_dog_bloc.dart';
import 'package:api_fetch_app/models/dog_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_screen.dart';

class DetailScreen extends StatefulWidget {
  final DogModel dogModel;

  const DetailScreen({
    Key? key,
    required this.dogModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailDogBloc _detailDogBloc;

  @override
  void initState() {
    _detailDogBloc = DetailDogBloc(widget.dogModel);
    _detailDogBloc.add(GetDogPhoto());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detay Sayfası"),
      ),
      body: _buildDetail(),
    );
  }

  Widget _buildDetail() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _detailDogBloc,
        child: BlocListener<DetailDogBloc, DogState>(
          listener: (context, state) {
            if (state is DogError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<DetailDogBloc, DogState>(
            builder: (context, state) {
              if (state is DogInitial) {
                return buildLoading();
              } else if (state is DogLoading) {
                return buildLoading();
              } else if (state is DogLoaded) {
                return _buildDetailPage(state.dogModel);
              } else if (state is DogError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailPage(DogModel dogModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          dogModel.image!,
          height: MediaQuery.of(context).size.height * .4,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
        ),
        Text("Köpek Türü : ${dogModel.name}\n"),
        Container(
          height: MediaQuery.of(context).size.height * .4,
          child: _subSpecies(dogModel),
        ),
      ],
    );
  }

  Widget _subSpecies(DogModel dogModel) {
    if (dogModel.subSpecies!.isEmpty) {
      return const Text("Alt türü yok.");
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Alt Türleri:"),
          for (var species in dogModel.subSpecies!) Text("-> $species"),
        ],
      );
    }
  }
}
