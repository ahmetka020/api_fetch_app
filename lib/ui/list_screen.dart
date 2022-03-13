import 'dart:developer';
import 'package:api_fetch_app/blocs/dog_bloc/dog_bloc.dart';
import 'package:api_fetch_app/models/dog_model.dart';
import 'package:api_fetch_app/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_similarity/string_similarity.dart';
import 'dart:math' as m;

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late DogBloc _dogBloc;

  late TextEditingController _textEditingController;

  late List<DogModel> _dogList;
  late List<DogModel> _resultDogList;

  late bool _notFound;

  @override
  void initState() {
    _notFound = false;
    _dogList = [];
    _resultDogList = [];
    _dogBloc = DogBloc();
    _textEditingController = TextEditingController();
    _dogBloc.add(GetDogList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Köpek Türleri")),
      body: _buildListDog(),
    );
  }

  Widget _buildListDog() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _dogBloc,
        child: BlocListener<DogBloc, DogState>(
          listener: (context, state) {
            if (state is DogError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<DogBloc, DogState>(
            builder: (context, state) {
              if (state is DogInitial) {
                return buildLoading();
              } else if (state is DogLoading) {
                return buildLoading();
              } else if (state is DogLoaded) {
                _dogList = state.dogModels;
                if (_resultDogList.isEmpty && !_notFound) {
                  _resultDogList.addAll(_dogList);
                }
                return _buildCard(context);
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

  Widget _textBox(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .08,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: _textEditingController,
        onChanged: _search,
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _textBox(context),
          _notFound
              ? const Center(
                  child: Text("Aramanıza uygun sonuç bulunamadı."),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _resultDogList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _onTap(_resultDogList[index]),
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text("Adı: ${_resultDogList[index].name!}", style: const TextStyle(fontSize: 18)),
                                      const Spacer(),
                                      const Icon(Icons.chevron_right, size: 20)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void _search(String searchText) {
    setState(() {
      _resultDogList.clear();
      _notFound = true;
      if (searchText.isEmpty) {
        _resultDogList.addAll(_dogList);
        _notFound = false;
      } else {
        for (var element in _dogList) {
          if (element.name!.toUpperCase().contains(searchText.toUpperCase())) {
            _notFound = false;
            _resultDogList.add(element);
          }
        }
      }
    });
  }

  void _onTap(DogModel dogModel) {
    AutoRouter.of(context).push(
      DetailScreenRoute(dogModel: dogModel),
    );
  }

  int levenshtein(String s, String t, {bool caseSensitive: true}) {
    if (!caseSensitive) {
      s = s.toLowerCase();
      t = t.toLowerCase();
    }
    if (s == t) {
      return 0;
    }
    if (s.isEmpty) {
      return t.length;
    }
    if (t.isEmpty) {
      return s.length;
    }

    List<int> v0 = List<int>.filled(t.length + 1, 0);
    List<int> v1 = List<int>.filled(t.length + 1, 0);

    for (int i = 0; i < t.length + 1; i < i++) {
      v0[i] = i;
    }

    for (int i = 0; i < s.length; i++) {
      v1[0] = i + 1;

      for (int j = 0; j < t.length; j++) {
        int cost = (s[i] == t[j]) ? 0 : 1;
        v1[j + 1] = m.min(v1[j] + 1, m.min(v0[j + 1] + 1, v0[j] + cost));
      }

      for (int j = 0; j < t.length + 1; j++) {
        v0[j] = v1[j];
      }
    }

    return v1[t.length];
  }
}

Widget buildLoading() => const Center(child: CircularProgressIndicator());
