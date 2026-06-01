import 'package:flutter/material.dart';
import 'package:prog_lazy_f/movieCardW/circularProgressIndicator/circularProgressIndicator.dart'
    show CircularProgressCustom;
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart'
    show MovieCardDetailsModel;
import 'package:prog_lazy_f/movieCardW/movieCardUIWidgets/textColorRGBA.dart'
    show TextCardWColor;
import 'package:prog_lazy_f/navigation/mainNavigation.dart'
    show NavigationRoutesNames;
import 'package:provider/provider.dart';

class AboutMovieW extends StatelessWidget {
  const AboutMovieW({super.key});

  @override
  Widget build(BuildContext context) {
    // final model = UniversalInheritNitifier.watch<MovieCardDetailsModel>(
    //   context,
    // );
    final _movieDetails = context.select(
      (MovieCardDetailsModel model) => model.movieDetails,
    );
    final stringFromDateFunc = context
        .read<MovieCardDetailsModel>()
        .stringFromDate;
    if (_movieDetails == null) return const SizedBox.shrink();
    var year = _movieDetails.releaseDate?.year.toString();
    year = year != null ? ' ( $year )' : '000';
    final listOfTextDetails = <String>[];

    final reliseOfDate = _movieDetails.releaseDate;
    if (reliseOfDate != null) {
      listOfTextDetails.add(stringFromDateFunc(reliseOfDate));
    }
    final productCountries = _movieDetails.productionCountries;
    if (productCountries.isNotEmpty) {
      listOfTextDetails.add('(${productCountries.first.iso})');
    }
    final runtime = _movieDetails.runtime ?? 0;
    final durationOfMovie = Duration(minutes: runtime);
    final hours = durationOfMovie.inHours;
    final minutes = durationOfMovie.inMinutes.remainder(60);
    listOfTextDetails.add('$hours h $minutes m');
    final genres = _movieDetails.genres;
    if (genres.isNotEmpty) {
      var listOfGenresName = <String>[];
      for (var genre in genres) {
        listOfGenresName.add(genre.name);
      }
      listOfTextDetails.add(listOfGenresName.join(', '));
    }
    final overview = _movieDetails.overview ?? '';
    final videoT = _movieDetails.videos.results.where(
      (video) => video.site == 'YouTube' && video.type == 'Trailer',
    );

    final trailerKey = videoT.isNotEmpty == true ? videoT.first.key : null;
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
                    text: _movieDetails.title,
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
