import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:game_database/app/data/constant/color.dart';
import 'package:game_database/app/modules/home/controllers/home_controller.dart';
import 'package:game_database/app/modules/home/views/home_view.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  await GetStorage.init();
  final box = GetStorage();
  // Get.lazyPut(() => HomeController());
  final controller = Get.put(HomeController());
  runApp(ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Game Database",
      theme: controller.theme,
      home:  HomeView(),
      getPages: AppPages.routes,
    ),
  ));
}
