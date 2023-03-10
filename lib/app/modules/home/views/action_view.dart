import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:game_database/app/data/models/game_models.dart';
import 'package:game_database/app/modules/home/controllers/home_controller.dart';
import 'package:game_database/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ActionView extends GetView<HomeController> {
  final Future<List<dynamic>> actions;
  const ActionView({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: actions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return SizedBox(
          width: context.width,
          height: 150,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              GameModels models = snapshot.data?[index] ?? "";
              return GestureDetector(
                onTap: () =>
                    Get.toNamed(Routes.DETAIL_GAME, arguments: models),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 150,
                        color: Colors.grey,
                        child: CachedNetworkImage(
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
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "${models.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
