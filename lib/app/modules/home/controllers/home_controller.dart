import 'package:game_database/app/data/models/game_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  String apikey = "7a395681502b437d8cbc489ebee68c6c";
  // ! Action
  // List<dynamic> actio = [];
  late Future<List<dynamic>> action;
  late Future<List<dynamic>> indie;
  late Future<List<dynamic>> adventure;
  late Future<List<dynamic>> rpg;
  late Future<List<dynamic>> strategy;
  late Future<List<dynamic>> casual;
  late Future<List<dynamic>> simulation;
  late Future<List<dynamic>> puzzle;
  late Future<List<dynamic>> arcade;
  late Future<List<dynamic>> platformer;
  late Future<List<dynamic>> racing;
  late Future<List<dynamic>> mmo;
  late Future<List<dynamic>> sport;
  late Future<List<dynamic>> fighting;
  late Future<List<dynamic>> family;
  late Future<List<dynamic>> board;
  late Future<List<dynamic>> educational;
  late Future<List<dynamic>> card;
  Future<List<dynamic>> genreAction() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=action');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi action ${tempdata[0].name}");
    return tempdata;
  }

  // ! Indie
  Future<List<dynamic>> genresIndie() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=indie');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi indie ${tempdata[0].name}");
    return tempdata;
  }

  // ! Adventure
  Future<List<dynamic>> genreAdventure() async {
    Uri url = Uri.parse(
        'https://api.rawg.io/api/games?key=$apikey&genres=adventure&page=2');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi adventure ${tempdata[0].name}");
    return tempdata;
  }

  // ! RPG
  Future<List<dynamic>> genreRpg() async {
    Uri url = Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=5');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi rpg ${tempdata[0].name}");
    return tempdata;
  }

  // ! Strategy
  Future<List<dynamic>> genreStrategy() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=strategy');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi strategy ${tempdata[0].name}");
    return tempdata;
  }

  // ! Casual
  Future<List<dynamic>> genreCasual() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=casual');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi casual ${tempdata[0].name}");
    return tempdata;
  }

  // ! Simulation
  Future<List<dynamic>> genreSimulation() async {
    Uri url = Uri.parse(
        'https://api.rawg.io/api/games?key=$apikey&genres=simulation');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi simulation ${tempdata[0].name}");
    return tempdata;
  }

  // ! Puzzle
  Future<List<dynamic>> genrePuzzle() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=puzzle');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi puzzle ${tempdata[0].name}");
    return tempdata;
  }

  // ! Arcade
  Future<List<dynamic>> genreArcade() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=arcade');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi arcade ${tempdata[0].name}");
    return tempdata;
  }

  // ! Platformer
  Future<List<dynamic>> genrePlatformer() async {
    Uri url = Uri.parse(
        'https://api.rawg.io/api/games?key=$apikey&genres=platformer');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi platformer ${tempdata[0].name}");
    return tempdata;
  }

  // ! Racing
  Future<List<dynamic>> genreRacing() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=racing');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi racing ${tempdata[0].name}");
    return tempdata;
  }

  // ! MMO
  Future<List<dynamic>> genreMMO() async {
    Uri url = Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=59');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi mmo ${tempdata[0].name}");
    return tempdata;
  }

  // ! sport
  Future<List<dynamic>> genreSport() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=sports');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi sport ${tempdata[0].name}");
    return tempdata;
  }

  // ! Fighting
  Future<List<dynamic>> genreFighting() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=fighting');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi fighting ${tempdata[0].name}");
    return tempdata;
  }

  // ! Family
  Future<List<dynamic>> genreFamily() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=family');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi Family ${tempdata[0].name}");
    return tempdata;
  }

  // ! Board
  Future<List<dynamic>> genreBoard() async {
    Uri url = Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=28');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi Board ${tempdata[0].name}");
    return tempdata;
  }

  // ! Educational
  Future<List<dynamic>> genreEducational() async {
    Uri url = Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=34');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi edu ${tempdata[0].name}");
    return tempdata;
  }

  // ! Card
  Future<List<dynamic>> genreCard() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=card');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    print("isi card ${tempdata[0].name}");
    return tempdata;
  }

  @override
  void onInit() {
    super.onInit();
    indie = genresIndie();
    action = genreAction();
    adventure = genreAdventure();
    rpg = genreRpg();
    strategy = genreStrategy();
    casual = genreCasual();
    simulation = genreSimulation();
    puzzle = genrePuzzle();
 arcade = genreArcade();
     platformer = genrePlatformer();
    racing = genreRacing();
     mmo = genreMMO();
     sport = genreSport();
   fighting = genreFighting();
    family = genreFamily();
   board = genreBoard();
   educational = genreEducational();
    card = genreCard();
  }
}
