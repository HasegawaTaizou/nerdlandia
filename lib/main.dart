import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projeto_nerdlandia/screens/about_nerdlandia_screen.dart';
import 'package:projeto_nerdlandia/screens/auth_or_home_screen.dart';
import 'package:projeto_nerdlandia/screens/auth_screen.dart';
import 'package:projeto_nerdlandia/screens/create_announce_screen.dart';
import 'package:projeto_nerdlandia/screens/empty_bookmarks_screen.dart';
import 'package:projeto_nerdlandia/screens/empty_purchase_screen.dart';
import 'package:projeto_nerdlandia/screens/forgot_password_screen.dart';
import 'package:projeto_nerdlandia/screens/games_detail_screen.dart';
import 'package:projeto_nerdlandia/screens/my_announces_screen.dart';
import 'package:projeto_nerdlandia/screens/shopping_cart_screen.dart';
import 'package:provider/provider.dart';

import 'models/auth.dart';
import 'models/cart.dart';
import 'models/game_list.dart';
import 'models/order_list.dart';
import 'screens/empty_shopping_cart_screen.dart';
import 'screens/help_center_chat_terms_use.dart';
import 'screens/help_center_frequently_asked_questions_screen.dart';
import 'screens/help_center_rules_screen.dart';
import 'screens/help_center_tips_how_to_make_good_ad_screen.dart';
import 'screens/purchase_screen.dart';
import 'screens/search_games_screen.dart';
import 'screens/without_internet_screen.dart';

main() => runApp(NerdLandiaApp());

class _NerdLandiaAppState extends State<NerdLandiaApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, GameList>(
          create: (_) => GameList(),
          update: (ctx, auth, previous) {
            return GameList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [const Locale('pt', 'BR')],
        routes: {
          '/': (ctx) => AuthOrHomeScreen(),
          '/about-nerdlandia': (ctx) => AboutNerdlandiaScreen(),
          'auth-or-home': (ctx) => AuthOrHomeScreen(),
          '/create-announce': (ctx) => CreateAnnounceScreen(),
          '/empty-bookmarks': (ctx) => EmptyBookmarksScreen(),
          '/empty-purchase': (ctx) => EmptyPurchaseScreen(),
          '/empty-shopping-cart': (ctx) => EmptyShoppingCartScreen(),
          '/forgot-password': (ctx) => ForgotPasswordScreen(),
          'games-detail': (ctx) => GamesDetailScreen(),
          '/help-center-chat-terms-use': (ctx) =>
              HelpCenterChatTermsUseScreen(),
          '/help-center-frequently-asked-questions': (ctx) =>
              HelpCenterFrequentlyAskedQuestionsScreen(),
          '/help-center-rules': (ctx) => HelpCenterRulesScreen(),
          '/help-center-tips-how-to-make-good-ad': (ctx) =>
              HelpCenterTipsHowToMakeGoodAdScreen(),
          'my-announces': (ctx) => MyAnnouncesScreen(),
          'purchase': (ctx) => PurchaseScreen(),
          '/search-games': (ctx) => SearchGamesScreen(),
          '/shopping-cart': (ctx) => ShoppingCartScreen(),
          '/without-internet': (ctx) => WithoutInternetScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class NerdLandiaApp extends StatefulWidget {
  _NerdLandiaAppState createState() {
    return _NerdLandiaAppState();
  }
}
