import 'package:flutter/material.dart';

void main() {
  runApp(JogoDaVelhaApp());
}

class JogoDaVelhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: JogoDaVelhaTela(),
    );
  }
}

class JogoDaVelhaTela extends StatefulWidget {
  @override
  _JogoDaVelhaTelaState createState() => _JogoDaVelhaTelaState();
}

class _JogoDaVelhaTelaState extends State<JogoDaVelhaTela> {
  List<String> tabuleiro = ['', '', '', '', '', '', '', '', ''];
  bool vezJogadorX = true;

  void jogar(int index) {
    if (tabuleiro[index] == '') {
      setState(() {
        tabuleiro[index] = vezJogadorX ? 'X' : 'O';
        vezJogadorX = !vezJogadorX;
      });
      verificarVitoria();
    }
  }

  void verificarVitoria() {
    // Linhas
    for (int i = 0; i < 3; i++) {
      if (tabuleiro[i * 3] != '' &&
          tabuleiro[i * 3] == tabuleiro[i * 3 + 1] &&
          tabuleiro[i * 3] == tabuleiro[i * 3 + 2]) {
        mostrarVitoria(tabuleiro[i * 3]);
        return;
      }
    }

    // Colunas
    for (int i = 0; i < 3; i++) {
      if (tabuleiro[i] != '' &&
          tabuleiro[i] == tabuleiro[i + 3] &&
          tabuleiro[i] == tabuleiro[i + 6]) {
        mostrarVitoria(tabuleiro[i]);
        return;
      }
    }

    // Diagonais
    if (tabuleiro[0] != '' && tabuleiro[0] == tabuleiro[4] && tabuleiro[0] == tabuleiro[8]) {
      mostrarVitoria(tabuleiro[0]);
      return;
    }
    if (tabuleiro[2] != '' && tabuleiro[2] == tabuleiro[4] && tabuleiro[2] == tabuleiro[6]) {
      mostrarVitoria(tabuleiro[2]);
      return;
    }

    // Empate
    if (!tabuleiro.contains('')) {
      mostrarEmpate();
    }
  }

  void mostrarVitoria(String vencedor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Vitória!'),
          content: Text('O jogador $vencedor venceu!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetarJogo();
              },
              child: Text('Jogar novamente'),
            ),
          ],
        );
      },
    );
  }

  void mostrarEmpate() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Empate!'),
          content: Text('O jogo terminou em empate.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetarJogo();
              },
              child: Text('Jogar novamente'),
            ),
          ],
        );
      },
    );
  }

  void resetarJogo() {
    setState(() {
      tabuleiro = ['', '', '', '', '', '', '', '', ''];
      vezJogadorX = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jogo da Velha')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => jogar(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      tabuleiro[index],
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Text(
            vezJogadorX ? 'Vez do jogador X' : 'Vez do jogador O',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
