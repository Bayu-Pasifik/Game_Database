import 'package:game_database/app/data/constant/utils.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SimilarPageController extends GetxController {
  List<GameModels> sameGame = [];
  final GameModels models = Get.arguments;
  String? nextArchivment = '';
  var noMoreItems = false.obs;
  final PagingController<int, GameModels> similarController =
      PagingController<int, GameModels>(firstPageKey: 1);
  void checkNoMoreItems(bool isLast) {
    if (isLast == true) {
      noMoreItems.value = true;
    } else {
      noMoreItems.value = false;
    }
  }

  // ! Archievement Series
  void similarGame(int page) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games/${models.id}/game-series?key=$apikey&page=$page');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> similiar = List<GameModels>.from(data);
      // sameGame.addAll(similiar);
      print("page key similatr game = $page");
      print("panjang similiar = ${sameGame.length}");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        similarController.appendLastPage(similiar);
        checkNoMoreItems(true);
      } else {
        similarController.appendPage(similiar, page + 1);
        checkNoMoreItems(false);
      }
    } catch (e) {
      similarController.error = e;
    }
  }

  @override
  void onInit() {
    super.onInit();
    similarController.addPageRequestListener((pageKey) {
      similarGame(pageKey);
    });
  }

  @override
  void dispose() {
    super.dispose();
    similarController.dispose();
  }
}
