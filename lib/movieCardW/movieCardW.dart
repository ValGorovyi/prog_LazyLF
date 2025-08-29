import 'package:flutter/material.dart';
import 'package:prog_lazy_f/imagesW/imagesForW.dart';

class MovieCarsW extends StatefulWidget {
  final int id;

  MovieCarsW({super.key, required this.id});

  @override
  State<MovieCarsW> createState() => _MovieCarsWState();
}

class _MovieCarsWState extends State<MovieCarsW> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 88, 96),

      appBar: AppBar(title: Text('Tony Hawk undeground 2')),
      body: ColoredBox(
        color: Color.fromARGB(24, 25, 27, 1),
        child: ListView(
          children: [
            _TopPosterW(),
            SizedBox(height: 20),
            AboutMovie(),
            SizedBox(height: 20),

            DetailsCatdW(),
          ],
        ),
      ),
    );
  }
}

class _TopPosterW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage(ImagesWidg.bigMovie),
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: Image(image: AssetImage(ImagesWidg.smalMovie)),
        ),
      ],
    );
  }
}

class AboutMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichText(
              maxLines: 3,

              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Tony Hawk undeground 2',
                    style: TextStyle(color: TextCardWColor.mainColor),
                  ),
                  WidgetSpan(child: SizedBox(width: 10)),
                  TextSpan(
                    text: 'Film duration: 2 : 15',
                    style: TextStyle(color: TextCardWColor.secondColor),
                  ),
                ],
              ),
              // children: [
              //   Text('Tony Hawk undeground 2'),
              //   SizedBox(width: 10),
              //   Text('Film duration: 2 : 15'),
              // ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.data_thresholding_outlined,
              semanticLabel: 'Statistick - 82%',
            ),
            Icon(Icons.play_arrow_rounded, semanticLabel: 'Play triler'),
          ],
        ),
        SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Anthony Frank Hawk (born May 12, 1968), nicknamed Birdman, is an American professional skateboarder, entrepreneur, and the owner of the skateboard company Birdhouse.',
            style: TextStyle(color: TextCardWColor.mainColor),
          ),
        ),
        SizedBox(height: 60),
      ],
    );
  }
}

class DetailsCatdW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overview', style: TextStyle(color: TextCardWColor.mainColor)),
          SizedBox(height: 40),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Director',
                    style: TextStyle(color: TextCardWColor.secondColor),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Rodney Moolen',
                    style: TextStyle(color: TextCardWColor.mainColor),
                  ),
                ],
              ),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Music by',
                    style: TextStyle(color: TextCardWColor.secondColor),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Ozzy Osbourne',
                    style: TextStyle(color: TextCardWColor.mainColor),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

abstract class TextCardWColor {
  static Color mainColor = const Color.fromARGB(255, 203, 201, 201);
  static Color secondColor = const Color.fromARGB(255, 139, 137, 137);
}
