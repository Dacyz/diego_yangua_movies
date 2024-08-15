import 'dart:math';

import 'package:diego_yangua_movies/core/utils/colors.dart';
import 'package:diego_yangua_movies/data/models/movie_model.dart';
import 'package:diego_yangua_movies/presentation/page/update_movie_page.dart';
import 'package:diego_yangua_movies/presentation/widgets/movie_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      child: InkWell(
        onTap: () => context.go('/detail', extra: movie),
        onLongPress: () => UpdateMoviePage.showModal(context, movie),
        borderRadius: BorderRadius.circular(8),
        child: isCarouselView
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: movie.image),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(movie.title, textAlign: TextAlign.center, style: titleMedium),
                        const SizedBox(height: 8.0),
                        Text(movie.description, style: titleSmall),
                        Text('Rating: ⭐${movie.rating.toStringAsFixed(1)}',
                            textAlign: TextAlign.start, style: titleSmall),
                      ],
                    ),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    movie.image,
                    const SizedBox(height: 8.0),
                    Text(movie.title, textAlign: TextAlign.center, style: titleMedium),
                    const SizedBox(height: 8.0),
                    Text(movie.description, style: titleSmall),
                    Text('Rating: ⭐${movie.rating.toStringAsFixed(1)}', style: titleSmall),
                  ],
                ),
              ),
      ),
    );
  }
}
