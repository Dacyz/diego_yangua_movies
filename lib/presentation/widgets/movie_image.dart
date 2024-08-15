import 'package:cached_network_image/cached_network_image.dart';
import 'package:diego_yangua_movies/data/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

extension MovieImageExt on Movie {
  Widget get image => MovieImage(this);
}

class MovieImage extends StatelessWidget {
  const MovieImage(this.movie, {super.key});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: movie,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl: movie.imagePath,
          fit: BoxFit.cover,
          errorWidget: (context, error, stackTrace) => const Icon(Icons.error),
          progressIndicatorBuilder: (context, url, downloadProgress) => AspectRatio(
            aspectRatio: 172 / 250,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[700]!,
              highlightColor: Colors.grey[500]!,
              child: Container(
                width: double.infinity,
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
