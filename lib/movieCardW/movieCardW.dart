import 'package:flutter/material.dart';
import 'package:prog_lazy_f/imagesW/imagesForW.dart';
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart';
import 'package:prog_lazy_f/universalInherit/universalInheritNotifier.dart'
    show UniversalInheritNitifier;

class MovieCardW extends StatefulWidget {
  const MovieCardW({super.key});

  @override
  State<MovieCardW> createState() => _MovieCardWState();
}

class _MovieCardWState extends State<MovieCardW> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    UniversalInheritNitifier.read<MovieCardDetailsModel>(
      context,
    )?.setupLocate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 88, 96),

      appBar: AppBar(title: _AppTitleInDetailsW()),
      body: ColoredBox(
        color: Color.fromARGB(24, 25, 27, 1),
        child: ListView(
          children: [
            _TopPosterW(),
            SizedBox(height: 20),
            AboutMovie(),
            SizedBox(height: 20),

            DetailsCatdW(),
            ActorScrolingW(),
          ],
        ),
      ),
    );
  }
}

class _AppTitleInDetailsW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = UniversalInheritNitifier.watch<MovieCardDetailsModel>(
      context,
    );
    return Text(model?.movieDetails?.title ?? 'Loading...');
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
          SizedBox(height: 18),
        ],
      ),
    );
  }
}

class ActorScrolingW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text('Series Cart'),
          ),
          SizedBox(
            height: 300,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: 20,
                itemExtent: 120,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: EdgeInsetsGeometry.all(8),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,

                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: [
                            Image(image: AssetImage(ImagesWidg.actor)),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text('Manoj Kumar', maxLines: 1),
                                  Text(
                                    'Kumar was honoured with the Padma Shri in 1992 and Dadasaheb Phalke Award in 2015 by the Government of India for his contribution to Indian cinema and arts.',
                                    maxLines: 4,
                                  ),
                                  Text('Episots: 4', maxLines: 1),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: TextButton(
              onPressed: () {},
              child: Text('Full card & crew'),
            ),
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
