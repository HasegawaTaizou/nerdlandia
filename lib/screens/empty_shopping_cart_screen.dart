import 'package:flutter/material.dart';

class EmptyShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _searchGames() {
      Navigator.of(context).pushNamed('/search-games');
    }

    return Container(
      width: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Carrinho(0)'),
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
                    'assets/images/zumbiCarrinhoCompraVazioScreen.png',
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
                  'Seu carrinho está vazio !',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Não sabe o que comprar?',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Milhares de produtos esperam por você !',
                  style: TextStyle(fontSize: 15),
                ),
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
