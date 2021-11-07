import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SlideShowScreen extends StatelessWidget {
  const SlideShowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
          items: [
            Image.asset(
              'assets/images/w1.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Image.asset(
              'assets/images/w2.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Image.asset(
              'assets/images/w3.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Image.asset(
              'assets/images/w5.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ],
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1.0,
            autoPlayInterval: const Duration(milliseconds: 3000),
            autoPlayCurve: Curves.easeInOut,
          )),
    );
  }
}
