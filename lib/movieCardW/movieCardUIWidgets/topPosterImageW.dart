import 'package:flutter/material.dart';
import 'package:prog_lazy_f/domain/apiClient/imageDownloader.dart'
    show ImageDownloader;
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart'
    show MovieCardDetailsModel;
import 'package:prog_lazy_f/universalInherit/universalInheritNotifier.dart'
    show UniversalInheritNitifier;

class TopPosterImageW extends StatelessWidget {
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
          Positioned(
            top: 6,
            right: 10,
            child: IconButton(
              onPressed: () => model?.toggleFavorite(context),
              icon: Icon(
                model?.isFavorite == true
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
