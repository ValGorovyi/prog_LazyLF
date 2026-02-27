import 'package:json_annotation/json_annotation.dart'
    show FieldRename, JsonKey, JsonSerializable;

part 'movieDetailsVideoT.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsVideoT {
  // final int id;
  final List<VideosTResult> results;
  MovieDetailsVideoT({
    // required this.id,
    required this.results,
  });
  factory MovieDetailsVideoT.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsVideoTFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsVideoTToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class VideosTResult {
  @JsonKey(name: 'iso_639_1')
  final String iso6391;
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  @JsonKey(name: 'published_at')
  final String publishedAt;
  final String id;
  VideosTResult({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });
  factory VideosTResult.fromJson(Map<String, dynamic> json) =>
      _$VideosTResultFromJson(json);
  Map<String, dynamic> toJson() => _$VideosTResultToJson(this);
}
