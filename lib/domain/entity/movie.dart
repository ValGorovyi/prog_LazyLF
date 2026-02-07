import 'package:json_annotation/json_annotation.dart';
import 'package:prog_lazy_f/domain/entity/movieDateParser.dart'
    show parseMovieDateFromResp;

part 'movie.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieType {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final int popularity;
  final String? posterPath;
  @JsonKey(fromJson: parseMovieDateFromResp)
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final int voteAverage;
  final int voteCount;

  MovieType({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieType.fromJson(Map<String, dynamic> json) =>
      _$MovieTypeFromJson(json);
  Map<String, dynamic> toJson() => _$MovieTypeToJson(this);
}
