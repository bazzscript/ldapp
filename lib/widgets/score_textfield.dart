import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ldapp/models/game/game.dart';
import 'package:ldapp/utils/appcolors.dart';
import 'package:ldapp/widgets/custom_text_styles.dart';
import 'package:provider/provider.dart';

class ScoreTextField extends StatelessWidget {
  // Game Id
  final int gameId;

  // contestantIndex
  final int contestantindex;

  // what round ?
  final String round;

  /// Custom Contestants Score Textfield
  const ScoreTextField({
    Key? key,
    required this.gameId,
    required this.contestantindex,
    required this.round,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      // Functionality

      // What Should Happen When User Enters A Score
      onChanged: (value) async {
        int roundValue;
        if (value.isNotEmpty) {
          roundValue = int.parse(value);
        } else {
          roundValue = 0;
        }
        await Provider.of<Game>(context, listen: false)
            .updateGameContestantScores(
          gameId: gameId,
          contestantIndex: contestantindex,
          round: round,
          contestantScore: roundValue,
        );
      },
      //Design And Behaviour
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        LengthLimitingTextInputFormatter(4),
      ],
      style: bodyTextStyle(),
      cursorColor: AppColors.decorationColor1,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(5),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.decorationColor2,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.decorationColor1,
            width: 1.5,
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: 60,
        ),
      ),
    );
  }
}
