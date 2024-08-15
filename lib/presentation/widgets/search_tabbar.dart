import 'package:diego_yangua_movies/core/utils/colors.dart';
import 'package:diego_yangua_movies/data/models/genre_enum.dart';
import 'package:diego_yangua_movies/presentation/bloc/movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool searchVisible = false;
  final searchController = TextEditingController();
  final List<String> _tabs = ['All', 'Action', 'Drama', 'Crime'];

  void _switchSearch() {
    setState(() {
      searchVisible = !searchVisible;
    });
    // Clear the search query
    if (!searchVisible) {
      searchController.clear();
    }
  }

  void _selectGenre(int value) {
    setState(() {
      _selectedIndex = value;
    });
    // Sort the movies
    _sortMovies();
  }

  /// Sorts the movies based on the selected genre and the search query.
  ///
  /// If the [MoviesBloc] state is [MoviesLoaded], the function retrieves the
  /// selected genre and the search query from the state. It then adds a new
  /// [SearchMovie] event to the [MoviesBloc] with the retrieved values.
  ///
  /// If the selected genre is 'All', the function sets the genre to
  /// [Genre.notFound]. Otherwise, it sets the genre to the corresponding value
  /// from the [Genre] enum.
  ///
  /// Parameters:
  ///   - [value]: An optional parameter that is not used in the function.
  void _sortMovies([value]) {
    // Read the state of the MoviesBloc
    final bloc = context.read<MoviesBloc>();

    // Check if the state is MoviesLoaded
    if (bloc.state is MoviesLoaded) {
      // Determine the selected genre based on the selected index
      final genre = _selectedIndex == 0 ? Genre.notFound : Genre.values[_selectedIndex - 1];

      // Add a new SearchMovie event to the MoviesBloc with the search query and genre
      bloc.add(SearchMovie(searchController.text, genre));
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white);
    var textFieldSize = MediaQuery.sizeOf(context).width / 2;
    textFieldSize = _selectedIndex != 0 ? textFieldSize : (textFieldSize + 80);
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      constraints: const BoxConstraints(maxWidth: 342),
      decoration: BoxDecoration(
        color: Decorations.kSecondaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _switchSearch,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: searchVisible ? Decorations.kPrimaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.search, color: Colors.white),
            ),
          ),
          if (searchVisible) ...[
            const SizedBox(width: 8.0),
            Flexible(
              child: TextFormField(
                controller: searchController,
                onFieldSubmitted: _sortMovies,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Search movie...',
                  hintStyle: textStyle,
                ),
                style: textStyle,
              ),
            ),
            const SizedBox(width: 8.0),
            if (_selectedIndex != 0)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Decorations.kPrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _tabs[_selectedIndex],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(width: 4),
            BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                if (state is MoviesLoaded) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: _sortMovies,
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                      child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
                    ),
                  );
                } else if (state is MoviesLoading) {
                  return const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      color: Colors.grey,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(width: 4),
          ] else
            Flexible(
              child: _CustomTabBar(
                values: _tabs,
                selectedIndex: _selectedIndex,
                onChange: _selectGenre,
              ),
            )
        ],
      ),
    );
  }
}

class _CustomTabBar extends StatefulWidget {
  final List<String> values;
  final int selectedIndex;
  final void Function(int index) onChange;
  const _CustomTabBar({required this.values, required this.onChange, this.selectedIndex = 0});
  @override
  State<_CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<_CustomTabBar> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(
      initialIndex: widget.selectedIndex,
      length: widget.values.length,
      vsync: this,
    );
    super.initState();
  }

  void _onTap(int index) => widget.onChange(index);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      automaticIndicatorColorAdjustment: true,
      dividerHeight: 0.0,
      enableFeedback: true,
      indicatorPadding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      indicatorWeight: 0.0,
      indicatorColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
      padding: EdgeInsets.zero,
      tabAlignment: TabAlignment.fill,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[700],
      ),
      onTap: _onTap,
      tabs: List.generate(
        widget.values.length,
        (index) => Tab(text: widget.values[index], height: 40),
      ),
    );
  }
}
