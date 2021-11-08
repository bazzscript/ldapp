import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ldapp/models/game/game.dart';
import 'package:provider/provider.dart';

class SlideShowScreen extends StatelessWidget {
  const SlideShowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentGameIndex = Provider.of<Game>(context).currentGameIndex;
    Provider.of<Game>(context, listen: true)
        .getGameSlideshowImages(currentGameIndex);

    List fileImageList = Provider.of<Game>(context).gameSlideshowImages;
    var assetImageList = [
      'assets/images/w1.jpg',
      'assets/images/w2.jpg',
      'assets/images/w3.jpg',
      'assets/images/w5.jpg'
    ];

    // var model = Provider.of<Game>(context);
    // print('from slideshow page');
    // print(model.gameSlideshowImages);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
          items: fileImageList.map((fileImage) {
            return Image.file(
              File(fileImage),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1.0,
            autoPlayInterval: const Duration(milliseconds: 30000),
            autoPlayCurve: Curves.easeInOut,
          )),
    );
  }
}
