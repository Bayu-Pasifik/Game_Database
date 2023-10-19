import 'package:flutter/material.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchC extends GetxController {
  List<dynamic> result = [];
  String apikey = "7a395681502b437d8cbc489ebee68c6c";
  String? next = '';
  var hal = 1.obs;
  var searchLength = 0.obs;
  var isTextpresent = ''.obs;
  TextEditingController searchC = TextEditingController();
  RefreshController refreshResult = RefreshController(initialRefresh: true);
  var noMoreItems = false.obs;
  void checkNoMoreItems(bool isLast) {
    if (isLast == true) {
      noMoreItems.value = true;
    } else {
      noMoreItems.value = false;
    }
  }

  void clearSearch() {
    listSearch.refresh();
    listSearch.itemList?.clear();
    listSearch.firstPageKey;
  }

  final PagingController<int, GameModels> listSearch =
      PagingController<int, GameModels>(firstPageKey: 1);
  // ! result Series
  // Future<List<dynamic>> resultQuery(String query, int page) async {
  //   Uri url = Uri.parse(
  //       'https://api.rawg.io/api/games?key=$apikey&search=$query&page=$page');
  //   var response = await http.get(url);
  //   final data = json.decode(response.body)["results"];
  //   next = json.decode(response.body)["next"];
  //   final tempdata = data.map((e) => GameModels.fromJson(e)).toList();
  //   result.addAll(tempdata);
  //   update();
  //   print("panjang result ${result.length}");
  //   return result;
  // }

  void resultQuery(String query, int pageKey) async {
  try {
    Uri url = Uri.parse(
        'https://api.rawg.io/api/games?key=$apikey&search=$query&page=$pageKey');
    var response = await http.get(url);
    var tempdata = json.decode(response.body)["results"];
    var data = tempdata.map((e) => GameModels.fromJson(e)).toList();
    List<GameModels> gamedata = List<GameModels>.from(data);
    print("page key genre puzzle $pageKey");
    final nextPage = json.decode(response.body)["next"];
    final isLastPage = nextPage == null;

    if (isLastPage) {
      listSearch.appendLastPage(gamedata);
      noMoreItems(true);
    } else {
      listSearch.appendPage(gamedata, pageKey + 1);
      noMoreItems(false);
    }
  } catch (e) {
    listSearch.error = e;
  }
}

  // void refreshData(String que) async {
  //   if (refreshResult.initialRefresh == true) {
  //     hal.value = 1;
  //     result.clear();
  //     await resultQuery(que, hal.value);
  //     update();
  //     return refreshResult.refreshCompleted();
  //   } else {
  //     return refreshResult.refreshFailed();
  //   }
  // }

  // void loadData(String que) async {
  //   if (next != null) {
  //     hal.value = hal.value + 1;
  //     await resultQuery(que, hal.value);
  //     update();
  //     return refreshResult.loadComplete();
  //   } else {
  //     return refreshResult.loadNoData();
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    searchC = TextEditingController();
    listSearch.addPageRequestListener((pageKey) {
      resultQuery(searchC.text, pageKey);
    });
  }

  @override
  void dispose() {
    super.dispose();
    listSearch.dispose();
  }
}
