import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/achievement_page_controller.dart';

class AchievementPageView extends GetView<AchievementPageController> {
  const AchievementPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AchievementPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AchievementPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
