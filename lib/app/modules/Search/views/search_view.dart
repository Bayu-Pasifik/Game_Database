import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_database/app/data/constant/color.dart';
import 'package:game_database/app/data/constant/utils.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchC> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search Game'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: isDarkmode.isTrue ? boxColor : whiteBox,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: controller.searchC,
                  onChanged: (value) {
                    // controller.searchLength.value =
                    //     controller.searchC.text.length;
                    // controller.isTextpresent.value = controller.searchC.text;
                    // if (value.length >= 3) {
                    //   controller.clearSearch();
                    //   controller.resultQuery(
                    //       value, controller.listSearch.firstPageKey);
                    //   print(
                    //       "panjang listSearch pagging controller: ${controller.listSearch.itemList?.length}");
                    // } else if (value.isEmpty) {
                    //   controller.clearSearch();
                    //   controller.resultQuery(
                    //       "", controller.listSearch.firstPageKey);
                    //   print(
                    //       "panjang listSearch pagging controller: ${controller.listSearch.itemList?.length}");
                    // }
                  },
                  decoration: InputDecoration(
                      suffixIcon: Obx(
                        () => IconButton(
                          onPressed: (controller.searchLength.value == 0)
                              ? null
                              : () {
                                  controller.isTextpresent.value = '';
                                  print(
                                      "panjang text ketika value emphty :${controller.searchLength.value}");
                                  controller.clearSearch();
                                  controller.searchC.clear();
                                  controller.resultQuery(
                                      "", controller.listSearch.firstPageKey);
                                  print(
                                      "panjang listSearch pagging controller: ${controller.listSearch.itemList?.length}");
                                },
                          icon: (controller.isTextpresent.value == '')
                              ? const Icon(Icons.search)
                              : const Icon(Icons.disabled_by_default),
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(height: 10),
                Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.clearSearch();
                        controller.resultQuery(controller.searchC.text,
                            controller.listSearch.firstPageKey);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9))),
                          backgroundColor:
                              isDarkmode.isTrue ? boxColor : whiteBox),
                      child: Text(
                        "Search",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: isDarkmode.isTrue
                                ? buttonColor
                                : darkTextColor),
                      ),
                    )),
                const SizedBox(height: 10),
                Expanded(
                    child: PagedListView<int, GameModels>.separated(
                  padding: const EdgeInsets.all(10),
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  pagingController: controller.listSearch,
                  builderDelegate: PagedChildBuilderDelegate<GameModels>(
                    itemBuilder: (context, game, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.DETAIL_GAME, arguments: game);
                        },
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(9),
                          color: isDarkmode.isTrue ? boxColor : whiteBox,
                          child: ListTile(
                            leading: SizedBox(
                              width: 50.w,
                              height: 100.h,
                              child: CachedNetworkImage(
                                imageUrl: "${game.backgroundImage}",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        "assets/images/Image_not_available.png"),
                              ),
                            ),
                            title: Text(
                              "${game.name}",
                              style: GoogleFonts.poppins(
                                  color: isDarkmode.isTrue
                                      ? buttonColor
                                      : darkTextColor),
                            ),
                            subtitle: Text(
                              "${game.playtime} Hours",
                              style: GoogleFonts.poppins(
                                  color: isDarkmode.isTrue
                                      ? buttonColor
                                      : darkTextColor),
                            ),
                          ),
                        ),
                      );
                    },
                    firstPageProgressIndicatorBuilder: (_) => Center(
                        child: LoadingAnimationWidget.twoRotatingArc(
                            color: isDarkmode.isTrue ? boxColor : whiteBox,
                            size: 70)),
                    noItemsFoundIndicatorBuilder: (_) =>
                        const Center(child: Text('No Data Available')),
                    noMoreItemsIndicatorBuilder: (_) => Obx(
                      () {
                        if (controller.noMoreItems.value) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            Get.snackbar(
                                "No More Item", "No more Achievement Data",
                                colorText: darkTextColor,
                                overlayBlur: 5,
                                backgroundColor:
                                    isDarkmode.isTrue ? boxColor : whiteBox,
                                snackPosition: SnackPosition.BOTTOM,
                                isDismissible: true,
                                dismissDirection: DismissDirection.startToEnd,
                                icon: const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                                shouldIconPulse: true,
                                barBlur: 1,
                                duration: const Duration(seconds: 3));
                          });
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    newPageProgressIndicatorBuilder: (_) => Center(
                      child: LoadingAnimationWidget.twoRotatingArc(
                          color: isDarkmode.isTrue ? boxColor : whiteBox,
                          size: 70),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
