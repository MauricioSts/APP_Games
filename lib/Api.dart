import 'package:app_consulta_games/model/Game.dart';
import 'package:app_consulta_games/model/Sale.dart';
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

Future<List<Sale>> pesquisarJogosComDesconto(double descontoMinimo) async {
  final response = await http.get(
    Uri.parse(
      "https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=15",
    ),
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    List<Sale> deals = jsonData.map((item) => Sale.fromJson(item)).toList();

    deals =
        deals.where((sale) => sale.precoDescontado <= descontoMinimo).toList();

    return deals;
  } else {
    throw Exception("falha ao buscar desconto");
  }
}
