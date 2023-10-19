import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_database/app/data/constant/color.dart';
import 'package:game_database/app/data/constant/utils.dart';
import 'package:game_database/app/data/models/archievement.dart';
import 'package:game_database/app/data/models/game_models.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/achievement_page_controller.dart';

class AchievementPageView extends GetView<AchievementPageController> {
  const AchievementPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GameModels models = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'All Achievement ${models.name}',
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
        body: PagedListView<int, ArchievementGame>.separated(
          padding: const EdgeInsets.all(10),
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
          pagingController: controller.gameAchievement,
          builderDelegate: PagedChildBuilderDelegate<ArchievementGame>(
            itemBuilder: (context, game, index) {
              return Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(18),
                color: isDarkmode.isTrue ? boxColor : whiteBox,
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage("${game.image}")),
                  title: Text(
                    "${game.name}",
                    style: GoogleFonts.poppins(
                        color: isDarkmode.isTrue ? buttonColor : darkTextColor),
                  ),
                  subtitle: Text(
                    "${game.description}",
                    style: GoogleFonts.poppins(
                        color: isDarkmode.isTrue ? buttonColor : darkTextColor),
                  ),
                ),
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
                    Get.snackbar("No More Item", "No more Achievement Data",
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
