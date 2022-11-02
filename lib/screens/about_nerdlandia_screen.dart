import 'package:flutter/material.dart';

class AboutNerdlandiaScreen extends StatelessWidget {
  final textoSobreNerdlandia = '''
  A nerdLândia surgiu com o intuito de trazer 
  os melhores e mais variáveis jogos do mercado 
  pra você! Com plays para PC, Xbox e Playstation. 
  O aplicativo detém uma interface simples e 
  objetiva com ferramentas suficientes para sua 
  compra ou venda dos produtos. Este projeto foi 
  criado e desenvolvido por cinco programadores: 
  JL JD, JLM, JC, JR na específica data de 14/07/2020. 
  ''';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sobre a nerdLândia'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 20),
                      child: Text(
                        textoSobreNerdlandia,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/logoAbaixoInicioScreen.png',
                height: 210,
                width: 410,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
