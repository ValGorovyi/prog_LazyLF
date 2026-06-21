import 'package:prog_lazy_f/domain/entity/movieDetails.dart'
    show MovieDetailsType;

class MovieDetailsLocal {
  final MovieDetailsType details;
  final bool isFavorite;

  MovieDetailsLocal({required this.details, required this.isFavorite});
}
