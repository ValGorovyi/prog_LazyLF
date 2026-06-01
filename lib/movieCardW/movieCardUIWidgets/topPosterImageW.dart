import 'package:flutter/material.dart';
import 'package:prog_lazy_f/domain/apiClient/imageDownloader.dart'
    show ImageDownloader;
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart'
    show MovieCardDetailsModel;
import 'package:provider/provider.dart';

class TopPosterImageW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final _model = context.read<MovieCardDetailsModel>();
    final movieDetails = context.select(
      (MovieCardDetailsModel model) => model.movieDetails,
    );
    final backdropPath = movieDetails?.backdropPath;
    final posterPath = movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ImageDownloader.imageUrl(backdropPath))
              : SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null
                ? Image.network(ImageDownloader.imageUrl(posterPath))
                : SizedBox.shrink(),
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
    final toggleFavoriteFunc = context.select(
      (MovieCardDetailsModel model) => model.toggleFavorite,
    );
    final isFavorite = context.select(
      (MovieCardDetailsModel model) => model.isFavorite,
    );
    return IconButton(
      onPressed: () => toggleFavoriteFunc(context),
      icon: Icon(
        isFavorite == true ? Icons.favorite : Icons.favorite_border_outlined,
      ),
    );
  }
}
