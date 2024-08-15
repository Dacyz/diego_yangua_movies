import 'package:diego_yangua_movies/core/utils/colors.dart';
import 'package:diego_yangua_movies/data/models/genre_enum.dart';
import 'package:diego_yangua_movies/data/models/movie_model.dart';
import 'package:diego_yangua_movies/presentation/widgets/modal_sheet.dart';
import 'package:flutter/material.dart';

class CreateMoviePage extends StatefulWidget {
  const CreateMoviePage({
    super.key,
  });

  static Future<Movie?> showModal(BuildContext context) async => await CustomModalSheet.show(
        context,
        child: const CreateMoviePage(),
      );

  @override
  State<CreateMoviePage> createState() => _CreateMoviePageState();
}

class _CreateMoviePageState extends State<CreateMoviePage> {
  // Text edit controllers for movie title and description
  final _title = TextEditingController();
  final _description = TextEditingController();
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  // Selected genre for the movie
  Genre? value;

  // Cancels the operation and pops the current route
  void _cancel() => Navigator.pop(context);

  // Saves the movie if the form is valid, otherwise does nothing
  void _save() {
    if (_formKey.currentState!.validate()) {
      // Creates a new movie instance with the form data
      final movie = Movie(
        title: _title.text,
        description: _description.text,
        rating: 5,
        genre: value!,
      );
      // Pops the current route and passes the movie instance as a result
      Navigator.pop(context, movie);
    }
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
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
    // Form widget for the movie creation form
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add movie',
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
          // Text field for the movie title
          TextFormField(
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
          // Row with the genre dropdown and the save/cancel buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Dropdown for the movie genre selection
              Flexible(
                child: DropdownButtonFormField<Genre>(
                  items: const [
                    DropdownMenuItem(value: Genre.action, child: Text('Action')),
                    DropdownMenuItem(value: Genre.drama, child: Text('Drama')),
                    DropdownMenuItem(value: Genre.crime, child: Text('Crime')),
                  ],
                  style: const TextStyle(color: Colors.white),
                  validator: _genreValidator,
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
              // Button to save the movie
              ElevatedButton(
                onPressed: _save,
                child: const Text('Add'),
              ),
              const SizedBox(width: 8),
              // Button to cancel the movie creation
              OutlinedButton(
                onPressed: _cancel,
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
