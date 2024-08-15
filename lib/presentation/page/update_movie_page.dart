import 'dart:ui';

import 'package:diego_yangua_movies/core/utils/colors.dart';
import 'package:diego_yangua_movies/data/models/genre_enum.dart';
import 'package:diego_yangua_movies/data/models/movie_model.dart';
import 'package:diego_yangua_movies/presentation/bloc/movies_bloc.dart';
import 'package:diego_yangua_movies/presentation/widgets/modal_sheet.dart';
import 'package:diego_yangua_movies/presentation/widgets/movie_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateMoviePage extends StatefulWidget {
  const UpdateMoviePage({super.key, required this.movie});
  final Movie movie;

  /// Shows a modal with the `MovieScreen` widget.
  static showModal(BuildContext context, Movie movie) async {
    final newMovie = await _modal(context, movie);
    if (newMovie != null) {
      final bloc = context.read<MoviesBloc>();
      bloc.add(UpdateMovies(newMovie));
    }
  }

  static Future<Movie?> _modal(BuildContext context, Movie movie) async {
    return await showModalBottomSheet<Movie?>(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      builder: (_) => UpdateMoviePage(movie: movie),
    );
  }

  @override
  State<UpdateMoviePage> createState() => _UpdateMoviePageState();
}

class _UpdateMoviePageState extends State<UpdateMoviePage> {
  // Text edit controllers for movie title and description
  final _title = TextEditingController();
  final _description = TextEditingController();
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  // Selected genre for the movie
  Genre? value;
  // Rating for the movie
  double rating = 5;
  bool showDeleteMenu = false;

  // Cancels the operation and pops the current route
  void _cancel() => Navigator.pop(context);

  // Saves the movie if the form is valid, otherwise does nothing
  void _update() {
    if (_formKey.currentState!.validate()) {
      // Creates a new movie instance with the form data
      final movie = Movie(
        id: widget.movie.id,
        title: _title.text,
        description: _description.text,
        rating: rating,
        genre: value!,
      );
      // Pops the current route and passes the movie instance as a result
      Navigator.pop(context, movie);
    }
  }

  void _remove() {
    final bloc = context.read<MoviesBloc>();
    bloc.add(RemoveMovies(widget.movie));
    Navigator.pop(context);
  }

  /// Validator for the movie title field
  ///
  /// Returns a null string if the title is valid, otherwise returns an error message
  String? _titleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  /// Validator for the movie description field
  ///
  /// Returns a null string if the description is valid, otherwise returns an error message
  String? _descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }

  /// Validator for the movie genre field
  ///
  /// Returns a null string if the genre is valid, otherwise returns an error message
  String? _genreValidator(Genre? value) {
    if (value == null) {
      return 'Please select a genre';
    }
    return null;
  }

  @override
  void initState() {
    _setValues();
    super.initState();
  }

  /// Sets the initial values of the form fields with the data from the movie.
  ///
  /// This is called in [initState] to set the values of the form fields to the
  /// values of the movie that is passed in as a parameter when the page is
  /// created.
  void _setValues() {
    // Set the title field value to the title of the movie
    _title.text = widget.movie.title;
    // Set the description field value to the description of the movie
    _description.text = widget.movie.description;
    // Set the genre field value to the genre of the movie
    value = widget.movie.genre;
    // Set the rating field value to the rating of the movie
    rating = widget.movie.rating;
    if (mounted) {
      setState(() {});
    }
  }

  bool get hasSameValues =>
      value == widget.movie.genre &&
      rating == widget.movie.rating &&
      _title.text == widget.movie.title &&
      _description.text == widget.movie.description;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).textTheme;
    // final titleMedium = theme.titleMedium?.copyWith(color: Colors.white);
    // final titleSmall = theme.bodyMedium?.copyWith(color: Colors.white);
    const titleStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: widget.movie.image,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: CustomModalSheet(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    showDeleteMenu ? 'Delete movie' : 'Update movie',
                    textAlign: TextAlign.center,
                    style: titleStyle,
                  ),

                  if (!showDeleteMenu) ...[
                    // Text field for the movie title
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              hintStyle: TextStyle(color: Colors.white),
                              focusColor: Colors.white,
                              labelText: 'Title',
                              counterText: '',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            validator: _titleValidator,
                            maxLength: 50,
                            style: const TextStyle(color: Colors.white),
                            controller: _title,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Dropdown for the movie genre selection
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: DropdownButtonFormField<Genre>(
                            items: const [
                              DropdownMenuItem(value: Genre.action, child: Text('Action')),
                              DropdownMenuItem(value: Genre.drama, child: Text('Drama')),
                              DropdownMenuItem(value: Genre.crime, child: Text('Crime')),
                            ],
                            style: const TextStyle(color: Colors.white),
                            validator: _genreValidator,
                            value: value,
                            decoration: const InputDecoration(
                              labelText: 'Genre',
                              floatingLabelAlignment: FloatingLabelAlignment.start,
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.black,
                            ),
                            icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white),
                            iconSize: 24,
                            elevation: 16,
                            dropdownColor: Decorations.kPrimaryColor,
                            onChanged: (_) {
                              setState(() {
                                value = _;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    // Text field for the movie description
                    TextFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        alignLabelWithHint: true,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusColor: Colors.white,
                        labelText: 'Description',
                        counterText: '',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      validator: _descriptionValidator,
                      maxLength: 180,
                      maxLines: 2,
                      style: const TextStyle(color: Colors.white),
                      controller: _description,
                    ),
                    const SizedBox(height: 4),
                  ],
                  // Row with the genre dropdown and the save/cancel buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: showDeleteMenu
                        ? [
                            Expanded(
                              child: Text(
                                "Are you sure you want to delete ${widget.movie.title}'s movie?",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton.icon(
                                style: ButtonStyle(
                                  iconColor: WidgetStateProperty.all(Colors.white),
                                ),
                                icon: const Icon(Icons.delete_forever_outlined),
                                onPressed: _remove,
                                label: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.white),
                                )),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                                style: ButtonStyle(
                                    iconColor: WidgetStateProperty.all(Colors.black),
                                    backgroundColor: WidgetStateProperty.all(Colors.white)),
                                icon: const Icon(Icons.close),
                                onPressed: () => setState(() => showDeleteMenu = !showDeleteMenu),
                                label: const Text(
                                  'No',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ]
                        : [
                            Text('⭐ ${rating.toStringAsFixed(1)}', style: const TextStyle(color: Colors.white)),
                            const SizedBox(width: 8),
                            Flexible(
                              child: SliderTheme(
                                data: SliderThemeData(trackShape: CustomTrackShape()),
                                child: Slider(
                                  value: rating / 10,
                                  onChanged: (_) => setState(() => rating = _ * 10),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Button to update the movie
                            ElevatedButton.icon(
                                style: ButtonStyle(
                                    iconColor: WidgetStateProperty.all(Colors.black),
                                    backgroundColor: WidgetStateProperty.all(Colors.white)),
                                icon: const Icon(Icons.save),
                                onPressed: _update,
                                label: const Text(
                                  'Update',
                                  style: TextStyle(color: Colors.black),
                                )),
                            const SizedBox(width: 4),
                            IconButton.filled(
                              color: Colors.white,
                              focusColor: Colors.redAccent,
                              hoverColor: Colors.redAccent,
                              disabledColor: Colors.red,
                              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
                              onPressed: () => setState(() => showDeleteMenu = !showDeleteMenu),
                              icon: const Icon(Icons.delete),
                            ),
                            // Button to cancel or reset the movie creation
                            IconButton.outlined(
                              color: Colors.white,
                              onPressed: hasSameValues ? _cancel : _setValues,
                              icon: hasSameValues ? const Icon(Icons.close) : const Icon(Icons.restore),
                            ),
                          ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
