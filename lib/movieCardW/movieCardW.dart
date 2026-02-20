import 'package:flutter/material.dart';
import 'package:prog_lazy_f/domain/apiClient/apiClient.dart';
import 'package:prog_lazy_f/domain/entity/movieDetailsCredits.dart';
import 'package:prog_lazy_f/imagesW/imagesForW.dart';
import 'package:prog_lazy_f/movieCardW/circularProgressIndicator/circularProgressIndicator.dart'
    show CircularProgressCustom;
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
        child: _BodyCardW(),
      ),
    );
  }
}

class _BodyCardW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = UniversalInheritNitifier.watch<MovieCardDetailsModel>(
      context,
    );
    final movieDetails = model?.movieDetails;
    if (movieDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        _TopPosterW(),
        SizedBox(height: 20),
        AboutMovie(),
        SizedBox(height: 20),

        DetailsCatdW(),
        ActorScrolingW(),
      ],
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
    final model = UniversalInheritNitifier.watch<MovieCardDetailsModel>(
      context,
    );
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null
                ? Image.network(ApiClient.imageUrl(posterPath))
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class AboutMovie extends StatelessWidget {
  const AboutMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final model = UniversalInheritNitifier.watch<MovieCardDetailsModel>(
      context,
    );
    if (model == null) return const SizedBox.shrink();
    var year = model.movieDetails?.releaseDate?.year.toString();
    year = year != null ? ' ( $year )' : '000';
    final listOfTextDetails = <String>[];

    final reliseOfDate = model.movieDetails?.releaseDate;
    if (reliseOfDate != null) {
      listOfTextDetails.add(model.stringFromDate(reliseOfDate));
    }
    final productCountries = model.movieDetails?.productionCountries;
    if (productCountries != null && productCountries.isNotEmpty) {
      listOfTextDetails.add('(${productCountries.first.iso})');
    }
    final runtime = model.movieDetails?.runtime ?? 0;
    final durationOfMovie = Duration(minutes: runtime);
    final hours = durationOfMovie.inHours;
    final minutes = durationOfMovie.inMinutes.remainder(60);
    listOfTextDetails.add('${hours} h ${minutes} m');
    final genres = model.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      var listOfGenresName = <String>[];
      for (var genre in genres) {
        listOfGenresName.add(genre.name);
      }
      listOfTextDetails.add(listOfGenresName.join(', '));
    }
    final overview = model.movieDetails?.overview ?? '';

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
                    text: model.movieDetails?.title ?? '',
                    style: TextStyle(color: TextCardWColor.mainColor),
                  ),
                  WidgetSpan(child: SizedBox(width: 10)),
                  TextSpan(
                    text: year,
                    style: TextStyle(color: TextCardWColor.secondColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                CircularProgressCustom(),
                SizedBox(width: 8),
                Text('Users score'),
              ],
            ),
            const Row(
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  semanticLabel: 'Play triler',
                  size: 50,
                ),
                SizedBox(width: 8),
                Text('Play triler'),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            listOfTextDetails.join(' '),
            style: TextStyle(color: TextCardWColor.mainColor),
          ),
        ),

        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'Overview',
                style: TextStyle(color: TextCardWColor.mainColor),
              ),
              Text(overview),
            ],
          ),
        ),

        SizedBox(height: 10),
      ],
    );
  }
}

class DetailsCatdW extends StatelessWidget {
  const DetailsCatdW({super.key});

  @override
  Widget build(BuildContext context) {
    final model = UniversalInheritNitifier.watch<MovieCardDetailsModel>(
      context,
    );
    if (model == null) return SizedBox.shrink();
    final overview = model.movieDetails?.overview ?? '';
    var crew = model.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    var crewChunks = <List<Employee>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: crewChunks
            .map(
              (chank) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _CrewWidget(employes: chank),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CrewWidget extends StatelessWidget {
  final List<Employee> employes;
  const _CrewWidget({required this.employes});
  @override
  Widget build(BuildContext context) {
    final model = UniversalInheritNitifier.watch<MovieCardDetailsModel>(
      context,
    );
    if (model == null) return SizedBox.shrink();
    var crew = model.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    var crewChunks = <List<Employee>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: employes
          .map((employee) => _ColumnEmployeeW(employee: employee))
          .toList(),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Director',
      //       style: TextStyle(color: TextCardWColor.secondColor),
      //     ),
      //     Text(
      //       'Rodney Moolen',
      //       style: TextStyle(color: TextCardWColor.mainColor),
      //     ),
      //   ],
      // ),
      // SizedBox(width: 30),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Music by',
      //       style: TextStyle(color: TextCardWColor.secondColor),
      //     ),
      //     Text(
      //       'Ozzy Osbourne',
      //       style: TextStyle(color: TextCardWColor.mainColor),
      //     ),
      //   ],
      // ),
    );
  }
}

class _ColumnEmployeeW extends StatelessWidget {
  final Employee employee;
  _ColumnEmployeeW({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.job,
            style: TextStyle(color: TextCardWColor.secondColor),
          ),
          Text(
            employee.name,
            style: TextStyle(color: TextCardWColor.mainColor),
          ),
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
