import 'package:json_annotation/json_annotation.dart';
import 'package:prog_lazy_f/domain/entity/movie.dart';

part 'popularMoviesRes.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class popularMoviesResponceType {
  final int page;
  @JsonKey(name: 'results')
  final List<MovieType> movies;
  final int totalPages;
  final int totalResults;

  popularMoviesResponceType({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory popularMoviesResponceType.fromJson(Map<String, dynamic> json) =>
      _$popularMoviesResponceTypeFromJson(json);
  Map<String, dynamic> toJson() => _$popularMoviesResponceTypeToJson(this);
}
