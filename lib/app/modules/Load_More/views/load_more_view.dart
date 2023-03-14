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
            ? Text("RPG".toUpperCase(), style: GoogleFonts.poppins())
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
      body: GetBuilder<LoadMoreController>(
        builder: (c) {
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.grid_on)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.list)),
                ],
              ),
              Container(
                width: context.width,
                height: context.height,
                // color: Colors.amber,
                child: SmartRefresher(
                  controller: c.refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onLoading: () => c.loadData(genres),
                  onRefresh: () => c.refreshData(genres),
                  child: ListView.separated(
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
                      itemCount: c.action.length),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
