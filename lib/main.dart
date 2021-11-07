import 'dart:io';
import 'package:flutter/services.dart';
import 'package:ldapp/models/contestant/contestant.dart';
import 'package:ldapp/models/game/game.dart';
import 'package:ldapp/screens/auth_screen/create_new_game_screen/create_new_game_screen.dart';
import 'package:ldapp/screens/auth_screen/login_screen/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ldapp/screens/home_screen/home_screen.dart';
import 'package:ldapp/screens/leaderboard_screen/leaderboard_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //Initialize the app local storage directory on the file system
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(GameAdapter());
  Hive.registerAdapter(ContestantAdapter());

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
      create: (_) => Game(),
      child: MaterialApp(
        darkTheme: ThemeData(
          fontFamily: 'Nasaline',
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          scaffoldBackgroundColor: const Color(0xFF121212),
          backgroundColor: const Color(0xFF121212),
          primaryColor: Colors.black,
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            headline2: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            headline4: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            headline5: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            button: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            caption: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            overline: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
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
