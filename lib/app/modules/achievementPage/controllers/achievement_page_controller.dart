import 'package:game_database/app/data/models/archievement.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:game_database/app/data/constant/utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AchievementPageController extends GetxController {
  List<ArchievementGame> archievement = [];
  final GameModels models = Get.arguments;
  String? nextArchivment = '';
  final PagingController<int, ArchievementGame> gameAchievement =
      PagingController<int, ArchievementGame>(firstPageKey: 1);
  var noMoreItems = false.obs;
  void checkNoMoreItems(bool isLast) {
    if (isLast == true) {
      noMoreItems.value = true;
    } else {
      noMoreItems.value = false;
    }
  }

  // ! Archievement Series
  void archievementGame(int page) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games/${models.id}/achievements?key=$apikey&page=$page');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => ArchievementGame.fromJson(e)).toList();
      List<ArchievementGame> achieveData = List<ArchievementGame>.from(data);
      print("page key genre achieve : $page");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        gameAchievement.appendLastPage(achieveData);
        checkNoMoreItems(true);
      } else {
        gameAchievement.appendPage(achieveData, page + 1);
        checkNoMoreItems(false);
      }
    } catch (e) {
      gameAchievement.error = e;
    }
  }

  @override
  void onInit() {
    super.onInit();
    gameAchievement.addPageRequestListener((pageKey) {
      archievementGame(pageKey);
    });
  }

  @override
  void dispose() {
    super.dispose();
    gameAchievement.dispose();
  }
}
