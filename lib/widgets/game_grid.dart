import 'package:flutter/material.dart';
import 'package:projeto_nerdlandia/models/game.dart';
import 'package:projeto_nerdlandia/models/game_list.dart';
import 'package:provider/provider.dart';

import 'game_grid_item.dart';

class GameGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  GameGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameList>(context);
    final List<Game> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: GameGridItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
