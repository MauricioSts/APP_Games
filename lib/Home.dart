import 'package:app_consulta_games/telas/Descontos.dart';
import 'package:app_consulta_games/telas/Metacritic.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [Metacritic(), Descontos()];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Games v.Alfa.01",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Container(padding: EdgeInsets.all(16), child: telas[_indiceAtual]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice) {
          setState(() {
            _indiceAtual = indice;
          });
        },

        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.amber,
        items: const [
          BottomNavigationBarItem(
            label: "Metacritic",
            icon: Icon(Icons.trending_up_outlined),
          ),
          BottomNavigationBarItem(
            label: "Descontos",
            icon: Icon(Icons.attach_money_outlined),
          ),
        ],
      ),
    );
  }
}
