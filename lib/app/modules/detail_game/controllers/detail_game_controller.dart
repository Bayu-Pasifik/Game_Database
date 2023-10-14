import 'package:carousel_slider/carousel_controller.dart';
import 'package:game_database/app/data/models/archievement.dart';
import 'package:game_database/app/data/models/detail_game.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/data/models/screenshot_game.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:game_database/app/data/constant/utils.dart';
import 'package:intl/intl.dart';

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

  String formatDate(DateTime date) {
  final outputFormat = DateFormat("yyyy-MM-dd");
  return outputFormat.format(date);
}

  @override
  void onInit() {
    super.onInit();
  }
}
