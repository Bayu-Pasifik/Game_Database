import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_database/app/data/constant/color.dart';
import 'package:game_database/app/data/constant/utils.dart';
import 'package:game_database/app/data/models/game_models.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/similar_page_controller.dart';

class SimilarPageView extends GetView<SimilarPageController> {
  const SimilarPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Similar Game',
            style: GoogleFonts.poppins(color: darkTextColor),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: darkTextColor),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
          backgroundColor: isDarkmode.isTrue ? darkTheme : whiteBox,
        ),
        body: PagedGridView<int, GameModels>(
          padding: EdgeInsets.all(10.w),
          pagingController: controller.similarController,
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
                        // Get.toNamed(Routes.DETAIL_GAME,
                        //     arguments: game);
                      },
                      child: CachedNetworkImage(
                        imageUrl: "${game.backgroundImage}",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                            "assets/images/Image_not_available.png"),
                      ),
                    ),
                  ),
                  Text(
                    "${game.name}",
                    style: GoogleFonts.poppins(
                        textStyle:
                            const TextStyle(overflow: TextOverflow.ellipsis)),
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
            firstPageProgressIndicatorBuilder: (_) => Center(
                child: LoadingAnimationWidget.twoRotatingArc(
                    color: isDarkmode.isTrue ? boxColor : whiteBox, size: 70)),
            noItemsFoundIndicatorBuilder: (_) =>
                const Center(child: Text('No Data Available')),
            noMoreItemsIndicatorBuilder: (_) => Obx(
              () {
                if (controller.noMoreItems.value) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    Get.snackbar("No More Item", "No more similar games",
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
                  color: isDarkmode.isTrue ? boxColor : whiteBox, size: 70),
            ),
          ),
        ));
  }
}
