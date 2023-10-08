import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(controller.box.getValues());

            controller.changeTheme(controller.isDarkmode.value);
          },
          child: Obx(() => controller.isDarkmode.isFalse
              ? const Icon(Icons.sunny)
              : const Icon(Icons.mode_night_outlined)),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text(
                  "Browse Games",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 40.h,
                  child: TextField(
                    decoration: const InputDecoration(
                        label: Text("Search"),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        )),
                    onTap: () => Get.toNamed(Routes.SEARCH),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 40.h,
                  width: context.width,
                  child: TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    // indicatorWeight: 10,
                    dividerColor: Colors.transparent,
                    tabs: controller.genreList.map((genre) {
                      return SizedBox(
                        height: 30,
                        width: 100,
                        child: Tab(
                          // text: genre.name,
                          child: Text(
                            "${genre.name}",
                            style: GoogleFonts.poppins(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: controller.genreList.map((genre) {
                      final index = controller.genreList.indexOf(genre);

                      // Listen to tab changes and call handleTabChange from the controller when the tab changes
                      controller.tabController
                          .addListener(controller.handleTabChange);
                      print("index : $index");
                      return PagedGridView<int, GameModels>(
                        // padding: EdgeInsets.all(10.w),
                        pagingController: index == 0
                            ? controller.actionGame
                            : index == 1
                                ? controller.indieGame
                                : index == 2
                                    ? controller.adventureGame
                                    : index == 3
                                        ? controller.rpgGame
                                        : index == 4
                                            ? controller.strategyGame
                                            : index == 5
                                                ? controller.shooterGame
                                                : index == 6
                                                    ? controller.casualGame
                                                    : index == 7
                                                        ? controller
                                                            .simulationGame
                                                        : index == 8
                                                            ? controller
                                                                .puzzleGame
                                                            : index == 9
                                                                ? controller
                                                                    .arcadeGame
                                                                : index == 10
                                                                    ? controller
                                                                        .platformerGame
                                                                    : index ==
                                                                            11
                                                                        ? controller
                                                                            .mmoGame
                                                                        : index ==
                                                                                12
                                                                            ? controller.racingGame
                                                                            : index == 13
                                                                                ? controller.sportsGame
                                                                                : index == 14
                                                                                    ? controller.fightingGame
                                                                                    : index == 15
                                                                                        ? controller.fammilyGame
                                                                                        : index == 16
                                                                                            ? controller.boardGame
                                                                                            : index == 17
                                                                                                ? controller.educationalGame
                                                                                                : controller.cardGame,

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2.h.toInt(),
                            crossAxisSpacing: 10.w,
                            mainAxisExtent: 250.h,
                            mainAxisSpacing: 20.h),
                        builderDelegate: PagedChildBuilderDelegate<GameModels>(
                          itemBuilder: (context, game, index) {
                            return Column(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // Get.toNamed(Routes.DETAIL_PAGE,
                                      //     arguments: {
                                      //       "movie": currentMovie,
                                      //       "user": userData
                                      //     });
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: "${game.backgroundImage}",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "assets/images/Image_not_available.png"),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${game.name}",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          overflow: TextOverflow.ellipsis)),
                                ),
                                (game.playtime != null)
                                    ? Text(
                                        "${game.playtime} Hours",
                                        style: GoogleFonts.poppins(),
                                      )
                                    : Text("Null", style: GoogleFonts.poppins())
                              ],
                            );
                          },
                          firstPageProgressIndicatorBuilder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                          noItemsFoundIndicatorBuilder: (_) =>
                              const Center(child: Text('No Data Available')),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
