import 'package:game_database/app/data/models/detail_game.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/data/models/screenshot_game.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailGameController extends GetxController {
  RefreshController sameRefresh = RefreshController(initialRefresh: true);
  var hal = 1.obs;
  String? next = '';
  // ! details
  String apikey = "7a395681502b437d8cbc489ebee68c6c";
  Future<DetailGame> details(int id) async {
    Uri url = Uri.parse('https://api.rawg.io/api/games/$id?key=$apikey');
    var response = await http.get(url);
    var data = json.decode(response.body);
    var tempdata = DetailGame.fromJson(data);
    print("isi details ${tempdata.id}");
    // print("isi details ${tempdata.description}");
    print("panjang genre ${tempdata.genres!.length}");
    return tempdata;
  }

  // ! SS
  Future<List<dynamic>> screenshot(int id) async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games/$id/screenshots?key=$apikey');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => ScreenshotGame.fromJson(e)).toList();
    print("isi details ${tempdata}");
    return tempdata;
  }

  List same = [];
  // ! Same Series
  Future<List<dynamic>> sameSeries(int id, int page) async {
    Uri url = Uri.parse(
        'https://api.rawg.io/api/games/$id/game-series?key=$apikey&page=$page');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    next = json.decode(response.body)["next"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    update();
    var seen = <dynamic>{};
    same = tempdata.where((element) => seen.add(element)).toList();
    same.addAll(tempdata);
    update();
    return same;
  }

  void refrshSimilar(int id) async {
    if (sameRefresh.initialRefresh == true) {
      hal.value = 1;
      await sameSeries(id, hal.value);
      update();
      return sameRefresh.refreshCompleted();
    } else {
      return sameRefresh.refreshFailed();
    }
  }

  void loadSimilar(int id) async {
    if (next != null) {
      hal.value = hal.value + 1;
      await sameSeries(id, hal.value);
      update();
      return sameRefresh.loadComplete();
    } else {
      return sameRefresh.loadNoData();
    }
  }
}
