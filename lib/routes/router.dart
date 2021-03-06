import 'package:api_fetch_app/ui/detail_screen.dart';
import 'package:api_fetch_app/ui/list_screen.dart';
import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(
  // replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: ListScreen, initial: true),
    AutoRoute(page: DetailScreen),
  ],
)
class $AppRouter {}
