import 'package:json_annotation/json_annotation.dart';

/// Genre enum for movies
/// [Action], [Drama], [Crime], [notFound]
enum Genre {
  @JsonValue('Action')
  action,
  @JsonValue('Drama')
  drama,
  @JsonValue('Crime')
  crime,
  @JsonValue('')
  notFound,
}
