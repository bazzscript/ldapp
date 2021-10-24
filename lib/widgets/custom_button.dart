import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ldapp/utils/appcolors.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Color textColor;
  final String svgIconCode;
  final void Function()? onPressed;
  final Color primaryColor;
  const CustomButton({
    Key? key,
    required this.name,
    required this.onPressed,
    this.textColor = Colors.black,
    this.primaryColor = AppColors.secondaryAppColor1,
    required this.svgIconCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        onPrimary: Colors.white,
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        // width: 140,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.string(
              svgIconCode,
              height: 60,
              width: 60,
            ),
            const SizedBox(width: 5),
            Text(
              name.toUpperCase(),
              maxLines: 1,
              style: TextStyle(
                color: textColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
