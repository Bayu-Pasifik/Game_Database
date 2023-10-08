import 'package:flutter/material.dart';
import 'package:game_database/app/data/constant/color.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/data/models/genres.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  String apikey = "7a395681502b437d8cbc489ebee68c6c";
  // ! Action
  late TabController tabController;
  // final PagingController<int, GameModels> actionGame =
  //     PagingController<int, GameModels>(firstPageKey: 1);
  // final PagingController<int, GameModels> indieGame =
  //     PagingController<int, GameModels>(firstPageKey: 1);

  // ! change theme
  final box = GetStorage();
  var isDarkmode = false.obs;

  bool get isDark => box.read('darkmode') ?? false;

  ThemeData get theme => isDark
      ? ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.amber,
          textTheme: TextTheme(
            displayLarge: GoogleFonts.poppins(color: textColor),
            bodyLarge: GoogleFonts.poppins(color: textColor),
            bodyMedium: GoogleFonts.poppins(color: textColor),
            bodySmall: GoogleFonts.poppins(color: textColor),
            displayMedium: GoogleFonts.poppins(color: textColor),
            displaySmall: GoogleFonts.poppins(color: textColor),
            headlineLarge: GoogleFonts.poppins(color: textColor),
            headlineMedium: GoogleFonts.poppins(color: textColor),
            headlineSmall: GoogleFonts.poppins(color: textColor),
            labelLarge: GoogleFonts.poppins(color: textColor),
            labelMedium: GoogleFonts.poppins(color: textColor),
            labelSmall: GoogleFonts.poppins(color: textColor),
            titleLarge: GoogleFonts.poppins(color: textColor),
            titleMedium: GoogleFonts.poppins(color: textColor),
            titleSmall: GoogleFonts.poppins(color: textColor),
          ),
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Color(0XFF858597),
            indicatorColor: Colors.transparent,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 101, 9, 206),
            ),
          ),
          scaffoldBackgroundColor: darkTheme)
      : ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.amber,
          textTheme: TextTheme(
            displayLarge: GoogleFonts.poppins(color: whiteThemeText),
            bodyLarge: GoogleFonts.poppins(color: whiteThemeText),
            bodyMedium: GoogleFonts.poppins(color: whiteThemeText),
            bodySmall: GoogleFonts.poppins(color: whiteThemeText),
            displayMedium: GoogleFonts.poppins(color: whiteThemeText),
            displaySmall: GoogleFonts.poppins(color: whiteThemeText),
            headlineLarge: GoogleFonts.poppins(color: whiteThemeText),
            headlineMedium: GoogleFonts.poppins(color: whiteThemeText),
            headlineSmall: GoogleFonts.poppins(color: whiteThemeText),
            labelLarge: GoogleFonts.poppins(color: whiteThemeText),
            labelMedium: GoogleFonts.poppins(color: whiteThemeText),
            labelSmall: GoogleFonts.poppins(color: whiteThemeText),
            titleLarge: GoogleFonts.poppins(color: whiteThemeText),
            titleMedium: GoogleFonts.poppins(color: whiteThemeText),
            titleSmall: GoogleFonts.poppins(color: whiteThemeText),
          ),
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Color(0XFF858597),
            indicatorColor: Colors.transparent,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 101, 9, 206),
            ),
          ),
          scaffoldBackgroundColor: withTheme);

  void changeTheme(bool val) {
    if (isDarkmode.value == true) {
      box.write('darkmode', val);
    } else {
      box.remove('darkmode');
    }
    isDarkmode.toggle();
    Get.changeTheme(theme);
  }

  List<Genres> genreList = [];
  Future<List<Genres>> getGenre() async {
    Uri url = Uri.parse('https://api.rawg.io/api/genres?key=$apikey');
    var response = await http.get(url);
    var tempData = json.decode(response.body)["results"];
    var data = tempData.map((e) => Genres.fromJson(e)).toList();
    List<Genres> allgenres = List<Genres>.from(data);
    print(allgenres);
    genreList.addAll(allgenres);
    return genreList;
  }

  var indextab = 0.obs;
  // Update the getGames method to return a list of GameModels
  final PagingController<int, GameModels> actionGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> indieGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  void handleTabChange() {
    // Check if the current tab is selected
    if (tabController.indexIsChanging) {
      // Update the corresponding PagingController
      if (tabController.index == 0) {
        actionGame.refresh();
      } else if (tabController.index == 1) {
        indieGame.refresh();
      }
      // Add similar conditions for other genres
    }
  }

  List<GameModels> modelGame = [];

// Update the genreAction, genresIndie, and genreAdventure methods to return a list of GameModels
  Future<List<GameModels>> genreAction(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=action&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre action$pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        actionGame.appendLastPage(gamedata);
      } else {
        actionGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      actionGame.error = e;
    }
    return modelGame;
  }

  Future<List<GameModels>> genreIndie(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=indie&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre indie $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        indieGame.appendLastPage(gamedata);
      } else {
        indieGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      actionGame.error = e;
    }
    return modelGame;
  }
  // Future<List<GameModels>> genreAction() async {
  //   Uri url =
  //       Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=action');
  //   var response = await http.get(url);
  //   var tempdata = json.decode(response.body)["results"];
  //   var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
  //   List<GameModels> gamedata = List<GameModels>.from(data);
  //   print("data action: ${data[0].name}");
  //   return gamedata;
  // }

  Future<List<GameModels>> genresIndie() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=indie');
    var response = await http.get(url);
    var tempdata = json.decode(response.body)["results"];
    var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(data);
    print("data indie: ${data[0].name}");
    return gamedata;
  }

  Future<List<GameModels>> genreAdventure() async {
    Uri url = Uri.parse(
        'https://api.rawg.io/api/games?key=$apikey&genres=adventure&page=2');
    var response = await http.get(url);
    var tempdata = json.decode(response.body)["results"];
    var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(data);
    print("data adven: ${data[0].name}");
    return gamedata;
  }

  // ! RPG
  Future<List<dynamic>> genreRpg() async {
    Uri url = Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=5');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi rpg ${tempdata[0].name}");
    return gamedata;
  }

  // ! Strategy
  Future<List<GameModels>> genreStrategy() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=strategy');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi strategy ${tempdata[0].name}");
    return gamedata;
  }

  // ! Casual
  Future<List<GameModels>> genreCasual() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=casual');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi casual ${tempdata[0].name}");
    return gamedata;
  }

  // ! Simulation
  Future<List<GameModels>> genreSimulation() async {
    Uri url = Uri.parse(
        'https://api.rawg.io/api/games?key=$apikey&genres=simulation');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi simulation ${tempdata[0].name}");
    return gamedata;
  }

  // ! Puzzle
  Future<List<GameModels>> genrePuzzle() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=puzzle');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi puzzle ${tempdata[0].name}");
    return gamedata;
  }

  // ! Arcade
  Future<List<GameModels>> genreArcade() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=arcade');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi arcade ${tempdata[0].name}");
    return gamedata;
  }

  // ! Platformer
  Future<List<GameModels>> genrePlatformer() async {
    Uri url = Uri.parse(
        'https://api.rawg.io/api/games?key=$apikey&genres=platformer');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi platformer ${tempdata[0].name}");
    return gamedata;
  }

  // ! Racing
  Future<List<GameModels>> genreRacing() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=racing');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi racing ${tempdata[0].name}");
    return gamedata;
  }

  // ! MMO
  Future<List<GameModels>> genreMMO() async {
    Uri url = Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=59');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi mmo ${tempdata[0].name}");
    return gamedata;
  }

  // ! sport
  Future<List<GameModels>> genreSport() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=sports');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi sport ${tempdata[0].name}");
    return gamedata;
  }

  // ! Fighting
  Future<List<GameModels>> genreFighting() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=fighting');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi fighting ${tempdata[0].name}");
    return gamedata;
  }

  // ! Family
  Future<List<GameModels>> genreFamily() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=family');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi Family ${tempdata[0].name}");
    return gamedata;
  }

  // ! Board
  Future<List<GameModels>> genreBoard() async {
    Uri url = Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=28');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi Board ${tempdata[0].name}");
    return gamedata;
  }

  // ! Educational
  Future<List<GameModels>> genreEducational() async {
    Uri url = Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=34');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi edu ${tempdata[0].name}");
    return gamedata;
  }

  // ! Card
  Future<List<GameModels>> genreCard() async {
    Uri url =
        Uri.parse('https://api.rawg.io/api/games?key=$apikey&genres=card');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    var tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(tempdata);
    print("isi card ${tempdata[0].name}");
    return gamedata;
  }

  @override
  void onInit() async {
    super.onInit();
    // genre = getGenre();
    await getGenre();
    tabController = TabController(
      length: genreList.length,
      vsync: this,
    );
    actionGame.addPageRequestListener((pageKey) {
      genreAction(pageKey);
    });
    indieGame.addPageRequestListener((pageKey) {
      genreIndie(pageKey);
    });
    // indie = genresIndie();
    // action = genreAction();
    // adventure = genreAdventure();
    // rpg = genreRpg();
    // strategy = genreStrategy();
    // casual = genreCasual();
    // simulation = genreSimulation();
    // puzzle = genrePuzzle();
    // arcade = genreArcade();
    // platformer = genrePlatformer();
    // racing = genreRacing();
    // mmo = genreMMO();
    // sport = genreSport();
    // fighting = genreFighting();
    // family = genreFamily();
    // board = genreBoard();
    // educational = genreEducational();
    // card = genreCard();
  }
}
