import 'package:flutter/material.dart';

import 'package:ldapp/models/contestant/contestant.dart';
import 'package:ldapp/models/game/game.dart';
import 'package:ldapp/screens/home_screen/home_screen.dart';
import 'package:ldapp/screens/leaderboard_screen/leaderboard_screen.dart';

import 'package:ldapp/utils/svg_codes.dart';
import 'package:ldapp/widgets/custom_button.dart';
import 'package:ldapp/widgets/custom_text_styles.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HeaderButtons extends StatelessWidget {
  HeaderButtons({Key? key}) : super(key: key);
  final TextEditingController? _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //ADD NEW CONTESTANT MODAL / DAILOUGE WINDOW
  addnewContestantDailogue(
    BuildContext context,
    // String action,
    // [int? index]
  ) {
    showDialog(
        context: context,
        barrierLabel: 'ADD NEW CONTESTANT',
        barrierColor: Colors.black.withOpacity(0.7),
        builder: (context) {
          return Consumer<Game>(builder: (context, model, child) {
            return Dialog(
              child: Container(
                // height: 300,
                color: Colors.black,
                width: 400,
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //TextField To Enter Contestant Name
                      TextFormField(
                        style: bodyTextStyle(),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Contestant Name',
                        ),
                      ),

                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  /// Adds New Contestant To the hive Database
                                  model.addNewGameContestant(
                                      gameIndex: model.currentGameIndex,
                                      contestant: Contestant(
                                        name: _nameController!.text,
                                      ));

                                  _nameController!.clear();

                                  Navigator.pop(context);
                                }
                              },
                              icon: const Icon(Icons.check),
                              iconSize: 25,
                              color: Colors.green,
                              splashColor: Colors.greenAccent,
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close),
                              color: Colors.red,
                              iconSize: 25,
                              splashColor: Colors.redAccent,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Adds New Contestants
          CustomButton(
            name: 'Add Contestant',
            textColor: Colors.white,
            primaryColor: const Color(0xff2940D3),
            svgIconCode: addContestantIcon,
            onPressed: () {
              addnewContestantDailogue(context);
            },
          ),
          // const SizedBox(width: 40),

          // const SizedBox(width: 40),

          // Button to LeaderBoards Screen
          CustomButton(
            name: 'LeaderBoard',
            svgIconCode: leaderBoardIcon,
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeftJoined,
                  child: const LeaderBoardScreen(),
                  childCurrent: const HomeScreen(),
                  // duration: const Duration(seconds: 1),
                ),
              );
              // Navigator.pushNamed(context, 'leaderboard');
            },
          )
        ],
      ),
    );
  }
}
