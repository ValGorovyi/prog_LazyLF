import 'package:flutter/material.dart';
import 'package:prog_lazy_f/appModel/appModel.dart' show AppModel;

import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart';
import 'package:prog_lazy_f/movieCardW/movieCardUIWidgets/aboutMovieW.dart'
    show AboutMovieW;
import 'package:prog_lazy_f/movieCardW/movieCardUIWidgets/actorScrolingMovieW.dart'
    show ActorScrolingMovieW;
import 'package:prog_lazy_f/movieCardW/movieCardUIWidgets/detailsCardMovieW.dart'
    show DetailsCardMovieW;
import 'package:prog_lazy_f/movieCardW/movieCardUIWidgets/topPosterImageW.dart'
    show TopPosterImageW;
import 'package:prog_lazy_f/universalInherit/universalInheritNotifier.dart'
    show UniversalInheritNitifier;
import 'package:prog_lazy_f/universalInherit/universalInheritProvider.dart';

class MovieCardW extends StatefulWidget {
  const MovieCardW({super.key});

  @override
  State<MovieCardW> createState() => _MovieCardWState();
}

class _MovieCardWState extends State<MovieCardW> {
  @override
  void initState() {
    super.initState();
    final model = UniversalInheritNitifier.read<MovieCardDetailsModel>(context);
    final appModel = UniversalInheritProvider.read<AppModel>(context);
    model?.onSessionExpired = () => appModel?.resetSession(context);
  }

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
        TopPosterImageW(),
        SizedBox(height: 20),
        AboutMovieW(),
        SizedBox(height: 20),

        DetailsCardMovieW(),
        ActorScrolingMovieW(),
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
