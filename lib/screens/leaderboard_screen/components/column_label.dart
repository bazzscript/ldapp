//Column Label
import 'package:flutter/material.dart';

class ColumnLabel extends StatelessWidget {
  const ColumnLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 80,
        top: 40,
        bottom: 10,
      ),
      child: Row(
        children: const [
          Spacer(),
          Text(
            'NAME',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Spacer(),
          Text(
            'SCORE',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
