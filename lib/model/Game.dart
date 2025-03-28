class Game {
  String titulo;
  String imagem;
  int metacritic;

  Game(this.titulo, this.imagem, this.metacritic);

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      json["title"] ?? "Sem título",
      json["thumb"] ?? "", // Imagem do jogo
      int.tryParse(json["metacriticScore"] ?? "0") ??
          0, // Conversão segura para int
    );
  }
}
