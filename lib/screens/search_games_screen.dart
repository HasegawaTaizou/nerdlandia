import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projeto_nerdlandia/models/cart.dart';
import 'package:projeto_nerdlandia/models/game.dart';
import 'package:projeto_nerdlandia/models/game_list.dart';
import 'package:projeto_nerdlandia/widgets/badge.dart';
import 'package:projeto_nerdlandia/widgets/game_grid.dart';
import 'package:projeto_nerdlandia/widgets/navigation_drawer.dart';
import 'package:projeto_nerdlandia/widgets/search_widget.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorite,
  All,
}

class SearchGamesScreen extends StatefulWidget {
  SearchGamesScreen({Key key}) : super(key: key);

  @override
  _SearchGamesScreenState createState() => _SearchGamesScreenState();
}

class _SearchGamesScreenState extends State<SearchGamesScreen> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;
  List<Game> games = [];
  String query = '';
  Timer debouncer;

  @override
  void initState() {
    super.initState();
    Provider.of<GameList>(
      context,
      listen: false,
    ).loadProducts().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final games = await GameList.getGames(query);

    setState(() => this.games = games);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nerdlândia'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/shopping-cart');
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          buildSearch(),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : GameGrid(_showFavoriteOnly),
          ),
        ],
      ),
      drawer: AppDrawer(),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Nome do Jogo',
        onChanged: searchGame,
      );

  Future searchGame(String query) async => debounce(
        () async {
          final games = await GameList.getGames(query);

          if (!mounted) return;

          setState(
            () {
              this.query = query;
              this.games = games;
            },
          );
        },
      );
}
