// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popularMoviesRes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

popularMoviesResponceType _$popularMoviesResponceTypeFromJson(
  Map<String, dynamic> json,
) => popularMoviesResponceType(
  page: (json['page'] as num).toInt(),
  movies: (json['results'] as List<dynamic>)
      .map((e) => MovieType.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPages: (json['total_pages'] as num).toInt(),
  totalResults: (json['total_results'] as num).toInt(),
);

Map<String, dynamic> _$popularMoviesResponceTypeToJson(
  popularMoviesResponceType instance,
) => <String, dynamic>{
  'page': instance.page,
  'results': instance.movies.map((e) => e.toJson()).toList(),
  'total_pages': instance.totalPages,
  'total_results': instance.totalResults,
};
