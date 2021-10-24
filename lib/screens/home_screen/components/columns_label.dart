//Column Label
import 'package:flutter/material.dart';

class ColumnsLabel extends StatelessWidget {
  const ColumnsLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        children: const [
          SizedBox(
            width: 60,
            // height: 60,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'S/N',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          SizedBox(
            width: 250,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'NAME',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'PREDICTION',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'ROUND 1',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'ROUND 2',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'ROUND 3',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'ROUND 4',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'TOTAL SCORE',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 55),
        ],
      ),
    );
  }
}
