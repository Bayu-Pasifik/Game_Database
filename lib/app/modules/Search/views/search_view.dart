import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search Game'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // padding: const EdgeInsets.all(10),
              children: [
                TextField(
                  controller: controller.searchC,
                  onChanged: (value) {
                    controller.searchLength.value =
                        controller.searchC.text.length;
                    controller.isTextpresent.value = controller.searchC.text;
                    if (value.length >= 3) {
                      controller.result.clear();
                      controller.resultQuery(value, controller.hal.value);
                    } else if (value.isEmpty) {
                      controller.result.clear();
                      controller.resultQuery("", controller.hal.value);
                    }
                  },
                  decoration: InputDecoration(
                      suffixIcon: Obx(
                        () => IconButton(
                          onPressed: (controller.searchLength.value == 0)
                              ? null
                              : () {
                                  controller.searchLength.value = 0;
                                  controller.isTextpresent.value = '';
                                  print(
                                      "panjang text ketika value emphty :${controller.searchLength.value}");
                                  controller.result.clear();
                                  controller.searchC.clear();
                                  controller.resultQuery(
                                      "", controller.hal.value);
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
                Expanded(
                  child: GetBuilder<SearchController>(
                    builder: (c) {
                      return SizedBox(
                        width: context.width,
                        height: context.height,
                        // color: Colors.amber,
                        child: SmartRefresher(
                          controller: c.refreshResult,
                          onRefresh: () => c.refreshData(c.searchC.text),
                          onLoading: () => c.loadData(c.searchC.text),
                          enablePullDown: true,
                          enablePullUp: true,
                          child: ListView.separated(
                              primary: true,
                              shrinkWrap: true,
                              physics: const PageScrollPhysics(),
                              itemBuilder: (context, index) {
                                GameModels models = c.result[index];
                                return GestureDetector(
                                  onTap: () => Get.toNamed(Routes.DETAIL_GAME,
                                      arguments: models),
                                  child: Material(
                                    elevation: 1,
                                    child: ListTile(
                                      leading: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CachedNetworkImage(
                                          imageUrl: "${models.backgroundImage}",
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
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      title: Text("${models.name}"),
                                      subtitle:
                                          Text("${models.playtime} hours"),
                                      isThreeLine: true,
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemCount: c.result.length),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
