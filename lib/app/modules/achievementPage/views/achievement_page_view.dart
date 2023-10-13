import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_database/app/data/constant/color.dart';
import 'package:game_database/app/data/models/archievement.dart';
import 'package:game_database/app/data/models/game_models.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
            style: GoogleFonts.poppins(color: textColor),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: textColor),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
          backgroundColor: darkTheme,
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
                color: boxColor,
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage("${game.image}")),
                  title: Text(
                    "${game.name}",
                    style: GoogleFonts.poppins(color: textColor),
                  ),
                  subtitle: Text(
                    "${game.description}",
                    style: GoogleFonts.poppins(color: textColor),
                  ),
                ),
              );
            },
            firstPageProgressIndicatorBuilder: (_) =>
                const Center(child: CircularProgressIndicator()),
            noItemsFoundIndicatorBuilder: (_) =>
                const Center(child: Text('No Data Available')),
          ),
        ));
  }
}
