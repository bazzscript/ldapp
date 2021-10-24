import 'package:flutter/material.dart';
import 'package:ldapp/screens/home_screen/components/columns_label.dart';
import 'package:ldapp/screens/home_screen/components/enter_contestants_details.dart';
import 'package:ldapp/screens/home_screen/components/headerbuttons.dart';
import 'package:ldapp/utils/appcolors.dart';
import 'package:ldapp/widgets/custom_window_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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

            //Add Contestants Button and LeaderBoards Screen Button
            HeaderButtons(),

            //The Pinkish Divider
            const Divider(thickness: 6, color: AppColors.secondaryAppColor1),

            const SizedBox(height: 20),
            const ColumnsLabel(),
            const SizedBox(height: 5),

            //Enter Contestants Details Body
            const Expanded(child: EnterContestantsDetails()),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
