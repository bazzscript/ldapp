import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:ldapp/models/game/game.dart';
import 'package:ldapp/utils/svg_codes.dart';
import 'package:ldapp/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class HomeFooter extends StatefulWidget {
  const HomeFooter({Key? key}) : super(key: key);

  @override
  State<HomeFooter> createState() => _HomeFooterState();
}

class _HomeFooterState extends State<HomeFooter> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, model, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Button to Update Total Scores
            CustomButton(
              name: 'Update TotalScores',
              svgIconCode: leaderBoardIcon,
              textColor: Colors.white,
              primaryColor: Colors.green,
              onPressed: () async {
                await model
                    .updateGameContestantTotalScores(model.currentGameId);
              },
            ),

            // Switch To Toggle LeaderBoard Screen Status
            FlutterSwitch(
              //Active Checks
              activeText: 'LEADERBOARD ACTIVE',
              activeTextColor: Colors.white,
              activeColor: Colors.green,
              activeIcon: const Icon(
                Icons.check,
                color: Colors.green,
              ),

              //Inactive Checks
              inactiveText: 'LEADERBOARD INACTIVE',
              inactiveTextColor: Colors.white,
              inactiveColor: Colors.blueGrey,
              inactiveIcon: const Icon(
                Icons.close,
                color: Colors.blueGrey,
              ),
              //Switch Looks
              width: 400.0,
              height: 60.0,
              valueFontSize: 25.0,
              toggleSize: 45.0,
              value: model.activeGameLeaderBoardStatus,
              borderRadius: 12.0,
              padding: 10.0,
              showOnOff: true,

              //Funtion to run on toggle
              onToggle: (val) {
                setState(
                  () {
                    status = val;
                    // print(status);
                    model.activateOrDeactivateGameLeaderBoardScreen(
                      gameId: model.currentGameId,
                      activateGameLeaderBoard: status,
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
