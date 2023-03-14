import 'package:get/get.dart';

import '../modules/Load_More/bindings/load_more_binding.dart';
import '../modules/Load_More/views/load_more_view.dart';
import '../modules/detail_game/bindings/detail_game_binding.dart';
import '../modules/detail_game/views/detail_game_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_GAME,
      page: () => const DetailGameView(),
      binding: DetailGameBinding(),
    ),
    GetPage(
      name: _Paths.LOAD_MORE,
      page: () => const LoadMoreView(),
      binding: LoadMoreBinding(),
    ),
  ];
}
