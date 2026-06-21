import 'package:flutter/material.dart';
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart';
import 'package:prog_lazy_f/movieCardW/movieCardUIWidgets/aboutMovieW.dart'
    show AboutMovieW;
import 'package:prog_lazy_f/movieCardW/movieCardUIWidgets/actorScrolingMovieW.dart'
    show ActorScrolingMovieW;
import 'package:prog_lazy_f/movieCardW/movieCardUIWidgets/detailsCardMovieW.dart'
    show DetailsCardMovieW;
import 'package:prog_lazy_f/movieCardW/movieCardUIWidgets/topPosterImageW.dart'
    show TopPosterImageW;

import 'package:provider/provider.dart';

class MovieCardW extends StatefulWidget {
  const MovieCardW({super.key});

  @override
  State<MovieCardW> createState() => _MovieCardWState();
}

class _MovieCardWState extends State<MovieCardW> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    Future.microtask(
      () => context.read<MovieCardDetailsModel>().setupLocate(context, locale),
    );
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

class _AppTitleInDetailsW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleText = context.select(
      (MovieCardDetailsModel model) => model.dataCard.title,
    );
    return Text(titleText);
  }
}

class _BodyCardW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLoadingProcess = context.select(
      (MovieCardDetailsModel model) => model.dataCard.isLoading,
    );
    if (isLoadingProcess) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        TopPosterImageW(),
        const SizedBox(height: 20),
        const AboutMovieW(),
        const SizedBox(height: 20),

        const DetailsCardMovieW(),
        ActorScrolingMovieW(),
      ],
    );
  }
}
