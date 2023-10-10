import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_database/app/data/constant/color.dart';
import 'package:game_database/app/data/models/archievement.dart';
import 'package:game_database/app/data/models/detail_game.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/data/models/screenshot_game.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';

import '../controllers/detail_game_controller.dart';

class DetailGameView extends GetView<DetailGameController> {
  const DetailGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GameModels models = Get.arguments;
    return Scaffold(
        appBar: null,
        body: FutureBuilder(
          future: controller.details(models.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No Screenshots Available'));
            }
            final detail = snapshot.data!;
            return ListView(
              children: [
                Container(
                  height: 300.h,
                  width: context.width,
                  // color: Colors.amber,
                  child: FutureBuilder<List<ScreenshotGame>>(
                    future: controller.screenshot(detail.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No Screenshots Available'));
                      }

                      final ssGames = snapshot.data!;

                      return Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                                scrollPhysics: const BouncingScrollPhysics(),
                                viewportFraction: 1,
                                height: 250.h,
                                autoPlayInterval: const Duration(seconds: 4),
                                autoPlay: true,
                                onPageChanged: (index, reason) {
                                  controller.currentSlider.value = index;
                                },
                                autoPlayCurve: Curves.fastEaseInToSlowEaseOut),
                            items: ssGames.map((ssGame) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: context.width,
                                    height: 250.h,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ),
                                    ),
                                    child: Image.network(
                                      ssGame.image ?? "",
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Positioned(
                            top: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: ssGames.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => controller.carouselController
                                      .animateToPage(entry.key),
                                  child: Obx(
                                    () {
                                      return Container(
                                        width: controller.currentSlider.value ==
                                                entry.key
                                            ? 30
                                            : 8,
                                        height: 8,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 4.0,
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(18)),
                                          color: Colors.green.withOpacity(
                                            controller.currentSlider.value ==
                                                    entry.key
                                                ? 0.9
                                                : 0.4,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          Positioned(
                              top: 230.h,
                              left: 80.w,
                              child: Container(
                                width: 200.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    color: boxColor,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Center(
                                  child: Text(models.name!,
                                      style: GoogleFonts.poppins(
                                        color: buttonColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1),
                                ),
                              ))
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  width: context.width,
                  height: 100.h,
                  // color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: boxColor),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.access_time_outlined,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 5.h),
                            Text("Playtime",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500)),
                            SizedBox(height: 5.h),
                            Text("${detail.playtime} Hours",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: boxColor),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.dashboard,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 5.h),
                            Text("Category",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500)),
                            SizedBox(height: 5.h),
                            Text("${detail.genres![0].name}",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: boxColor),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 5.h),
                            Text("Rating",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500)),
                            SizedBox(height: 5.h),
                            Text("${detail.rating} Stars",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("About",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 20.sp)),
                ),
                // SizedBox(height: 5.sp),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ReadMoreText(
                    '${detail.description}'
                        .replaceAll("<p>", "")
                        .replaceAll("</p>", "")
                        .replaceAll("<br />", ""),
                    trimLines: 2,
                    // textAlign: TextAlign.,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            );
          },
        ));
  }
}
