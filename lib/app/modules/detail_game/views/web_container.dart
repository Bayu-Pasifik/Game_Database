import 'package:flutter/material.dart';
import 'package:game_database/app/data/models/detail_game.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebContainer extends StatelessWidget {
  const WebContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailGame detailGame = Get.arguments;
    print(detailGame.website);
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(detailGame.website!));
    return Scaffold(
      appBar: AppBar(title: Text("Web for ${detailGame.name}")),
      body: WebViewWidget(controller: controller),
    );
  }
}
