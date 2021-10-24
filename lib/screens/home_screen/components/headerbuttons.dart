import 'package:flutter/material.dart';
import 'package:ldapp/models/contestant.dart';
import 'package:ldapp/utils/svg_codes.dart';
import 'package:ldapp/widgets/custom_button.dart';
import 'package:ldapp/widgets/custom_text_styles.dart';
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
    var contestantDb = Provider.of<Contestant>(context, listen: false);
    showDialog(
        context: context,
        barrierLabel: 'ADD NEW CONTESTANT',
        builder: (context) {
          return Dialog(
            child: Container(
              // height: 300,
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
                        IconButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await contestantDb.addNewContestant(
                                //Adds New Contestant To the hive Database
                                Contestant(
                                  name: _nameController!.text,
                                ),
                              );

                              _nameController!.clear();

                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.check),
                          iconSize: 25,
                          color: Colors.green,
                          splashColor: Colors.greenAccent,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                          color: Colors.red,
                          iconSize: 25,
                          splashColor: Colors.redAccent,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
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

          // Button to LeaderBoards Screen
          CustomButton(
            name: 'LeaderBoard',
            svgIconCode: leaderBoardIcon,
            onPressed: () {
              Navigator.pushNamed(context, 'leaderboard');
            },
          )
        ],
      ),
    );
  }
}
