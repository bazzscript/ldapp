import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ldapp/models/game/game.dart';

import 'package:ldapp/utils/appcolors.dart';
import 'package:ldapp/utils/svg_codes.dart';
import 'package:ldapp/utils/utilfunction.dart';
import 'package:ldapp/widgets/custom_button.dart';
import 'package:ldapp/widgets/custom_window_bar.dart';

import 'package:provider/provider.dart';

class CreateNewGameScreen extends StatefulWidget {
  const CreateNewGameScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewGameScreen> createState() => _CreateNewGameScreenState();
}

class _CreateNewGameScreenState extends State<CreateNewGameScreen> {
  final TextEditingController? _gameNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      ///Your function Can just go here
      await Provider.of<Game>(context, listen: false).getGameList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
    //   ///Your function Can just go here

    // });

    // print(gameList);
    return Consumer<Game>(
      builder: (context, model, child) {
        var _gameList = model.gamesList;

        return Scaffold(
          backgroundColor: Colors.black,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/kingofgames.jpg',
                  fit: BoxFit.cover,
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Container(
                      color: Colors.black.withOpacity(0.8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //The Close, Maximize and Minimize Buttons
                          const CustomWindowTitleBarBox(),

                          Form(
                            key: _formKey,
                            child: Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 200),
                                    SizedBox(
                                      width: 500,
                                      child: TextFormField(
                                        cursorWidth: 5,
                                        cursorHeight: 5,
                                        style: const TextStyle(
                                          fontSize: 40.0,
                                          height: 2,
                                          color: Colors.white,
                                          fontFamily: 'MineCraft',
                                          letterSpacing: 3,
                                        ),
                                        // maxLines: null,
                                        // expands: true,
                                        textAlignVertical:
                                            TextAlignVertical.center,

                                        controller: _gameNameController,

                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter A Game Name';
                                          } else if (checkifGameNameExists(
                                                  _gameList, value) ==
                                              true) {
                                            return 'Game Name Already Exists';
                                          }
                                          return null;
                                        },
                                        textAlign: TextAlign.center,

                                        inputFormatters: const <
                                            TextInputFormatter>[
                                          // LengthLimitingTextInputFormatter(20),
                                        ],
                                        cursorColor: AppColors.decorationColor1,
                                        // textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.all(30),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 10,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.greenAccent,
                                              width: 10,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.greenAccent,
                                              width: 10,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: AppColors.decorationColor1,
                                              width: 4,
                                            ),
                                          ),
                                          constraints: const BoxConstraints(
                                            maxWidth: 60,
                                            minWidth: 60,
                                            // minHeight: 100,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 50),

                                    //Create New game Button
                                    SizedBox(
                                      width: 380,
                                      child: CustomButton(
                                        name: 'CREATE NEW GAME',
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await model.createNewGame(
                                              Game(
                                                gamename:
                                                    _gameNameController!.text,
                                                gameContestants: [],
                                                gameStanbySlideshowImages: [],
                                                isgameLeaderBoardActive: false,
                                              ),
                                            );
                                            _gameNameController!.clear();
                                            Navigator.popAndPushNamed(
                                              context,
                                              'login',
                                            );
                                            // Navigator.push(
                                            //   context,
                                            //   PageTransition(
                                            //     type: PageTransitionType.rotate,
                                            //     child:
                                            //         const LoginToGameScreen(),

                                            //     // duration: const Duration(seconds: 1),
                                            //   ),
                                            // );
                                          }
                                        },
                                        svgIconCode: addContestantIcon,
                                        textColor: Colors.white,
                                        primaryColor: const Color(0xff2940D3),
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    //Login To Existing Game Instead
                                    InkWell(
                                      onTap: () {
                                        Navigator.popAndPushNamed(
                                            context, 'login');
                                        // Navigator.push(
                                        //   context,
                                        //   PageTransition(
                                        //     type: PageTransitionType.rotate,
                                        //     childCurrent:
                                        //         const CreateNewGameScreen(),
                                        //     child: const LoginToGameScreen(),
                                        //     // duration: const Duration(seconds: 1),
                                        //   ),
                                        // );
                                      },
                                      child: const Text(
                                        'Login To Existing Game Instead',
                                        style: TextStyle(
                                          color: AppColors.secondaryAppColor1,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


                    
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),};
//     );
//   }
// }
