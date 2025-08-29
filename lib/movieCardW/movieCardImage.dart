import 'package:flutter/material.dart';
import 'package:prog_lazy_f/imagesW/imagesForW.dart';

class MovieCardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: AssetImage(ImagesWidg.bigMovie)),
        Image(image: AssetImage(ImagesWidg.smalMovie)),
      ],
    );
  }
}
