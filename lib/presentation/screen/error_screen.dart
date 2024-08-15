import 'package:diego_yangua_movies/core/utils/colors.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Decorations.kSecondaryColor,
      body: SafeArea(
        minimum: const EdgeInsets.all(42),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 120,
                color: Colors.yellow,
              ),
              Text(
                message,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
