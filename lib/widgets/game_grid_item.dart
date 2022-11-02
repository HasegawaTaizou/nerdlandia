import 'package:flutter/material.dart';
import 'package:projeto_nerdlandia/models/auth.dart';
import 'package:projeto_nerdlandia/models/cart.dart';
import 'package:projeto_nerdlandia/models/game.dart';
import 'package:provider/provider.dart';

class GameGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Game>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              'games-detail',
              arguments: product,
            );
          },
        ),
        footer: Column(
          children: [
            Container(
              color: Colors.black87,
              child: Text(
                '${product.name} - ${product.platformType}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            GridTileBar(
              backgroundColor: Colors.black87,
              leading: Consumer<Game>(
                builder: (ctx, product, _) => IconButton(
                  onPressed: () {
                    product.toggleFavorite(
                      auth.token ?? '',
                      auth.userId ?? '',
                    );
                  },
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  color: Theme.of(context).accentColor,
                ),
              ),
              title: Text(
                '${product.price.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  cart.addItem(product);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Produto adicionado com sucesso!'),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'DESFAZER',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
