import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:diego_yangua_movies/core/utils/colors.dart';
import 'package:diego_yangua_movies/data/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

part 'movie_card_skeleton.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie}) : isCarouselView = false;
  const MovieCard.carousel({super.key, required this.movie}) : isCarouselView = true;
  final Movie movie;
  final bool isCarouselView;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final titleMedium = theme.titleMedium?.copyWith(color: Colors.white);
    final titleSmall = theme.bodyMedium?.copyWith(color: Colors.white);
    return Card(
      color: Decorations.kSecondaryColor.withOpacity(.7),
      child: isCarouselView
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildImage()),
                const SizedBox(height: 8.0),
                Text(movie.title, textAlign: TextAlign.center, style: titleMedium),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(movie.description, style: titleSmall),
                ),
                const SizedBox(height: 8.0),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _buildImage(),
                  const SizedBox(height: 8.0),
                  Text(movie.title, textAlign: TextAlign.center, style: titleMedium),
                  const SizedBox(height: 8.0),
                  Text(movie.description, style: titleSmall),
                ],
              ),
            ),
    );
  }

  Widget _buildImage() => ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: CachedNetworkImage(
        imageUrl: 'https://via.assets.so/movie.png?id=${movie.id}&q=95&fit=fill',
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
      ));
}
