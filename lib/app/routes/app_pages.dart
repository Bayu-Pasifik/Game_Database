import 'package:get/get.dart';

import '../modules/Load_More/bindings/load_more_binding.dart';
import '../modules/Load_More/views/load_more_view.dart';
import '../modules/Search/bindings/search_binding.dart';
import '../modules/Search/views/search_view.dart';
import '../modules/achievementPage/bindings/achievement_page_binding.dart';
import '../modules/achievementPage/views/achievement_page_view.dart';
import '../modules/detail_game/bindings/detail_game_binding.dart';
import '../modules/detail_game/views/detail_game_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/similarPage/bindings/similar_page_binding.dart';
import '../modules/similarPage/views/similar_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      transition: Transition.upToDown,
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_GAME,
      page: () => const DetailGameView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
      binding: DetailGameBinding(),
    ),
    GetPage(
      name: _Paths.LOAD_MORE,
      transition: Transition.circularReveal,
      transitionDuration: const Duration(seconds: 1),
      page: () => const LoadMoreView(),
      binding: LoadMoreBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.ACHIEVEMENT_PAGE,
      page: () => const AchievementPageView(),
      binding: AchievementPageBinding(),
    ),
    GetPage(
      name: _Paths.SIMILAR_PAGE,
      page: () => const SimilarPageView(),
      binding: SimilarPageBinding(),
    ),
  ];
}
