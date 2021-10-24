import 'package:flutter/material.dart';
import 'package:ldapp/screens/leaderboard_screen/components/column_label.dart';
import 'package:ldapp/screens/leaderboard_screen/components/leaderboaders_list.dart';
import 'package:ldapp/screens/leaderboard_screen/components/titles_and_game_name.dart';
import 'package:ldapp/utils/appcolors.dart';
import 'package:ldapp/widgets/custom_window_bar.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //The Close, Maximize and Minimize Buttons
            const CustomWindowTitleBarBox(),

            //Titles And Game Name
            const TitlesAndGameNameWithLogo(),

            //The Pinkish Divider
            const Divider(thickness: 6, color: AppColors.secondaryAppColor1),

            const ColumnLabel(),

            //List of LeaderBoarders
            const Expanded(child: LeaderBoardersList()),

            //Your WebPage Or Other Notes
            Text(
              // 'ANY REMARK FROM ADMIN'.toUpperCase(),
              '',
              // maxLines: 1,

              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
