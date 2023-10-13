import 'package:carousel_slider/carousel_controller.dart';
import 'package:game_database/app/data/models/archievement.dart';
import 'package:game_database/app/data/models/detail_game.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/data/models/screenshot_game.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:game_database/app/data/constant/utils.dart';

class DetailGameController extends GetxController {
  var hal = 1.obs;
  
  String? next = '';
  
  // ! variable untuk slider
  var currentSlider = 0.obs;
  final CarouselController carouselController = CarouselController();
  // ! details
  
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

  List<ScreenshotGame> ssGame = [];
  // ! SS
  Future<List<ScreenshotGame>> screenshot(int id) async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games/$id/screenshots?key=$apikey');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => ScreenshotGame.fromJson(e)).toList();
    List<ScreenshotGame> ssData = List<ScreenshotGame>.from(tempdata);
    ssGame.addAll(ssData);
    return ssGame;
  }

  // List same = [];
  // ! Same Series
  Future<List<GameModels>> sameSeries(int id) async {
    Uri url = Uri.parse(
        'https://api.rawg.io/api/games/$id/game-series?key=$apikey');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    next = json.decode(response.body)["next"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> sameSeries = List<GameModels>.from(tempdata);
    return sameSeries;
  }
  // Future<List<dynamic>> sameSeries(int id, int page) async {
  //   Uri url = Uri.parse(
  //       'https://api.rawg.io/api/games/$id/game-series?key=$apikey&page=$page');
  //   var response = await http.get(url);
  //   var data = json.decode(response.body)["results"];
  //   next = json.decode(response.body)["next"];
  //   var tempdata = data.map((e) => GameModels.fromJson(e)).toList();

  //   update();
  //   same.addAll(tempdata);
  //   print("panjang same : ${same.length}");
  //   update();
  //   return same;
  // }

  
  Future<List<ArchievementGame>> archievementGame(int id) async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games/$id/achievements?key=$apikey');
    var response = await http.get(url);
    final data = json.decode(response.body)["results"];
    final tempdata = data.map((e) => ArchievementGame.fromJson(e)).toList();
    List<ArchievementGame> archiveData = List<ArchievementGame>.from(tempdata);
    print("isi dari arc : $archiveData");
    return archiveData;
  }

  // void refrshSimilar(int id) async {
  //   if (sameRefresh.initialRefresh == true) {
  //     hal.value = 1;
  //     same.clear();
  //     await sameSeries(id, hal.value);
  //     update();
  //     return sameRefresh.refreshCompleted();
  //   } else {
  //     return sameRefresh.refreshFailed();
  //   }
  // }

  // void loadSimilar(int id) async {
  //   if (next != null) {
  //     hal.value = hal.value + 1;

  //     await sameSeries(id, hal.value);
  //     update();
  //     return sameRefresh.loadComplete();
  //   } else {
  //     return sameRefresh.loadNoData();
  //   }
  // }

  // void refreshArchieve(int id) async {
  //   if (archieveRefresh.initialRefresh == true) {
  //     halArchive.value = 1;
  //     archievement.clear();
  //     await archievementGame(id, halArchive.value);
  //     update();
  //     return archieveRefresh.refreshCompleted();
  //   } else {
  //     return archieveRefresh.refreshFailed();
  //   }
  // }

  // void loadArchieve(int id) async {
  //   if (nextArchivment != null) {
  //     halArchive.value = halArchive.value + 1;

  //     await archievementGame(id, halArchive.value);
  //     update();
  //     return archieveRefresh.loadComplete();
  //   } else {
  //     return archieveRefresh.loadNoData();
  //   }
  // }

  @override
  void onInit() {
    print("init detail");
    super.onInit();
  }
}
