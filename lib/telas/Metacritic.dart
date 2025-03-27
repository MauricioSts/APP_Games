import 'package:app_consulta_games/Api.dart';
import 'package:app_consulta_games/model/Game.dart';
import 'package:flutter/material.dart';

class Metacritic extends StatefulWidget {
  const Metacritic({super.key});

  @override
  State<Metacritic> createState() => _MetacriticState();
}

class _MetacriticState extends State<Metacritic> {
  late Future<List<Game>> futureGames;

  @override
  void initState() {
    super.initState();
    futureGames = pesquisarJogosTopMetacritic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Top Jogos Metacritic")),
      body: Center(
        child: FutureBuilder<List<Game>>(
          future: futureGames,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Game> games = snapshot.data!;

              if (games.isEmpty) {
                return const Text("Nenhum jogo encontrado.");
              }

              return ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: Image.network(
                        games[index].imagem,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => const Icon(
                              Icons.image_not_supported,
                              size: 100,
                            ),
                      ),
                      title: Text(
                        games[index].titulo,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Nota Metacritic: ${games[index].metacritic}",
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
