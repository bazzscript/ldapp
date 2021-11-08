//Titles And Game Name
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ldapp/models/game/game.dart';
import 'package:ldapp/utils/appcolors.dart';
import 'package:ldapp/utils/svg_codes.dart';
import 'package:provider/provider.dart';

class TitlesAndGameNameWithLogo extends StatelessWidget {
  const TitlesAndGameNameWithLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<Game>(context).currentGameIndex;
    Provider.of<Game>(context).activeGameName(currentIndex);
    var gameName = Provider.of<Game>(context).activegamename;

    return Container(
      // height: 155,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FINAL LEADERBOARD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                gameName.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.secondaryAppColor1,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const Spacer(),
          Image.asset(
            'assets/logo/logo.png',
            fit: BoxFit.fill,
            cacheHeight: 90,
            // width: 200,
            height: 90,
          ),
          const SizedBox(width: 10),
          SvgPicture.string(
            leaderBoardIcon,
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}
