import 'package:flutter/services.dart';
import 'package:ldapp/models/game/game.dart';
import 'package:ldapp/screens/auth_screen/create_new_game_screen/create_new_game_screen.dart';
import 'package:ldapp/screens/auth_screen/login_screen/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:ldapp/screens/home_screen/home_screen.dart';
import 'package:ldapp/screens/leaderboard_screen/leaderboard_screen.dart';
import 'package:provider/provider.dart';

main() async {
  //StartUp App
  runApp(const MyApp());

  // When app is ready to luanch do this
  doWhenWindowReady(
    () {
      // appWindow.hide();
      const initialSize = Size(1100, 600);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.title = 'Curtis Software';
      appWindow.show();
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Game(),
      child: MaterialApp(
        darkTheme: ThemeData(
          fontFamily: 'Nasaline',
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          scaffoldBackgroundColor: const Color(0xFF121212),
          backgroundColor: const Color(0xFF121212),
          primaryColor: Colors.black,
          iconTheme: const IconThemeData().copyWith(color: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => const LoginToGameScreen(),
          'create': (BuildContext context) => const CreateNewGameScreen(),
          'home': (BuildContext context) => const HomeScreen(),
          'leaderboard': (BuildContext context) => const LeaderBoardScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == 'home') {
            return PageTransition(
              child: const HomeScreen(),
              childCurrent: const LeaderBoardScreen(),
              type: PageTransitionType.rightToLeftJoined,
              settings: settings,
            );
          } else if (settings.name == 'leaderboard') {
            return PageTransition(
              child: const LeaderBoardScreen(),
              childCurrent: const HomeScreen(),
              type: PageTransitionType.rightToLeftJoined,
              settings: settings,
            );
          } else if (settings.name == 'login') {
            return PageTransition(
              child: const CreateNewGameScreen(),
              childCurrent: const LoginToGameScreen(),
              type: PageTransitionType.scale,
              settings: settings,
            );
          } else if (settings.name == 'create') {
            return PageTransition(
              child: const LoginToGameScreen(),
              childCurrent: const CreateNewGameScreen(),
              type: PageTransitionType.scale,
              settings: settings,
            );
          } else {
            return null;
          }
        },
      ),
    );
  }
}
