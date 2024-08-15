import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:diego_yangua_movies/core/utils/colors.dart';
import 'package:diego_yangua_movies/data/models/movie_model.dart';
import 'package:diego_yangua_movies/presentation/widgets/modal_sheet.dart';
import 'package:diego_yangua_movies/presentation/widgets/movie_image.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget implements PreferredSizeWidget {
  const MovieScreen({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final titleSmall = theme.bodyMedium?.copyWith(color: Colors.white);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(movie.title, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black.withOpacity(.2),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: movie.imagePath,
            fit: BoxFit.cover,
            errorWidget: (context, error, stackTrace) => const SizedBox(),
            progressIndicatorBuilder: (context, url, downloadProgress) => const SizedBox(),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.2), // Fondo semi-transparente
            ),
          ),
          const SizedBox(height: 16),
          Positioned.fill(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: preferredSize.height + 16),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: movie.image,
                  ),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 650,
                  ),
                  child: CustomModalSheet(
                    color: Decorations.kSecondaryColor.withOpacity(.9),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _titleValue('Genre: ', movie.genre.name, titleSmall),
                        _titleValue('Description: ', movie.description, titleSmall),
                        _titleValue('Rating: ', '⭐${movie.rating.toStringAsFixed(1)}', titleSmall),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleValue(String title, String value, TextStyle? titleMedium) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: value,
            style: titleMedium,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
