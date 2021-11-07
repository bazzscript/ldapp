import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ldapp/models/game/game.dart';
import 'package:ldapp/screens/leaderboard_screen/components/column_label.dart';
import 'package:ldapp/screens/leaderboard_screen/components/leaderboaders_list.dart';
import 'package:ldapp/screens/leaderboard_screen/components/titles_and_game_name.dart';
import 'package:ldapp/screens/leaderboard_screen/slideshow_page.dart';
import 'package:ldapp/utils/appcolors.dart';
import 'package:ldapp/widgets/custom_window_bar.dart';
import 'package:provider/provider.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //     int currentIndex = Provider.of<Game>(context).currentGameIndex;
    // Provider.of<Game>(context).activeGameName(currentIndex);
    // var activeGameLea = Provider.of<Game>(context).activegamename;

    bool isLeaderboardActive =
        Provider.of<Game>(context).activeGameLeaderBoardStatus;
    //  whattoshow() {
    //     Widget lt;
    //     if (Provider.of<Game>(context).isgameLeaderBoardActive == true) {
    //       return lt = Expanded(child: LeaderBoardersList());
    //     } else if (Provider.of<Game>(context).isgameLeaderBoardActive == false) {
    //       return lt = Expanded(child: SlideShowScreen());
    //     }

    //   }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/kingofgames2.jpg',
              fit: BoxFit.cover,
            ),
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //The Close, Maximize and Minimize Buttons
                      const CustomWindowTitleBarBox(),

                      isLeaderboardActive
                          ? Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  //Titles And Game Name
                                  TitlesAndGameNameWithLogo(),

                                  //The Pinkish Divider
                                  Divider(
                                      thickness: 6,
                                      color: AppColors.secondaryAppColor1),

                                  ColumnLabel(),

                                  //List of LeaderBoarders
                                  Expanded(child: LeaderBoardersList()),

                                  SizedBox(height: 20),
                                ],
                              ),
                            )
                          : const Expanded(child: SlideShowScreen()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
