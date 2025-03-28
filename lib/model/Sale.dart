class Sale {
  String nome;
  double precoDescontado;
  double precoNormal;
  String imagem;

  Sale(this.nome, this.precoDescontado, this.precoNormal, this.imagem);

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      json["title"] ?? "sem titulo",
      double.tryParse(json["salePrice"] ?? "0") ?? 0,
      double.tryParse(json["normalPrice"] ?? "0") ?? 0,
      json["thumb"] ?? "",
    );
  }
}
