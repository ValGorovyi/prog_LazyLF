import 'package:flutter/material.dart';
import 'package:prog_lazy_f/movieCardW/circularProgressIndicator/circularProgressIndicator.dart'
    show CircularProgressCustom;
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart'
    show AboutMovieNameData, MovieCardDetailsModel;
import 'package:prog_lazy_f/movieCardW/movieCardUIWidgets/textColorRGBA.dart'
    show TextCardWColor;
import 'package:prog_lazy_f/navigation/mainNavigation.dart'
    show NavigationRoutesNames;
import 'package:provider/provider.dart';

class AboutMovieW extends StatelessWidget {
  const AboutMovieW({super.key});

  @override
  Widget build(BuildContext context) {
    final overview = context.select(
      (MovieCardDetailsModel m) => m.dataCard.overview,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [MovieNameW()],
        ),
        SizedBox(height: 20),
        AboutMovieScoreW(),
        SizedBox(height: 10),
        AboutSummaryW(),

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

class AboutSummaryW extends StatelessWidget {
  const AboutSummaryW({super.key});

  @override
  Widget build(BuildContext context) {
    final summaryText = context.select(
      (MovieCardDetailsModel model) => model.dataCard.summaryData,
    );
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        summaryText,
        style: TextStyle(color: TextCardWColor.mainColor),
      ),
    );
  }
}

class AboutMovieScoreW extends StatelessWidget {
  const AboutMovieScoreW({super.key});

  @override
  Widget build(BuildContext context) {
    final scoreData = context.select(
      (MovieCardDetailsModel model) => model.dataCard.aboutScoreData,
    );
    final trailerKey = scoreData.trailerKey;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            CircularProgressCustom(
              /////!!!!!
            ),
            SizedBox(width: 8),
            Text('Users score'),
          ],
        ),
        if (trailerKey != null)
          Row(
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
          ),
      ],
    );
  }
}

class MovieNameW extends StatelessWidget {
  const MovieNameW({super.key});

  @override
  Widget build(BuildContext context) {
    var dataName = context.select(
      (MovieCardDetailsModel m) => m.dataCard.aboutNameData,
    );
    return RichText(
      maxLines: 3,

      text: TextSpan(
        children: [
          TextSpan(
            text: dataName.name,
            style: TextStyle(color: TextCardWColor.mainColor),
          ),
          WidgetSpan(child: SizedBox(width: 10)),
          TextSpan(
            text: dataName.year,
            style: TextStyle(color: TextCardWColor.secondColor),
          ),
        ],
      ),
    );
  }
}
// class _OverviewW extends StatelessWidget{

// }
