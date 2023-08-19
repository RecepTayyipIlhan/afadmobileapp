import 'package:flutter/material.dart';

class EducationVideosScreen extends StatelessWidget {
  const EducationVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Eğitim Videoları"),
      ),
    );
  }
}
