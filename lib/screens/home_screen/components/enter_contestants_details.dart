import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:ldapp/models/game/game.dart';
import 'package:ldapp/utils/appcolors.dart';
import 'package:ldapp/widgets/custom_text_styles.dart';
import 'package:provider/provider.dart';

class EnterContestantsDetails extends StatelessWidget {
  const EnterContestantsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentGameIndex = Provider.of<Game>(context).currentGameIndex;
    Provider.of<Game>(context, listen: true)
        .getGameContestantsList(currentGameIndex);

    var contestantsList = Provider.of<Game>(context).gameContestantsList;

    var model = Provider.of<Game>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      // padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        addSemanticIndexes: false,
        semanticChildCount: 0,
        scrollDirection: Axis.vertical,
        itemCount: contestantsList.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        // itemExtent: 70,
        itemBuilder: (context, index) {
          return Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //ID
                Container(
                  color: const Color(0xC0383838),
                  width: 60,
                  height: 60,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: bodyTextStyle(),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                //Name
                SizedBox(
                  width: 250,
                  child: Row(
                    children: [
                      InkWell(
                        focusColor: Colors.black,
                        highlightColor: Colors.black,
                        hoverColor: Colors.black,
                        splashColor: Colors.black,
                        onDoubleTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: const Align(
                                        child: Text(
                                      'Edit Contestant Name',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    )),
                                    contentPadding: const EdgeInsets.only(
                                      top: 20,
                                      left: 20,
                                      right: 20,
                                    ),
                                    buttonPadding: const EdgeInsets.all(20),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color(0xff2940D3),
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Ok'),
                                      )
                                    ],
                                    content: SizedBox(
                                      width: 400,
                                      child: TextField(
                                        style: bodyTextStyle(),

                                        // keyboardType: TextInputType.multiline,
                                        // maxLines: null,
                                        onChanged: (value) {
                                          String nameValue;
                                          if (value.isNotEmpty) {
                                            nameValue = value.toString();
                                          } else {
                                            nameValue = 'name';
                                          }
                                          model.updateGameContestantName(
                                            gameIndex: currentGameIndex,
                                            contestantIndex: index,
                                            contestantName: nameValue,
                                          );
                                        },
                                        controller:
                                            TextEditingController.fromValue(
                                          TextEditingValue(
                                            text:
                                                // '${model.contestingList[index].name}',
                                                '${contestantsList[index].name}',
                                            selection: TextSelection.collapsed(
                                              offset:
                                                  '${contestantsList[index].name}'
                                                      .length,
                                            ),
                                          ),
                                        ),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              // color: Color(0xff2940D3),
                                              width: 1.5,
                                            ),
                                          ),
                                          constraints: BoxConstraints(
                                            maxWidth: 250,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              // color: Color(0xff2940D3),
                                              width: 1.5,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.decorationColor1,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              });
                        },
                        child: Container(
                          width: 190,
                          height: 60,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${contestantsList[index].name}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: bodyTextStyle(),
                          ),
                        ),
                      ),
                      IsContestTantOnFireSwitch(
                        currentGameIndex: currentGameIndex,
                        index: index,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                //PREDICTION BOX
                Expanded(
                  child: TextField(
                    style: bodyTextStyle(),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: '${contestantsList[index].prediction}',
                        selection: TextSelection.collapsed(
                          offset: '${contestantsList[index].prediction}'.length,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      int predictionValue;
                      if (value.isNotEmpty) {
                        predictionValue = int.parse(value);
                      } else {
                        predictionValue = 00;
                      }
                      model.updateGameContestantPrediction(
                          gameIndex: currentGameIndex,
                          contestantIndex: index,
                          contestantPrediction: predictionValue);
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(5),
                    ],
                    cursorColor: AppColors.decorationColor1,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.greenAccent,
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
                        minWidth: 60,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                //ROUND 1 TEXT FIELD
                Expanded(
                  child: TextField(
                    style: bodyTextStyle(),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: '${contestantsList[index].round1}',
                        selection: TextSelection.collapsed(
                          offset: '${contestantsList[index].round1}'.length,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      int round1Value;
                      if (value.isNotEmpty) {
                        round1Value = int.parse(value);
                      } else {
                        round1Value = 0;
                      }
                      model.updateGameContestantScores(
                        gameIndex: currentGameIndex,
                        contestantIndex: index,
                        round: 'round1',
                        contestantScore: round1Value,
                      );
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(5),
                    ],
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
                        minWidth: 60,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                //ROUND 2 TEXT FIELD
                Expanded(
                  child: TextField(
                    style: bodyTextStyle(),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: '${contestantsList[index].round2}',
                        selection: TextSelection.collapsed(
                          offset: '${contestantsList[index].round2}'.length,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      int round2Value;
                      if (value.isNotEmpty) {
                        round2Value = int.parse(value);
                      } else {
                        round2Value = 0;
                      }

                      model.updateGameContestantScores(
                        gameIndex: currentGameIndex,
                        contestantIndex: index,
                        round: 'round2',
                        contestantScore: round2Value,
                      );
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(5),
                    ],
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
                  ),
                ),

                const SizedBox(width: 20),

                //ROUND 3 TEXT FIELD
                Expanded(
                  child: TextField(
                    style: bodyTextStyle(),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: '${contestantsList[index].round3}',
                        selection: TextSelection.collapsed(
                          offset: '${contestantsList[index].round3}'.length,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      int round3Value;
                      if (value.isNotEmpty) {
                        round3Value = int.parse(value);
                      } else {
                        round3Value = 0;
                      }
                      model.updateGameContestantScores(
                        gameIndex: currentGameIndex,
                        contestantIndex: index,
                        round: 'round3',
                        contestantScore: round3Value,
                      );
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(5),
                    ],
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
                        minWidth: 60,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                //ROUND 4 TEXT FIELD
                Expanded(
                  child: TextField(
                    style: bodyTextStyle(),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: '${contestantsList[index].round4}',
                        selection: TextSelection.collapsed(
                          offset: '${contestantsList[index].round4}'.length,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      int round4Value;
                      if (value.isNotEmpty) {
                        round4Value = int.parse(value);
                      } else {
                        round4Value = 0;
                      }

                      model.updateGameContestantScores(
                        gameIndex: currentGameIndex,
                        contestantIndex: index,
                        round: 'round4',
                        contestantScore: round4Value,
                      );
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(5),
                    ],
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
                        minWidth: 60,
                      ),
                    ),
                  ),
                ),
                /*          
  */
                const SizedBox(width: 20),

                //TotalScore
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
                        radius: 15,
                        colors: [
                          Color(0xC0383838),
                          AppColors.decorationColor2,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${contestantsList[index].round1 + contestantsList[index].round2 + contestantsList[index].round3 + contestantsList[index].round4}',
                        style: bodyTextStyle(),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                //Delete Button
                SizedBox(
                  // width: 30,
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      model.deleteGameContestant(
                          gameIndex: currentGameIndex, contestantIndex: index);
                    },
                  ),
                ),

                //End Of Row
              ],
            ),
          );

          //Return inside listview Stop Here
        },
      ),
    );
  }
}

class IsContestTantOnFireSwitch extends StatefulWidget {
  int currentGameIndex;
  int index;
  IsContestTantOnFireSwitch(
      {Key? key, required this.currentGameIndex, required this.index})
      : super(key: key);

  @override
  State<IsContestTantOnFireSwitch> createState() =>
      _IsContestTantOnFireSwitchState();
}

class _IsContestTantOnFireSwitchState extends State<IsContestTantOnFireSwitch> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(
      builder: (context, model, child) {
        return FlutterSwitch(
          activeText: '🔥',
          activeTextColor: Colors.white,
          showOnOff: true,
          activeColor: Colors.green.shade200,
          inactiveTextColor: Colors.white,
          inactiveText: '❄️',
          inactiveColor: Colors.blueGrey,
          width: 60,
          height: 30,
          value: model.gameContestantsList[widget.index].isContestantOnFire,
          onToggle: (value) {
            setState(() {
              status = value;

              model.isGameContestantOnFire(
                gameIndex: widget.currentGameIndex,
                contestantIndex: widget.index,
                isContestantOnFire: status,
              );
            });
          },
        );
      },
    );
  }
}
