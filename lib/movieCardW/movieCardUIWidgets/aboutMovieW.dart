import 'package:flutter/material.dart';
import 'package:prog_lazy_f/movieCardW/circularProgressIndicator/circularProgressIndicator.dart'
    show CircularProgressCustom;
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart'
    show MovieCardDetailsModel;
import 'package:prog_lazy_f/movieCardW/movieCardUIWidgets/textColorRGBA.dart'
    show TextCardWColor;
import 'package:prog_lazy_f/navigation/mainNavigation.dart'
    show NavigationRoutesNames;
import 'package:prog_lazy_f/universalInherit/universalInheritNotifier.dart'
    show UniversalInheritNitifier;

class AboutMovieW extends StatelessWidget {
  const AboutMovieW({super.key});

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
    final videoT = model.movieDetails?.videos.results.where(
      (video) => video.site == 'YouTube' && video.type == 'Trailer',
    );
    ;
    final trailerKey = videoT?.isNotEmpty == true ? videoT?.first.key : null;
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
            trailerKey != null
                ? Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.play_arrow_rounded, size: 50),
                        onPressed: () => Navigator.of(context).pushNamed(
                          NavigationRoutesNames.trailerRoute,
                          arguments: trailerKey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('Play triler'),
                    ],
                  )
                : SizedBox.shrink(),
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
