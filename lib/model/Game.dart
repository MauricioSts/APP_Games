class Game {
  String titulo;
  String imagem;
  int metacritic;
  String linkMetacritic;

  Game(this.titulo, this.imagem, this.metacritic, this.linkMetacritic);

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      json["title"] ?? "Sem título",
      json["thumb"] ?? "",
      json["metacriticScore"] != null ? int.parse(json["metacriticScore"]) : 0,
      json["metacriticLink"] != null
          ? "https://www.metacritic.com${json["metacriticLink"]}"
          : "",
    );
  }
}
