import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class CustomWindowTitleBarBox extends StatelessWidget {
  const CustomWindowTitleBarBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Container(
        color: Colors.black,
        child: Row(
          children: [
            //Makes Sure the Back Button is Only Shown the LeaderBoard Screen
            if ('${ModalRoute.of(context)!.settings.name}' == 'leaderboard')
              IconButton(
                iconSize: 20,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
            //Enables window dragging
            Expanded(
              child: MoveWindow(),
            ),

            //this includes the minimize and maximaize and close buttons in the window bar box
            const WindowButtons(),
          ],
        ),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
  iconMouseOver: Colors.white,
  iconNormal: Colors.white,
);

final closeButtonColors = WindowButtonColors(
  mouseOver: const Color(0xFFD32F2F),
  mouseDown: const Color(0xFFB71C1C),
  iconNormal: Colors.white,
  iconMouseOver: Colors.white,
);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(
          colors: buttonColors,
        ),
        MaximizeWindowButton(
          colors: buttonColors,
        ),
        CloseWindowButton(
          colors: closeButtonColors,
        ),
      ],
    );
  }
}
