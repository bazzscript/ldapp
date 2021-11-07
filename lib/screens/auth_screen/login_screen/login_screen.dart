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

class LoginToGameScreen extends StatefulWidget {
  const LoginToGameScreen({Key? key}) : super(key: key);

  @override
  State<LoginToGameScreen> createState() => _LoginToGameScreenState();
}

class _LoginToGameScreenState extends State<LoginToGameScreen> {
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
    // context.watch<Game>().getGameList();
    // var _gamesList = context.select((Game p) => p.gamesList);

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

                      Consumer<Game>(builder: (context, model, child) {
                        // context.watch<Game>().getGameList();
                        var _gameList = model.gamesList;

                        return Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 200),

                                SizedBox(
                                  // height: 60,
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
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: _gameNameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter A Game Name';
                                      } else if (checkifGameNameExists(
                                              _gameList, value) ==
                                          false) {
                                        return 'Game Name Does Not Exist';
                                      }
                                      return null;
                                    },
                                    inputFormatters: const <TextInputFormatter>[
                                      // LengthLimitingTextInputFormatter(20),
                                    ],
                                    cursorColor: AppColors.decorationColor1,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: const EdgeInsets.all(30),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 10,
                                        ),
                                      ),
                                      // contentPadding: EdgeInsets.all(5),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Colors.greenAccent,
                                          width: 10,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Colors.greenAccent,
                                          width: 10,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
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

                                //Login Button
                                SizedBox(
                                  width: 350,
                                  child: CustomButton(
                                    name: 'LOGIN TO GAME',
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var gameName =
                                            _gameNameController!.text;
                                        int activeGameIndex =
                                            _gameList.indexWhere(
                                          (element) =>
                                              element.gamename == gameName,
                                        );
                                        model.currentGameIndex =
                                            activeGameIndex;
                                        _gameNameController!.clear();

                                        Navigator.popAndPushNamed(
                                            context, 'home');
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //     settings:
                                        //         RouteSettings(name: "HOME"),
                                        //     builder: (context) => HomeScreen(),
                                        //   ),
                                        // );
                                        // Navigator.push(
                                        //   context,
                                        //   PageTransition(
                                        //     type: PageTransitionType.rotate,
                                        //     child: const HomeScreen(),
                                        //     childCurrent: LoginToGameScreen(),
                                        //     duration:
                                        //         const Duration(seconds: 1),
                                        //   ),
                                        // );
                                      }
                                    },
                                    svgIconCode: loginToGameIcon,
                                    textColor: Colors.white,
                                    primaryColor: const Color(0xff2940D3),
                                  ),
                                ),

                                const SizedBox(height: 25),

                                //Create New Game Instead Text Button
                                InkWell(
                                  onTap: () {
                                    Navigator.popAndPushNamed(
                                        context, 'create');

                                    // Navigator.push(
                                    //   context,
                                    //   PageTransition(
                                    //     type: PageTransitionType.scale,
                                    //     child: const CreateNewGameScreen(),
                                    //     childCurrent: const LoginToGameScreen(),
                                    //     // duration: const Duration(seconds: 1),
                                    //   ),
                                    // );
                                  },
                                  child: const Text(
                                    'Create New Game Instead',
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
                        );
                      }),

                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
