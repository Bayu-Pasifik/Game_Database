import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_database/app/data/models/archievement.dart';
import 'package:game_database/app/data/models/detail_game.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/data/models/screenshot_game.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/detail_game_controller.dart';

class DetailGameView extends GetView<DetailGameController> {
  const DetailGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GameModels models = Get.arguments;
    return Scaffold(
        body: DefaultTabController(
      length: 4,
      child: CustomScrollView(
        // primary: true,
        // shrinkWrap: true,
        // physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromARGB(255, 250, 8, 8)),
              onPressed: () => Get.back(closeOverlays: true),
            ),
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("${models.name}"),
              background: CachedNetworkImage(
                imageUrl: models.backgroundImage!,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return FutureBuilder<DetailGame>(
                  future: controller.details(models.id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var date = DateTime.parse("${snapshot.data?.released!}");

                    return Column(
                      children: [
                        SizedBox(
                          width: context.width,
                          height: 130,
                          // color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 8, right: 8),
                            child: Center(
                              child: Table(
                                border: TableBorder.all(),
                                children: [
                                  TableRow(children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Release Date "),
                                    ),
                                    (snapshot.data!.released != null)
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "${date.day} - ${date.month} - ${date.year}"),
                                          )
                                        : const Text("Null")
                                  ]),
                                  TableRow(children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Rating"),
                                    ),
                                    (snapshot.data!.rating != null)
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "${snapshot.data!.rating} Of ${snapshot.data!.ratingTop}"),
                                          )
                                        : const Text("Null")
                                  ]),
                                  TableRow(children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Playtime"),
                                    ),
                                    (snapshot.data!.playtime != null)
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "${snapshot.data?.playtime} Hours"),
                                          )
                                        : const Text("Null")
                                  ]),
                                  TableRow(children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Publisher"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          "${snapshot.data!.publishers![0].name}"),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                        (snapshot.data!.publishers![0].name!.length >= 13)
                            ? const SizedBox(height: 20)
                            : const SizedBox(),
                        SizedBox(
                          width: context.width,
                          height: 50,
                          // color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              children: [
                                Text("Genre : ", style: GoogleFonts.poppins()),
                                for (var genre in models.genres!)
                                  Text("${genre.name} ",
                                      style: GoogleFonts.poppins()),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: context.width,
                          height: 30,
                          // color: Colors.blue,
                          child: const TabBar(
                              isScrollable: true,
                              labelColor: Colors.black,
                              tabs: [
                                Tab(text: "About Game"),
                                Tab(text: "Screenshots"),
                                Tab(text: "Archievement"),
                                Tab(text: "Same Series"),
                              ]),
                        ),
                        SizedBox(
                          width: context.width,
                          height: context.height,
                          child: TabBarView(children: [
                            // ! about
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                Bidi.stripHtmlIfNeeded(
                                    snapshot.data!.descriptionRaw!),
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            // ! SS
                            FutureBuilder<List<dynamic>>(
                              future: controller.screenshot(snapshot.data!.id!),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                return GridView.builder(
                                  primary: true,
                                  shrinkWrap: true,
                                  physics: const PageScrollPhysics(),
                                  padding: const EdgeInsets.all(10),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 150,
                                          childAspectRatio: 1 / 1.6,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 20),
                                  itemCount: snapshot.data?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    ScreenshotGame screenshotGame =
                                        snapshot.data![index];
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            width: 200,
                                            height: 200,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${screenshotGame.image}",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
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
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            // ! Achievement
                            GetBuilder<DetailGameController>(
                              builder: (c) {
                                return SmartRefresher(
                                  controller: c.archieveRefresh,
                                  enablePullDown: true,
                                  enablePullUp: true,
                                  onLoading: () =>
                                      c.loadArchieve(snapshot.data!.id!),
                                  onRefresh: () =>
                                      c.refreshArchieve(snapshot.data!.id!),
                                  child: ListView.separated(
                                      primary: true,
                                      shrinkWrap: true,
                                      physics: const PageScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        ArchievementGame archievementGame =
                                            c.archievement[index];
                                        return ListTile(
                                          leading: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${archievementGame.image}",
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
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          title:
                                              Text("${archievementGame.name}"),
                                          subtitle: Text(
                                              "${archievementGame.description}"),
                                          isThreeLine: true,
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 10),
                                      itemCount: c.archievement.length),
                                );
                              },
                            ),
                            // ! Similar
                            GetBuilder<DetailGameController>(
                              builder: (c) {
                                return SmartRefresher(
                                    controller: c.sameRefresh,
                                    enablePullDown: true,
                                    enablePullUp: true,
                                    onLoading: () =>
                                        c.loadSimilar(snapshot.data!.id!),
                                    onRefresh: () =>
                                        c.refrshSimilar(snapshot.data!.id!),
                                    child: (c.same.isNotEmpty)
                                        ? GridView.builder(
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
                                            itemCount: controller.same.length,
                                            itemBuilder: (context, index) {
                                              GameModels models =
                                                  controller.same[index];
                                              return Column(
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      // color: Colors.red,
                                                      width: 200,
                                                      height: context.height,
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              "${models.backgroundImage}",
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                          ),
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      downloadProgress) =>
                                                                  Center(
                                                            child: CircularProgressIndicator(
                                                                value: downloadProgress
                                                                    .progress),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${models.name}",
                                                    style: GoogleFonts.poppins(
                                                        textStyle: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis)),
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        : const Center(
                                            child: Text("There is no data"),
                                          ));
                              },
                            )
                          ]),
                        )
                      ],
                    );
                  },
                );
              },
              childCount: 1,
            ),
          )
        ],
      ),
    ));
  }
}
