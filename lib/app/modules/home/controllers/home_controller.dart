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
  final PagingController<int, GameModels> adventureGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> rpgGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> strategyGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> shooterGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> casualGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> simulationGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> puzzleGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> arcadeGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> platformerGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> mmoGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> racingGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> sportsGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> fightingGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> fammilyGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> boardGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> educationalGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  final PagingController<int, GameModels> cardGame =
      PagingController<int, GameModels>(firstPageKey: 1);
  void handleTabChange() {
    // Check if the current tab is selected
    if (tabController.indexIsChanging) {
      // Update the corresponding PagingController
      if (tabController.index == 0) {
        actionGame.refresh();
      } else if (tabController.index == 1) {
        indieGame.refresh();
      } else if (tabController.index == 2) {
        adventureGame.refresh();
      } else if (tabController.index == 3) {
        rpgGame.refresh();
      } else if (tabController.index == 4) {
        strategyGame.refresh();
      } else if (tabController.index == 5) {
        shooterGame.refresh();
      } else if (tabController.index == 6) {
        casualGame.refresh();
      } else if (tabController.index == 7) {
        simulationGame.refresh();
      } else if (tabController.index == 8) {
        puzzleGame.refresh();
      } else if (tabController.index == 9) {
        arcadeGame.refresh();
      } else if (tabController.index == 10) {
        platformerGame.refresh();
      } else if (tabController.index == 11) {
        mmoGame.refresh();
      } else if (tabController.index == 12) {
        racingGame.refresh();
      } else if (tabController.index == 13) {
        sportsGame.refresh();
      } else if (tabController.index == 14) {
        fightingGame.refresh();
      } else if (tabController.index == 15) {
        fammilyGame.refresh();
      } else if (tabController.index == 16) {
        boardGame.refresh();
      } else if (tabController.index == 17) {
        educationalGame.refresh();
      } else if (tabController.index == 18) {
        cardGame.refresh();
      }
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
      indieGame.error = e;
    }
    return modelGame;
  }

  Future<List<GameModels>> genreAdventure(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=adventure&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre adventure $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        adventureGame.appendLastPage(gamedata);
      } else {
        adventureGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      adventureGame.error = e;
    }
    return modelGame;
  }

  // ! RPG
  Future<List<GameModels>> genreRpg(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=5&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre rpg $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        rpgGame.appendLastPage(gamedata);
      } else {
        rpgGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      rpgGame.error = e;
    }
    return modelGame;
  }

  // ! Strategy
  Future<List<GameModels>> genreStrategy(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=strategy&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre strategy $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        strategyGame.appendLastPage(gamedata);
      } else {
        strategyGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      strategyGame.error = e;
    }
    return modelGame;
  }

  // ! Shooter
  Future<List<GameModels>> genreShooter(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=shooter&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre shooter $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        shooterGame.appendLastPage(gamedata);
      } else {
        shooterGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      shooterGame.error = e;
    }
    return modelGame;
  }

  // ! Casual
  Future<List<GameModels>> genreCasual(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=casual&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre casual $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        casualGame.appendLastPage(gamedata);
      } else {
        casualGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      casualGame.error = e;
    }
    return modelGame;
  }

  // ! Simulation
  Future<List<GameModels>> genreSimulation(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=simulation&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre simulation $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        simulationGame.appendLastPage(gamedata);
      } else {
        simulationGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      simulationGame.error = e;
    }
    return modelGame;
  }

  // ! Puzzle
  Future<List<GameModels>> genrePuzzle(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=puzzle&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre puzzle $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        puzzleGame.appendLastPage(gamedata);
      } else {
        puzzleGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      puzzleGame.error = e;
    }
    return modelGame;
  }

  // ! Arcade
  Future<List<GameModels>> genreArcade(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=arcade&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre arcade $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        arcadeGame.appendLastPage(gamedata);
      } else {
        arcadeGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      arcadeGame.error = e;
    }
    return modelGame;
  }

  // ! Platformer
  Future<List<GameModels>> genrePlatformer(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=platformer&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre platformer $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        platformerGame.appendLastPage(gamedata);
      } else {
        platformerGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      platformerGame.error = e;
    }
    return modelGame;
  }

  // ! Racing
  Future<List<GameModels>> genreRacing(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=racing&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre racing $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        racingGame.appendLastPage(gamedata);
      } else {
        racingGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      racingGame.error = e;
    }
    return modelGame;
  }

  // ! MMO
  Future<List<GameModels>> genreMMO(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=59&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre mmo $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        mmoGame.appendLastPage(gamedata);
      } else {
        mmoGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      mmoGame.error = e;
    }
    return modelGame;
  }

  // ! sport
  Future<List<GameModels>> genreSport(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=sports&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre sports $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        sportsGame.appendLastPage(gamedata);
      } else {
        sportsGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      sportsGame.error = e;
    }
    return modelGame;
  }

  // ! Fighting
  Future<List<GameModels>> genreFighting(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=fighting&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre fighting $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        fightingGame.appendLastPage(gamedata);
      } else {
        fightingGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      fightingGame.error = e;
    }
    return modelGame;
  }

  // ! Family
  Future<List<GameModels>> genreFamily(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=family&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre family $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        fammilyGame.appendLastPage(gamedata);
      } else {
        fammilyGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      fammilyGame.error = e;
    }
    return modelGame;
  }

  // ! Board
  Future<List<GameModels>> genreBoard(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=28&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre board $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        boardGame.appendLastPage(gamedata);
      } else {
        boardGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      boardGame.error = e;
    }
    return modelGame;
  }

  // ! Educational
  Future<List<GameModels>> genreEducational(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=34&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre educational $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        educationalGame.appendLastPage(gamedata);
      } else {
        educationalGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      educationalGame.error = e;
    }
    return modelGame;
  }

  // ! Card
  Future<List<GameModels>> genreCard(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=card&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      modelGame.addAll(gamedata);
      print("page key genre card $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        cardGame.appendLastPage(gamedata);
      } else {
        cardGame.appendPage(gamedata, pageKey + 1);
      }
    } catch (e) {
      cardGame.error = e;
    }
    return modelGame;
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
    adventureGame.addPageRequestListener((pageKey) {
      genreAdventure(pageKey);
    });
    rpgGame.addPageRequestListener((pageKey) {
      genreRpg(pageKey);
    });
    strategyGame.addPageRequestListener((pageKey) {
      genreStrategy(pageKey);
    });
    shooterGame.addPageRequestListener((pageKey) {
      genreShooter(pageKey);
    });
    casualGame.addPageRequestListener((pageKey) {
      genreCasual(pageKey);
    });
    simulationGame.addPageRequestListener((pageKey) {
      genreSimulation(pageKey);
    });
    puzzleGame.addPageRequestListener((pageKey) {
      genrePuzzle(pageKey);
    });
    arcadeGame.addPageRequestListener((pageKey) {
      genreArcade(pageKey);
    });
    platformerGame.addPageRequestListener((pageKey) {
      genrePlatformer(pageKey);
    });
    mmoGame.addPageRequestListener((pageKey) {
      genreMMO(pageKey);
    });
    racingGame.addPageRequestListener((pageKey) {
      genreRacing(pageKey);
    });
    sportsGame.addPageRequestListener((pageKey) {
      genreSport(pageKey);
    });
    fightingGame.addPageRequestListener((pageKey) {
      genreFighting(pageKey);
    });
    fammilyGame.addPageRequestListener((pageKey) {
      genreFamily(pageKey);
    });
    boardGame.addPageRequestListener((pageKey) {
      genreBoard(pageKey);
    });
    educationalGame.addPageRequestListener((pageKey) {
      genreEducational(pageKey);
    });
    cardGame.addPageRequestListener((pageKey) {
      genreCard(pageKey);
    });
  }
}
