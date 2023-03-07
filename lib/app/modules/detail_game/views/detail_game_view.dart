import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:game_database/app/data/models/detail_game.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/data/models/screenshot_game.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_game_controller.dart';

class DetailGameView extends GetView<DetailGameController> {
  const DetailGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GameModels models = Get.arguments;
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: CustomScrollView(
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
              title: Text("${models.name}", textScaleFactor: 1),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: context.width,
                          height: 200,
                          // color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                        : Text("Null")
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
                                        : Text("Null")
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
                                        : Text("Null")
                                  ]),
                                  TableRow(children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Publisher"),
                                    ),
                                    Wrap(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "${snapshot.data!.publishers![0].name}"),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  TableRow(children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Genre"),
                                    ),
                                    // for (var genre in snapshot.data!.genres!)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          "${snapshot.data!.genres![0].name}"),
                                    )
                                  ])
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: context.width,
                          height: 30,
                          // color: Colors.blue,
                          child: const TabBar(
                              // isScrollable: true,
                              labelColor: Colors.black,
                              tabs: [
                                Tab(text: "About Game"),
                                Tab(text: "Screenshots"),
                              ]),
                        ),
                        SizedBox(
                          width: context.width,
                          height: context.width,
                          child: TabBarView(children: [
                            // ! about
                            Text(
                              Bidi.stripHtmlIfNeeded(
                                  snapshot.data!.descriptionRaw!),
                              style: GoogleFonts.poppins(),
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
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 150,
                                          childAspectRatio: 1 / 1.2,
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
