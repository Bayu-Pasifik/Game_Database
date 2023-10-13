import 'package:get/get.dart';

import '../controllers/similar_page_controller.dart';

class SimilarPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SimilarPageController>(
      () => SimilarPageController(),
    );
  }
}
