import 'package:game_database/app/data/models/detail_game.dart';
import 'package:game_database/app/data/models/genres.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  String apikey = "7a395681502b437d8cbc489ebee68c6c";

  Uri url = Uri.parse('https://api.rawg.io/api/genres?key=$apikey');
  var response = await http.get(url);
  var tempdata = json.decode(response.body)['results'];
  var data = tempdata.map((e) => Genres.fromJson(e)).toList();
  print(data[0].name);
  // print("isi details ${tempdata.description}");
  // return tempdata;
}
