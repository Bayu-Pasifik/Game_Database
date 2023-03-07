import 'package:game_database/app/data/models/detail_game.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  String apikey = "7a395681502b437d8cbc489ebee68c6c";

  Uri url = Uri.parse('https://api.rawg.io/api/games/3498?key=$apikey');
  var response = await http.get(url);
  var data = json.decode(response.body);
  var tempdata = DetailGame.fromJson(data);
  print("isi details ${tempdata.description}");
  // return tempdata;
}
