import 'package:flutter/material.dart';
import 'package:projeto_nerdlandia/models/auth.dart';
import 'package:projeto_nerdlandia/screens/auth_screen.dart';
import 'package:projeto_nerdlandia/screens/search_games_screen.dart';
import 'package:provider/provider.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return auth.isAuth ? SearchGamesScreen() : AuthScreen();
        }
      },
    );
  }
}
