import 'package:diego_yangua_movies/data/models/movie_model.dart';
import 'package:diego_yangua_movies/presentation/screen/error_screen.dart';
import 'package:diego_yangua_movies/presentation/screen/home_screen.dart';
import 'package:diego_yangua_movies/presentation/screen/movie_screen.dart';
import 'package:go_router/go_router.dart';

class MovieRouter {
  static const String home = '/';
  static const String detail = 'detail';
  static const String error = '/error';

  /// The route configuration.
  static final router = GoRouter(
    errorBuilder: (context, state) => ErrorScreen(message: state.error.toString()),
    routes: [
      GoRoute(
        path: home,
        builder: (_, __) => const HomeScreen(),
        routes: [
          GoRoute(
            path: detail,
            builder: (_, state) {
              final movie = state.extra as Movie?;
              if (movie == null) {
                return const HomeScreen();
              }
              return MovieScreen(movie: movie);
            },
          ),
        ],
      ),
      GoRoute(
        path: error,
        builder: (_, state) => ErrorScreen(message: state.extra as String? ?? ''),
      ),
    ],
  );
}
