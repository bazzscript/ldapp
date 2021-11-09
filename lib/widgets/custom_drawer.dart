import 'package:flutter/material.dart';
import 'package:ldapp/models/game/game.dart';
import 'package:ldapp/utils/appcolors.dart';
import 'package:ldapp/widgets/custom_text_styles.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  /// A CUSTOM DRAWER
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    int currentGameIndex = Provider.of<Game>(context).currentGameIndex;
    var model = Provider.of<Game>(context);

    return Container(
      color: Colors.black,
      child: Column(
        children: [
          /// DRAWER CLOSE BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                tooltip: 'close drawer',
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          ///BODY
          /// change homepage background
          // ElevatedButton(
          //   onPressed: () async {
          //     await getImagePath();
          //     setState(() {});
          //   },
          //   child: Text('Change Background'),
          // ),
          const SizedBox(height: 40),

          //Change Game Name
          ElevatedButton(
            onPressed: () {
              ///
              ///
              ///
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: const Align(
                            child: Text(
                          'Update Game Name',
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
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('UPDATE'),
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
                                nameValue = 'curtis game';
                              }
                              model.changeGameName(
                                gameIndex: currentGameIndex,
                                gamename: nameValue,
                              );
                            },
                            controller: TextEditingController.fromValue(
                              TextEditingValue(
                                text:
                                    // '${model.contestingList[index].name}',
                                    model.activegamename,
                                selection: TextSelection.collapsed(
                                  offset: model.activegamename.length,
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

              ///
              ///
              ///
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff2940D3),
            ),
            child: const Text(
              'Change Game Name',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          //Upload Game Slideshow Images
          ElevatedButton(
            onPressed: () async {
              await model.changeGameSlideshowImages(currentGameIndex);
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff2940D3),
            ),
            child: const Text(
              'Upload SlideShow Images',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),

          const Spacer(),
          //Log Out Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () {
              Navigator.popAndPushNamed(context, 'login');
              // Navigator.of(context).popUntil(ModalRoute.withName("login"));
            },
            child: const Text(
              'LOG OUT',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 45),
        ],
      ),
    );
  }
}
