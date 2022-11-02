import 'package:flutter/material.dart';
import 'package:projeto_nerdlandia/models/game_list.dart';
import 'package:projeto_nerdlandia/widgets/navigation_drawer.dart';
import 'package:projeto_nerdlandia/widgets/product_item.dart';
import 'package:provider/provider.dart';

class MyAnnouncesScreen extends StatelessWidget {
  const MyAnnouncesScreen({Key key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<GameList>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final GameList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/create-announce',
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, i) => Column(
              children: [
                ProductItem(products.items[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
