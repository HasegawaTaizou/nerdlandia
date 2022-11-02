import 'package:flutter/material.dart';

class EmptyPurchaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _searchGames() {
      Navigator.of(context).pushNamed('/search-games');
    }

    return Container(
      width: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Minhas Compras'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Image.asset(
                    'assets/images/demonioComprasVazioScreen.png',
                    height: 330,
                    width: 330,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 26.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Text(
                  'Você ainda não comprou nada !',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '''Deixe-nos ajudar você a encontrar o que
                      está buscando''',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: _searchGames,
                  child: Text(
                    'Buscar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
