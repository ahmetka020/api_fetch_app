// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../models/dog_model.dart' as _i5;
import '../ui/detail_screen.dart' as _i2;
import '../ui/list_screen.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    ListScreenRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ListScreen());
    },
    DetailScreenRoute.name: (routeData) {
      final args = routeData.argsAs<DetailScreenRouteArgs>();
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.DetailScreen(key: args.key, dogModel: args.dogModel));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(ListScreenRoute.name, path: '/'),
        _i3.RouteConfig(DetailScreenRoute.name, path: '/detail-screen')
      ];
}

/// generated route for
/// [_i1.ListScreen]
class ListScreenRoute extends _i3.PageRouteInfo<void> {
  const ListScreenRoute() : super(ListScreenRoute.name, path: '/');

  static const String name = 'ListScreenRoute';
}

/// generated route for
/// [_i2.DetailScreen]
class DetailScreenRoute extends _i3.PageRouteInfo<DetailScreenRouteArgs> {
  DetailScreenRoute({_i4.Key? key, required _i5.DogModel dogModel})
      : super(DetailScreenRoute.name,
            path: '/detail-screen',
            args: DetailScreenRouteArgs(key: key, dogModel: dogModel));

  static const String name = 'DetailScreenRoute';
}

class DetailScreenRouteArgs {
  const DetailScreenRouteArgs({this.key, required this.dogModel});

  final _i4.Key? key;

  final _i5.DogModel dogModel;

  @override
  String toString() {
    return 'DetailScreenRouteArgs{key: $key, dogModel: $dogModel}';
  }
}
