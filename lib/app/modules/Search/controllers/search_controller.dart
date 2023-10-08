import 'package:flutter/material.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
  // ! result Series
  Future<List<dynamic>> resultQuery(String query, int page) async {
    Uri url = Uri.parse(
        'https://api.rawg.io/api/games?key=$apikey&search=$query&page=$page');
    var response = await http.get(url);
    final data = json.decode(response.body)["results"];
    next = json.decode(response.body)["next"];
    final tempdata = data.map((e) => GameModels.fromJson(e)).toList();
    result.addAll(tempdata);
    update();
    print("panjang result ${result.length}");
    return result;
  }

  void refreshData(String que) async {
    if (refreshResult.initialRefresh == true) {
      hal.value = 1;
      result.clear();
      await resultQuery(que, hal.value);
      update();
      return refreshResult.refreshCompleted();
    } else {
      return refreshResult.refreshFailed();
    }
  }

  void loadData(String que) async {
    if (next != null) {
      hal.value = hal.value + 1;
      await resultQuery(que, hal.value);
      update();
      return refreshResult.loadComplete();
    } else {
      return refreshResult.loadNoData();
    }
  }

  @override
  void onInit() {
    super.onInit();
    searchC = TextEditingController();
  }
}
