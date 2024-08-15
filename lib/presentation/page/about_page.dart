import 'package:diego_yangua_movies/presentation/widgets/modal_sheet.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  /// Shows a modal with the `AboutPage` widget.
  static showModal(BuildContext context) => CustomModalSheet.show(
        context,
        child: const AboutPage(),
      );

  @override
  Widget build(BuildContext context) {
    /// The style for the title of the about page.
    const titleStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'About me',
          textAlign: TextAlign.center,
          style: titleStyle,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            /// My profile image.
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('assets/developer.jpg', width: 50, height: 50),
            ),
            const SizedBox(width: 16),
            Expanded(child: _informationText()),
          ],
        )
      ],
    );
  }

  /// Text with the information about me.
  Widget _informationText() {
    return RichText(
      text: const TextSpan(
        text:
            "My name is Diego Arturo Yangua Merino, I'm 22 years old, and this is my technical exercise in Flutter for ",
        style: TextStyle(color: Colors.white),
        children: <TextSpan>[
          /// delfosti
          TextSpan(
            text: 'delfos',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: 'ti',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
          ),
          TextSpan(text: ' for '),
          TextSpan(
            text: "Full Stack Mobile Developer's",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          TextSpan(text: " position."),
        ],
      ),
    );
  }
}
