import 'package:game_database/app/data/models/archievement.dart';
import 'package:game_database/app/data/models/detail_game.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/data/models/screenshot_game.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailGameController extends GetxController {
  RefreshController sameRefresh = RefreshController(initialRefresh: true);
  RefreshController archieveRefresh = RefreshController(initialRefresh: true);
  var hal = 1.obs;
  var halArchive = 1.obs;
  String? next = '';
  String? nextArchivment = '';
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
    same.addAll(tempdata);
    print("panjang same : ${same.length}");
    update();
    return same;
  }

  List<dynamic> archievement = [];
  // ! Archievement Series
  Future<List<dynamic>> archievementGame(int id, int page) async {
    Uri url = Uri.parse(
        'https://api.rawg.io/api/games/$id/achievements?key=$apikey&page=$page');
    var response = await http.get(url);
    final data = json.decode(response.body)["results"];
    nextArchivment = json.decode(response.body)["next"];
    final tempdata = data.map((e) => ArchievementGame.fromJson(e)).toList();
    archievement.addAll(tempdata);
    update();
    print("panjang archievement ${archievement.length}");
    return archievement;
  }

  void refrshSimilar(int id) async {
    if (sameRefresh.initialRefresh == true) {
      hal.value = 1;
      same.clear();
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

  void refreshArchieve(int id) async {
    if (archieveRefresh.initialRefresh == true) {
      halArchive.value = 1;
      archievement.clear();
      await archievementGame(id, halArchive.value);
      update();
      return archieveRefresh.refreshCompleted();
    } else {
      return archieveRefresh.refreshFailed();
    }
  }

  void loadArchieve(int id) async {
    if (nextArchivment != null) {
      halArchive.value = halArchive.value + 1;

      await archievementGame(id, halArchive.value);
      update();
      return archieveRefresh.loadComplete();
    } else {
      return archieveRefresh.loadNoData();
    }
  }
}
