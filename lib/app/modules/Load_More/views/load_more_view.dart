import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_database/app/data/models/game_models.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/load_more_controller.dart';

class LoadMoreView extends GetView<LoadMoreController> {
  const LoadMoreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String genres = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: (genres == "5")
            ? Text("RPG Game".toUpperCase(), style: GoogleFonts.poppins())
            : (genres == "59")
                ? Text("Massive Multiplayer Online Game".toUpperCase(),
                    style: GoogleFonts.poppins())
                : (genres == "28")
                    ? Text("Board Game".toUpperCase(),
                        style: GoogleFonts.poppins())
                    : (genres == "34")
                        ? Text("Educational Game".toUpperCase(),
                            style: GoogleFonts.poppins())
                        : Text('$genres Game'.toUpperCase(),
                            style: GoogleFonts.poppins()),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => controller.changeGrid(controller.isGrid.value),
          child: Obx(() => controller.isGrid.isTrue
              ? const Icon(Icons.grid_on)
              : const Icon(Icons.list))),
      body: GetBuilder<LoadMoreController>(
        builder: (c) {
          return Container(
            width: context.width,
            height: context.height,
            // color: Colors.amber,
            child: SmartRefresher(
              controller: c.refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onLoading: () => c.loadData(genres),
              onRefresh: () => c.refreshData(genres),
              child: (c.gridMode == false)
                  ? ListView.separated(
                      primary: true,
                      shrinkWrap: true,
                      physics: const PageScrollPhysics(),
                      itemBuilder: (context, index) {
                        GameModels models = c.action[index];
                        return ListTile(
                          leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: CachedNetworkImage(
                              imageUrl: "${models.backgroundImage}",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          title: Text("${models.name}"),
                          subtitle: Text("${models.playtime} hours"),
                          isThreeLine: true,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: c.action.length)
                  : GridView.builder(
                      primary: true,
                      shrinkWrap: true,
                      // physics: ,
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              childAspectRatio: 1 / 1.6,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20),
                      itemCount: controller.action.length,
                      itemBuilder: (context, index) {
                        GameModels models = controller.action[index];
                        return Column(
                          children: [
                            Expanded(
                              child: Container(
                                // color: Colors.red,
                                width: 200,
                                height: context.height,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: CachedNetworkImage(
                                    imageUrl: "${models.backgroundImage}",
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
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "${models.name}",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      overflow: TextOverflow.ellipsis)),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
