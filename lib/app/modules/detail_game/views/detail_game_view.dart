import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game_database/app/data/constant/color.dart';
import 'package:game_database/app/data/models/archievement.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/data/models/screenshot_game.dart';
import 'package:game_database/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../controllers/detail_game_controller.dart';

class DetailGameView extends GetView<DetailGameController> {
  const DetailGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GameModels models = Get.arguments;
    print("id:${models.id}");
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
                          // ! DOT for corousel
                          Positioned(
                            top: 200.h,
                            left: 120.w,
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
                                          vertical: 10,
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
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.angleLeft,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                onPressed: () {
                                  Get.toNamed(Routes.WEB_CONTAINER,
                                      arguments: detail);
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.globe,
                                  color: Colors.white,
                                ),
                              )
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
                  child: Text("Synopsis",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 20.sp)),
                ),
                // ! Synopsis
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ReadMoreText(
                    '${detail.description}'
                        .replaceAll("<p>", "")
                        .replaceAll("</p>", "")
                        .replaceAll("<br />", ""),
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: buttonColor),
                    moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: buttonColor),
                  ),
                ),
                SizedBox(height: 10.h),
                ExpandablePanel(
                  theme: ExpandableThemeData(iconColor: textColor),
                  collapsed: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                        "You can view more information about this game here",
                        style: GoogleFonts.poppins(color: textColor)),
                  ),
                  header: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "About Game",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                  ),
                  expanded: Table(
                    border: TableBorder.all(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: textColor),
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Original Title",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            (detail.nameOriginal != "")
                                ? "${detail.nameOriginal}"
                                : "${detail.name}",
                            style: GoogleFonts.poppins(),
                          ),
                        )
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Genres",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: detail.genres!
                                  .map((item) => Text("${item.name}"))
                                  .toList()),
                        )
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "released",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            controller.formatDate(detail.released!),
                            style: GoogleFonts.poppins(),
                          ),
                        )
                      ]),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Developer",
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: detail.developers!.map((item) {
                                return Text(
                                  item.name!,
                                  style: GoogleFonts.poppins(),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Publisher",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: detail.publishers!
                                  .map((item) => Text(item.name!,
                                      style: GoogleFonts.poppins()))
                                  .toList()),
                        )
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Availabel at",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: detail.platforms!
                                  .map((item) => Text("${item.platform!.name}"))
                                  .toList()),
                        )
                      ]),
                    ],
                  ),
                ),
                // ! Archievement
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Achievement",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.ACHIEVEMENT_PAGE,
                                    arguments: models);
                              },
                              child: Text(
                                "Load More",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ))
                        ])),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 150.h,
                    width: context.width,
                    // color: Colors.green,
                    child: FutureBuilder<List<ArchievementGame>>(
                      future: controller.archievementGame(detail.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No Screenshots Available'));
                        }

                        return ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10.h,
                          ),
                          itemBuilder: (context, index) {
                            final archivement = snapshot.data![index];
                            return Material(
                              elevation: 20,
                              color: boxColor,
                              child: ListTile(
                                leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(archivement.image!)),
                                title: Text(archivement.name!,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white)),
                                subtitle: Text(archivement.description!,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white)),
                                isThreeLine: true,
                              ),
                            );
                          },
                          itemCount: 2,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                // ! Same Series
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Same Series",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.SIMILAR_PAGE,
                                    arguments: models);
                              },
                              child: Text(
                                "Load More",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ))
                        ])),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 300.h,
                    width: context.width,
                    // color: Colors.green,
                    child: FutureBuilder<List<GameModels>>(
                      future: controller.sameSeries(detail.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No Screenshots Available'));
                        }

                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10.h,
                          ),
                          itemBuilder: (context, index) {
                            final sameSeries = snapshot.data![index];
                            // print("${sameSeries.backgroundImage}");
                            return Column(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: 100.w,
                                    height: 200.h,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Get.toNamed(Routes.DETAIL_GAME,
                                        //     arguments: game);
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${sameSeries.backgroundImage}",
                                        imageBuilder:
                                            (context, imageProvider) =>
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
                                ),
                                Expanded(
                                  child: Container(
                                    width: 100.w,
                                    height: 100.h,
                                    child: Text(
                                      "${sameSeries.name}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              overflow: TextOverflow.ellipsis)),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: snapshot.data?.length ?? 0,
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
