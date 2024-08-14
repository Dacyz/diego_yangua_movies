// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      rating: (json['rating'] as num).toDouble(),
      genre: $enumDecode(_$GenreEnumMap, json['genre']),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'rating': instance.rating,
      'genre': _$GenreEnumMap[instance.genre]!,
    };

const _$GenreEnumMap = {
  Genre.action: 'Action',
  Genre.drama: 'Drama',
  Genre.crime: 'Crime',
  Genre.notFound: '',
};
