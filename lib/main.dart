import 'package:flutter/material.dart';
import 'package:game_database/app/modules/home/controllers/home_controller.dart';
import 'package:game_database/app/modules/home/views/home_view.dart';

import 'package:get/get.dart';
import 'package:http/http.dart';

import 'app/routes/app_pages.dart';

void main() {
  Get.put(HomeController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 5)),
        builder: (context, snapshot) => const HomeView(),
      ),
      // initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
