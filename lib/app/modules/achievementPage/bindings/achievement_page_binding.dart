import 'package:get/get.dart';

import '../controllers/achievement_page_controller.dart';

class AchievementPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AchievementPageController>(
      () => AchievementPageController(),
    );
  }
}
