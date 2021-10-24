//Titles And Game Name
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ldapp/utils/appcolors.dart';
import 'package:ldapp/utils/svg_codes.dart';

class TitlesAndGameNameWithLogo extends StatelessWidget {
  const TitlesAndGameNameWithLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 155,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'FINAL LEADERBOARD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                ' ',
                style: TextStyle(
                  color: AppColors.secondaryAppColor1,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const Spacer(),
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
