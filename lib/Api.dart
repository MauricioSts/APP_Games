import 'package:app_consulta_games/model/Game.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Game>> pesquisarJogosTopMetacritic() async {
  final response = await http.get(
    Uri.parse(
      'https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=50',
    ),
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);

    List<Game> jogos = jsonData.map((item) => Game.fromJson(item)).toList();

    jogos = jogos.where((game) => game.metacritic > 0).toList();

    jogos.sort((a, b) => b.metacritic.compareTo(a.metacritic));

    return jogos;
  } else {
    throw Exception("Falha ao buscar os jogos");
  }
}
