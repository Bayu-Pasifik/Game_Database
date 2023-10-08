// To parse this JSON data, do
//
//     final genres = genresFromJson(jsonString);

import 'dart:convert';

Genres genresFromJson(String str) => Genres.fromJson(json.decode(str));

String genresToJson(Genres data) => json.encode(data.toJson());

class Genres {
  int? id;
  String? name;
  String? slug;
  int? gamesCount;
  String? imageBackground;
  List<Game>? games;

  Genres({
    this.id,
    this.name,
    this.slug,
    this.gamesCount,
    this.imageBackground,
    this.games,
  });

  factory Genres.fromJson(Map<String, dynamic> json) => Genres(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        gamesCount: json["games_count"],
        imageBackground: json["image_background"],
        games: json["games"] == null
            ? []
            : List<Game>.from(json["games"]!.map((x) => Game.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "games_count": gamesCount,
        "image_background": imageBackground,
        "games": games == null
            ? []
            : List<dynamic>.from(games!.map((x) => x.toJson())),
      };
}

class Game {
  int? id;
  String? slug;
  String? name;
  int? added;

  Game({
    this.id,
    this.slug,
    this.name,
    this.added,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        added: json["added"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "added": added,
      };
}
