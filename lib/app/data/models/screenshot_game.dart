// To parse this JSON data, do
//
//     final screenshotGame = screenshotGameFromJson(jsonString);

import 'dart:convert';

ScreenshotGame screenshotGameFromJson(String str) => ScreenshotGame.fromJson(json.decode(str));

String screenshotGameToJson(ScreenshotGame data) => json.encode(data.toJson());

class ScreenshotGame {
    ScreenshotGame({
        this.id,
        this.image,
        this.width,
        this.height,
        this.isDeleted,
    });

    int? id;
    String? image;
    int? width;
    int? height;
    bool? isDeleted;

    factory ScreenshotGame.fromJson(Map<String, dynamic> json) => ScreenshotGame(
        id: json["id"],
        image: json["image"],
        width: json["width"],
        height: json["height"],
        isDeleted: json["is_deleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "width": width,
        "height": height,
        "is_deleted": isDeleted,
    };
}
