// To parse this JSON data, do
//
//     final archievementGame = archievementGameFromJson(jsonString);

import 'dart:convert';

ArchievementGame archievementGameFromJson(String str) => ArchievementGame.fromJson(json.decode(str));

String archievementGameToJson(ArchievementGame data) => json.encode(data.toJson());

class ArchievementGame {
    ArchievementGame({
        this.id,
        this.name,
        this.description,
        this.image,
        this.percent,
    });

    int? id;
    String? name;
    String? description;
    String? image;
    String? percent;

    factory ArchievementGame.fromJson(Map<String, dynamic> json) => ArchievementGame(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        percent: json["percent"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "percent": percent,
    };
}
