import 'package:app_consulta_games/Api.dart';
import 'package:app_consulta_games/model/Sale.dart';
import 'package:flutter/material.dart';

class Descontos extends StatefulWidget {
  const Descontos({super.key});

  @override
  State<Descontos> createState() => _DescontosState();
}

class _DescontosState extends State<Descontos> {
  late Future<List<Sale>> futureSales;

  @override
  void initState() {
    super.initState();
    futureSales = pesquisarJogosComDesconto(_valorPrimario);
  }

  double _valorPrimario = 0.2;
  String _labelValor = "Selecione um valor";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Top Jogos com desconto")),
      body: Column(
        children: [
          Slider(
            value: _valorPrimario,
            min: 0,
            max: 100,
            divisions: 10,
            label: _labelValor,
            activeColor: Colors.blueAccent,
            onChanged: (double value) {
              setState(() {
                _valorPrimario = value;
                _labelValor = value.toString();
              });
            },
          ),

          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
            onPressed: () {
              setState(() {
                futureSales = pesquisarJogosComDesconto(_valorPrimario);
              });
            },
            child: Text(
              "Procurar Desconto",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Sale>>(
              future: futureSales,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Sale> sales = snapshot.data!;

                  if (sales.isEmpty) {
                    return const Center(child: Text("Nenhum jogo encontrado."));
                  }

                  return ListView.builder(
                    itemCount: sales.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          leading: Image.network(
                            sales[index].imagem,
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
                            sales[index].nome,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Preço com desconto: ${sales[index].precoDescontado}",
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
