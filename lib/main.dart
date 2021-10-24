import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ldapp/models/contestant.dart';
import 'package:ldapp/screens/home_screen/home_screen.dart';
import 'package:ldapp/screens/leaderboard_screen/leaderboard_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //Initialize the app local storage directory on the file system
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ContestantAdapter());

  //StartUp App
  runApp(const MyApp());

  // When app is ready to luanch do this
  doWhenWindowReady(() {
    const initialSize = Size(1100, 600);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'Curtis Software';
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Contestant(),
      child: MaterialApp(
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          scaffoldBackgroundColor: const Color(0xFF121212),
          backgroundColor: const Color(0xFF121212),
          primaryColor: Colors.black,
          iconTheme: const IconThemeData().copyWith(color: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => const HomeScreen(),
          'leaderboard': (BuildContext context) => const LeaderBoardScreen(),
        },
      ),
    );
  }
}
