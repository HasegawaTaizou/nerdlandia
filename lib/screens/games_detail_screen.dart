import 'package:flutter/material.dart';
import 'package:projeto_nerdlandia/models/game.dart';

class GamesDetailScreen extends StatelessWidget {
  const GamesDetailScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Game product = ModalRoute.of(context).settings.arguments as Game;
    return Scaffold(
      appBar: AppBar(
        title: Text('${product.name} - ${product.platformType}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 65),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${product.name.toUpperCase()} - ${product.platformType}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'R\$ ${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              width: double.infinity,
              child: Text(
                'Restrição de Idade: ${product.ageRestriction}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              width: double.infinity,
              child: Text(
                'Gênero: ${product.gender}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, bottom: 30),
              width: double.infinity,
              child: Text(
                product.description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
