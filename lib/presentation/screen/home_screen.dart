import 'package:carousel_slider/carousel_slider.dart';
import 'package:diego_yangua_movies/core/utils/colors.dart';
import 'package:diego_yangua_movies/presentation/bloc/movies_bloc.dart';
import 'package:diego_yangua_movies/presentation/page/about_page.dart';
import 'package:diego_yangua_movies/presentation/page/create_movie_page.dart';
import 'package:diego_yangua_movies/presentation/widgets/movie_card.dart';
import 'package:diego_yangua_movies/presentation/widgets/search_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

enum MoviesViewType { grid, list }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MoviesViewType _viewType = MoviesViewType.list;

  void _addMovie() async {
    final movie = await CreateMoviePage.showModal(context);
    if (movie != null) {
      final bloc = context.read<MoviesBloc>();
      bloc.add(UpdateMovies(movie));
    }
  }

  void _showCV() {
    AboutPage.showModal(context);
  }

  void _changeView() {
    setState(() {
      _viewType = _viewType == MoviesViewType.grid ? MoviesViewType.list : MoviesViewType.grid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: Decorations.backgroundColor(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text('Some Movies', style: TextStyle(color: Colors.white)),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: CustomSearchBar(),
          ),
        ),
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 0,
              onPressed: _showCV,
              mini: true,
              child: const Icon(Icons.info_outline_rounded),
            ),
            const SizedBox(width: 8.0),
            FloatingActionButton(
              heroTag: 1,
              onPressed: _addMovie,
              shape: const StadiumBorder(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 8.0),
            FloatingActionButton(
              heroTag: 2,
              onPressed: _changeView,
              mini: true,
              child: _viewType == MoviesViewType.grid ? const Icon(Icons.list_alt) : const Icon(Icons.grid_view),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: _viewType == MoviesViewType.grid ? _gridView() : _carouselView(),
        ),
      ),
    );
  }

  Widget _gridView() {
    final size = MediaQuery.sizeOf(context);
    final crossAxisCount = size.width > 800 ? 4 : 2;
    final gridDelegate = SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount);
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return MasonryGridView.builder(
            gridDelegate: gridDelegate,
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (_, __) => MovieCardSkeleton(),
          );
        } else if (state is MoviesLoaded) {
          return MasonryGridView.builder(
            gridDelegate: gridDelegate,
            padding: const EdgeInsets.all(8.0),
            itemCount: state.movies.length,
            itemBuilder: (_, index) => MovieCard(movie: state.movies[index]),
          );
        } else if (state is MoviesError) {
          return _error(context, state);
        }
        return const Placeholder();
      },
    );
  }

  Widget _carouselView() {
    final size = MediaQuery.sizeOf(context);
    final viewportFraction = size.width > 800 ? 0.4 : 0.7;
    final options = CarouselOptions(
      height: size.height * 0.7,
      enlargeCenterPage: true,
      viewportFraction: viewportFraction,
      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enableInfiniteScroll: false,
    );
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return CarouselSlider.builder(
            options: options.copyWith(autoPlay: false),
            itemCount: 6,
            itemBuilder: (_, index, __) => MovieCardSkeleton.carousel(),
          );
        } else if (state is MoviesLoaded) {
          return CarouselSlider.builder(
            options: options,
            itemCount: state.movies.length,
            itemBuilder: (_, index, __) => MovieCard.carousel(
              movie: state.movies[index],
            ),
          );
        } else if (state is MoviesError) {
          return _error(context, state);
        }
        return const Placeholder();
      },
    );
  }

  Widget _error(BuildContext context, MoviesError state) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Some error occurred',
            style: theme.titleMedium?.copyWith(color: Colors.white),
          ),
          Text(state.message, style: theme.bodyMedium?.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
