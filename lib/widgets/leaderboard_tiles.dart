import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LeaderBoardTiles extends StatelessWidget {
  const LeaderBoardTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //THE NUMBER
        Container(
          height: 70,
          width: 70,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFCD5EA),
                Color(0xFFFF90CB),
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              // stops: [1, 1],
            ),
          ),
          child: Text(
            '1',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.black),
          ),
        ),

        // THE SPACING BETWEEN NUMBERS AND NAMES
        const SizedBox(width: 10),

        //THE NAME AND ICON AND SCORES
        const ListTile(
          leading: Icon(
            Icons.stars,
            size: 40,
            color: Colors.black,
          ),
        )
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   height: 70,
        //   padding: EdgeInsets.all(15),
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Color(0xFFFF90CB),
        //         Color(0xFFFCD5EA),
        //       ],
        //       begin: Alignment.centerRight,
        //       end: Alignment.centerLeft,
        //       // stops: [1, 1],
        //     ),
        //   ),
        //   child: Row(
        //     children: [
        //       //The Icon Button
        //       Container(
        //         height: 50,
        //         width: 50,
        //         alignment: Alignment.center,
        //         decoration: const BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: Color(0x4D000000),
        //         ),
        //         child: const Icon(
        //           Icons.stars,
        //           size: 40,
        //           color: Colors.black,
        //         ),
        //       ),
        //       SizedBox(width: 20),
        //       Text(
        //         'John Snow'.toUpperCase(),
        //         // maxLines: 1,

        //         style: Theme.of(context)
        //             .textTheme
        //             .headline5!
        //             .copyWith(color: Colors.black),
        //       ),
        //       // Spacer(),
        //       Text(
        //         '12',
        //         style: Theme.of(context)
        //             .textTheme
        //             .headline5!
        //             .copyWith(color: Colors.black),
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
