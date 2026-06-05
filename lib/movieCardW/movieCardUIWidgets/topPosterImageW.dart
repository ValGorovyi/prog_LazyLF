import 'package:flutter/material.dart';
import 'package:prog_lazy_f/domain/apiClient/imageDownloader.dart'
    show ImageDownloader;
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart'
    show MovieCardDetailsModel;
import 'package:provider/provider.dart';

class TopPosterImageW extends StatelessWidget {
  const TopPosterImageW({super.key});

  @override
  Widget build(BuildContext context) {
    // final _model = context.read<MovieCardDetailsModel>();
    final topPosterImageData = context.select(
      (MovieCardDetailsModel model) => model.dataCard.posterData,
    );
    final backdropPath = topPosterImageData.backdropPath;
    final posterPath = topPosterImageData.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          if (backdropPath != null)
            Image.network(ImageDownloader.imageUrl(backdropPath)),

          if (posterPath != null)
            Positioned(
              top: 20,
              left: 20,
              bottom: 20,
              child: Image.network(ImageDownloader.imageUrl(posterPath)),
            ),
          Positioned(top: 6, right: 10, child: _LikeMovieW()),
        ],
      ),
    );
  }
}

class _LikeMovieW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final toggleFavoriteFunc = context
        .read<MovieCardDetailsModel>()
        .toggleFavorite;

    final iconDataImage = context.select(
      (MovieCardDetailsModel model) => model.dataCard.posterData.favoriteIcon,
    );
    return IconButton(
      onPressed: () => toggleFavoriteFunc(context),
      icon: Icon(iconDataImage),
    );
  }
}
