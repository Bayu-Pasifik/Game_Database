import 'package:game_database/app/data/models/game_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoadMoreController extends GetxController {
  List<dynamic> action = [];
  String? next = '';
  var hal = 1.obs;
  var isGrid = false.obs;
  RefreshController refreshController = RefreshController(initialRefresh: true);
  // ! action Series
  String apikey = "7a395681502b437d8cbc489ebee68c6c";
  Future<List<dynamic>> loadMore(String genre, int page) async {
    Uri url = Uri.parse(
        'https://api.rawg.io/api/games?key=$apikey&genres=$genre&page=$page');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    next = json.decode(response.body)["next"];
    print(url);
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    var seen = <dynamic>{};
    action = tempdata.where((element) => seen.add(element)).toList();
    return action;
  }

  void changeGrid() {
    isGrid.value = true;
    update();
  }

  void changeList() {
    isGrid.value = false;
    update();
  }

  void refreshData(String genres) async {
    if (refreshController.initialRefresh == true) {
      hal.value = 1;
      await loadMore(genres, hal.value);
      update();
      return refreshController.refreshCompleted();
    } else {
      return refreshController.refreshFailed();
    }
  }

  void loadData(String genres) async {
    if (next != null) {
      hal.value = hal.value + 1;
      await loadMore(genres, hal.value);
      update();
      return refreshController.loadComplete();
    } else {
      return refreshController.loadNoData();
    }
  }
}
