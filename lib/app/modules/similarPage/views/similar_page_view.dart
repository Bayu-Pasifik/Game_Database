import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/similar_page_controller.dart';

class SimilarPageView extends GetView<SimilarPageController> {
  const SimilarPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimilarPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SimilarPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
