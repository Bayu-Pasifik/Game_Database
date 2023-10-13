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
  // ! Archievement Series
  Future<List<ArchievementGame>> archievementGame(int page) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games/${models.id}/achievements?key=$apikey&page=$page');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => ArchievementGame.fromJson(e)).toList();
      List<ArchievementGame> achieveData = List<ArchievementGame>.from(data);
      archievement.addAll(achieveData);
      print("page key genre action$page");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        gameAchievement.appendLastPage(achieveData);
      } else {
        gameAchievement.appendPage(achieveData, page + 1);
      }
    } catch (e) {
      gameAchievement.error = e;
    }
    return archievement;
  }

  @override
  void onInit() {
    super.onInit();
    gameAchievement.addPageRequestListener((pageKey) {
      archievementGame(pageKey);
    });
  }
}
