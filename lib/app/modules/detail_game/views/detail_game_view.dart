import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game_database/app/data/constant/color.dart';
import 'package:game_database/app/data/constant/utils.dart';
import 'package:game_database/app/data/models/archievement.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/data/models/screenshot_game.dart';
import 'package:game_database/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';

import '../controllers/detail_game_controller.dart';

class DetailGameView extends GetView<DetailGameController> {
  const DetailGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GameModels models = Get.arguments;
    print("id:${models.id}");
    print("id:${models.backgroundImage}");
    return (models.backgroundImage != "" &&
            models.rating != 0 &&
            models.playtime != 0)
        ? Scaffold(
            appBar: null,
            body: FutureBuilder(
              future: controller.details(models.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(child: LoadingAnimationWidget.twoRotatingArc(
                    color: isDarkmode.isTrue ? boxColor : whiteBox, size: 70));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No Screenshots Available'));
                }
                final detail = snapshot.data;
                return ListView(
                  children: [
                    Container(
                      height: 300.h,
                      width: context.width,
                      // color: Colors.amber,
                      child: FutureBuilder<List<ScreenshotGame>>(
                        future: controller.screenshot(detail!.id!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return  Center(
                                child: LoadingAnimationWidget.twoRotatingArc(
                    color: isDarkmode.isTrue ? boxColor : whiteBox, size: 70));
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No Screenshots Available'));
                          }

                          final ssGames = snapshot.data!;

                          return Stack(
                            children: [
                              (ssGames != [] || ssGames.isNotEmpty)
                                  ? CarouselSlider(
                                      options: CarouselOptions(
                                          scrollPhysics:
                                              const BouncingScrollPhysics(),
                                          viewportFraction: 1,
                                          height: 250.h,
                                          autoPlayInterval:
                                              const Duration(seconds: 4),
                                          autoPlay: true,
                                          onPageChanged: (index, reason) {
                                            controller.currentSlider.value =
                                                index;
                                          },
                                          autoPlayCurve:
                                              Curves.fastEaseInToSlowEaseOut),
                                      items: ssGames.map((ssGame) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Container(
                                              width: context.width,
                                              height: 250.h,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                ),
                                              ),
                                              child: (ssGames.isNotEmpty ||
                                                      ssGames != [])
                                                  ? Image.network(
                                                      ssGame.image ?? "",
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      "assets/images/Image_not_available.png"),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    )
                                  : Image.asset(
                                      "assets/images/Image_not_available.png"),
                              // ! DOT for corousel
                              Positioned(
                                top: 200.h,
                                left: 120.w,
                                child: (ssGames.isNotEmpty)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: ssGames
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          return GestureDetector(
                                            onTap: () => controller
                                                .carouselController
                                                .animateToPage(entry.key),
                                            child: Obx(
                                              () {
                                                return Container(
                                                  width: controller
                                                              .currentSlider
                                                              .value ==
                                                          entry.key
                                                      ? 30
                                                      : 8,
                                                  height: 8,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 10,
                                                    horizontal: 4.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                18)),
                                                    color: isDarkmode.isTrue
                                                        ? buttonColor
                                                            .withOpacity(
                                                            controller.currentSlider
                                                                        .value ==
                                                                    entry.key
                                                                ? 0.9
                                                                : 0.4,
                                                          )
                                                        : whiteBox.withOpacity(
                                                            controller.currentSlider
                                                                        .value ==
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
                                      )
                                    : const SizedBox(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    onPressed: (detail.website == null ||
                                            detail.website == "")
                                        ? () {}
                                        : () {
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
                                        color: isDarkmode.isTrue
                                            ? boxColor
                                            : whiteBox,
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Center(
                                      child: (models.name != null ||
                                              models.name != "")
                                          ? Text(models.name!,
                                              style: GoogleFonts.poppins(
                                                color: isDarkmode.isTrue
                                                    ? buttonColor
                                                    : darkTextColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1)
                                          : Text("NAN",
                                              style: GoogleFonts.poppins(
                                                color: isDarkmode.isTrue
                                                    ? buttonColor
                                                    : darkTextColor,
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
                                color: isDarkmode.isTrue ? boxColor : whiteBox),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  size: 50,
                                  color: isDarkmode.isTrue
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                                SizedBox(height: 5.h),
                                Text("Playtime",
                                    style: GoogleFonts.poppins(
                                        color: isDarkmode.isTrue
                                            ? buttonColor
                                            : darkTextColor,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(height: 5.h),
                                Text(
                                    (detail.playtime != 0)
                                        ? "${detail.playtime} Hours"
                                        : "0 Hours",
                                    style: GoogleFonts.poppins(
                                        color: isDarkmode.isTrue
                                            ? buttonColor
                                            : darkTextColor,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            height: 100.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                color: isDarkmode.isTrue ? boxColor : whiteBox),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.dashboard,
                                  size: 50,
                                  color: isDarkmode.isTrue
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                                SizedBox(height: 5.h),
                                Text("Category",
                                    style: GoogleFonts.poppins(
                                        color: isDarkmode.isTrue
                                            ? buttonColor
                                            : darkTextColor,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(height: 5.h),
                                Text(
                                    (detail.genres != [])
                                        ? "${detail.genres![0].name}"
                                        : "NAN",
                                    style: GoogleFonts.poppins(
                                        color: isDarkmode.isTrue
                                            ? buttonColor
                                            : darkTextColor,
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
                                color: isDarkmode.isTrue ? boxColor : whiteBox),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 50,
                                  color: isDarkmode.isTrue
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                                SizedBox(height: 5.h),
                                Text("Rating",
                                    style: GoogleFonts.poppins(
                                        color: isDarkmode.isTrue
                                            ? buttonColor
                                            : darkTextColor,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(height: 5.h),
                                Text(
                                    (detail.rating != 0)
                                        ? "${detail.rating} Stars"
                                        : "0 Stars",
                                    style: GoogleFonts.poppins(
                                        color: isDarkmode.isTrue
                                            ? buttonColor
                                            : darkTextColor,
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
                        (detail.description != "" || detail.description != null)
                            ? '${detail.description}'
                                .replaceAll("<p>", "")
                                .replaceAll("</p>", "")
                                .replaceAll("<br />", "")
                            : "NAN",
                        trimLines: 2,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        lessStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDarkmode.isTrue ? buttonColor : whiteBox),
                        moreStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDarkmode.isTrue ? buttonColor : whiteBox),
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ExpandablePanel(
                      theme: ExpandableThemeData(
                          iconColor:
                              isDarkmode.isTrue ? buttonColor : whiteThemeText),
                      collapsed: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            "You can view more information about this game here",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: isDarkmode.isTrue
                                  ? darkTextColor
                                  : whiteThemeText,
                            )),
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
                          color: isDarkmode.isTrue
                              ? darkTextColor
                              : whiteThemeText,
                        ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: (detail.genres != [])
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: detail.genres!
                                          .map((item) => Text("${item.name}"))
                                          .toList())
                                  : const Text("NAN"),
                            )
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Released",
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: (detail.released != null)
                                  ? Text(
                                      controller.formatDate(detail.released!),
                                      style: GoogleFonts.poppins(),
                                    )
                                  : const Text("NAN"),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: (detail.developers != [])
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children:
                                            detail.developers!.map((item) {
                                          return Text(
                                            item.name!,
                                            style: GoogleFonts.poppins(),
                                          );
                                        }).toList(),
                                      )
                                    : const Text("NAN"),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: (detail.publishers != [])
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: detail.publishers!
                                          .map((item) => Text(item.name!,
                                              style: GoogleFonts.poppins()))
                                          .toList())
                                  : const Text("NAN"),
                            )
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Available at",
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: (detail.platforms != [])
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: detail.platforms!
                                          .map((item) =>
                                              Text("${item.platform!.name}"))
                                          .toList())
                                  : const Text("NAN"),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.ACHIEVEMENT_PAGE,
                                        arguments: models);
                                  },
                                  child: Text(
                                    "Load More",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
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
                              return  Center(
                                  child: LoadingAnimationWidget.twoRotatingArc(
                    color: isDarkmode.isTrue ? boxColor : whiteBox, size: 70));
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('No Achievement Available'));
                            }

                            return ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10.h,
                              ),
                              itemBuilder: (context, index) {
                                final archivement = snapshot.data![index];
                                return Material(
                                  borderRadius: BorderRadius.circular(9),
                                  elevation: 20,
                                  color:
                                      isDarkmode.isTrue ? boxColor : whiteBox,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(archivement.image!)),
                                    title: Text(archivement.name!,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: isDarkmode.isTrue
                                              ? buttonColor
                                              : darkTextColor,
                                        )),
                                    subtitle: Text(archivement.description!,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: isDarkmode.isTrue
                                              ? buttonColor
                                              : darkTextColor,
                                        )),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.SIMILAR_PAGE,
                                        arguments: models);
                                  },
                                  child: Text(
                                    "Load More",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
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
                              return  Center(
                                  child: LoadingAnimationWidget.twoRotatingArc(
                    color: isDarkmode.isTrue ? boxColor : whiteBox, size: 70));
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('No Same Series Available'));
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
                                          child: (sameSeries.backgroundImage !=
                                                  "")
                                              ? CachedNetworkImage(
                                                  imageUrl:
                                                      "${sameSeries.backgroundImage}",
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          "assets/images/Image_not_available.png"),
                                                )
                                              : Image.asset(
                                                  "assets/images/Image_not_available.png"),
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
                                                  overflow:
                                                      TextOverflow.ellipsis)),
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
            ))
        : Scaffold(
            appBar: AppBar(
              title: Text("Error",
                  style: GoogleFonts.poppins(
                      color: isDarkmode.isTrue ? buttonColor : darkTextColor)),
              centerTitle: true,
              backgroundColor: (isDarkmode.isTrue) ? boxColor : whiteBox,
            ),
            body: Center(child: Lottie.asset("assets/lottie/not_found.json")),
          );
  }
}
