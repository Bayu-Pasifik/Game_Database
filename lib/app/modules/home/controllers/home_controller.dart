import 'package:flutter/material.dart';
import 'package:game_database/app/data/constant/color.dart';
import 'package:game_database/app/data/constant/utils.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/data/models/genres.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  String apikey = "7a395681502b437d8cbc489ebee68c6c";
  // ! Action
  late TabController? tabController;

  // ! change theme
  final box = GetStorage();

  bool get isDark => box.read('darkmode') ?? false;

  void changeTheme(bool val) {
  if (val == true) {
    box.write("darkmode", true);
    Get.changeTheme(themeDark);
  } else {
    box.remove("darkmode");
    Get.changeTheme(themeWhite);
  }
  isDarkmode.value = val; // Mengatur nilai isDarkmode sesuai dengan val yang diterima.
}

  List<Genres> genreList = [];
  bool isTabControllerInitialized = false;

  Future<List<Genres>> getGenre() async {
    Uri url = Uri.parse('https://api.rawg.io/api/genres?key=$apikey');
    var response = await http.get(url);
    var tempData = json.decode(response.body)["results"];
    var data = tempData.map((e) => Genres.fromJson(e)).toList();
    List<Genres> allgenres = List<Genres>.from(data);
    print(allgenres);
    genreList.addAll(allgenres);
    // Set flag to true when the controller is initialized
    isTabControllerInitialized = true;
    return genreList;
  }

  var noMoreItems = false.obs;
  void checkNoMoreItems(bool isLast) {
    if (isLast == true) {
      noMoreItems.value = true;
    } else {
      noMoreItems.value = false;
    }
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
    if (tabController!.indexIsChanging) {
      // Update the corresponding PagingController
      if (tabController!.index == 0) {
        actionGame.refresh();
      } else if (tabController!.index == 1) {
        indieGame.refresh();
      } else if (tabController!.index == 2) {
        adventureGame.refresh();
      } else if (tabController!.index == 3) {
        rpgGame.refresh();
      } else if (tabController!.index == 4) {
        strategyGame.refresh();
      } else if (tabController!.index == 5) {
        shooterGame.refresh();
      } else if (tabController!.index == 6) {
        casualGame.refresh();
      } else if (tabController!.index == 7) {
        simulationGame.refresh();
      } else if (tabController!.index == 8) {
        puzzleGame.refresh();
      } else if (tabController!.index == 9) {
        arcadeGame.refresh();
      } else if (tabController!.index == 10) {
        platformerGame.refresh();
      } else if (tabController!.index == 11) {
        mmoGame.refresh();
      } else if (tabController!.index == 12) {
        racingGame.refresh();
      } else if (tabController!.index == 13) {
        sportsGame.refresh();
      } else if (tabController!.index == 14) {
        fightingGame.refresh();
      } else if (tabController!.index == 15) {
        fammilyGame.refresh();
      } else if (tabController!.index == 16) {
        boardGame.refresh();
      } else if (tabController!.index == 17) {
        educationalGame.refresh();
      } else if (tabController!.index == 18) {
        cardGame.refresh();
      }
    }
  }

// Update the genreAction, genresIndie, and genreAdventure methods to return a list of GameModels
  void genreAction(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=action&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre action$pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        actionGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        actionGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      actionGame.error = e;
    }
  }

  void genreIndie(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=indie&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre indie $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        indieGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        indieGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      indieGame.error = e;
    }
  }

  void genreAdventure(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=adventure&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre adventure $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        adventureGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        adventureGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      adventureGame.error = e;
    }
  }

  // ! RPG
  void genreRpg(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=5&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre rpg $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        rpgGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        rpgGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      rpgGame.error = e;
    }
  }

  // ! Strategy
  void genreStrategy(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=strategy&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre strategy $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        strategyGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        strategyGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(true);
      }
    } catch (e) {
      strategyGame.error = e;
    }
  }

  // ! Shooter
  void genreShooter(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=shooter&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre shooter $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        shooterGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        shooterGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      shooterGame.error = e;
    }
  }

  // ! Casual
  void genreCasual(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=casual&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre casual $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        casualGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        casualGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      casualGame.error = e;
    }
  }

  // ! Simulation
  void genreSimulation(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=simulation&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre simulation $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        simulationGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        simulationGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      simulationGame.error = e;
    }
  }

  // ! Puzzle
  void genrePuzzle(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=puzzle&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre puzzle $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        puzzleGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        puzzleGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      puzzleGame.error = e;
    }
  }

  // ! Arcade
  void genreArcade(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=arcade&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre arcade $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        arcadeGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        arcadeGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      arcadeGame.error = e;
    }
  }

  // ! Platformer
  void genrePlatformer(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=platformer&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre platformer $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        platformerGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        platformerGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      platformerGame.error = e;
    }
  }

  // ! Racing
  void genreRacing(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=racing&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre racing $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;
      if (isLastPage) {
        racingGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        racingGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      racingGame.error = e;
    }
  }

  // ! MMO
  void genreMMO(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=59&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre mmo $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        mmoGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        mmoGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      mmoGame.error = e;
    }
  }

  // ! sport
  void genreSport(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=sports&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre sports $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        sportsGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        sportsGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      sportsGame.error = e;
    }
  }

  // ! Fighting
  void genreFighting(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=fighting&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre fighting $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        fightingGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        fightingGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      fightingGame.error = e;
    }
  }

  // ! Family
  void genreFamily(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=family&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre family $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        fammilyGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        fammilyGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      fammilyGame.error = e;
    }
  }

  // ! Board
  void genreBoard(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=28&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre board $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        boardGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        boardGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      boardGame.error = e;
    }
  }

  // ! Educational
  void genreEducational(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=34&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre educational $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        educationalGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        educationalGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      educationalGame.error = e;
    }
  }

  // ! Card
  void genreCard(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://api.rawg.io/api/games?key=$apikey&genres=card&page=$pageKey');
      var response = await http.get(url);
      var tempdata = json.decode(response.body)["results"];
      var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
      List<GameModels> gamedata = List<GameModels>.from(data);
      print("page key genre card $pageKey");
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == null;
      if (isLastPage) {
        cardGame.appendLastPage(gamedata);
        noMoreItems(true);
      } else {
        cardGame.appendPage(gamedata, pageKey + 1);
        noMoreItems(false);
      }
    } catch (e) {
      cardGame.error = e;
    }
  }

  void initTabController(int length) {
    tabController = TabController(vsync: this, length: length);
  }

  @override
  void onInit() async {
    super.onInit();
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

  @override
  void dispose() {
    tabController?.dispose();
    actionGame.dispose();
    indieGame.dispose();
    adventureGame.dispose();
    rpgGame.dispose();
    strategyGame.dispose();
    shooterGame.dispose();
    casualGame.dispose();
    simulationGame.dispose();
    puzzleGame.dispose();
    fammilyGame.dispose();
    arcadeGame.dispose();
    platformerGame.dispose();
    mmoGame.dispose();
    racingGame.dispose();
    sportsGame.dispose();
    fightingGame.dispose();
    boardGame.dispose();
    educationalGame.dispose();
    cardGame.dispose();
    super.dispose();
  }
}
