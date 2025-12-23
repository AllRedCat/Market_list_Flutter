import 'package:flutter/material.dart';

class LodingPage extends StatelessWidget {
  const LodingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 60.0,
          height: 60.0,
          child: CircularProgressIndicator(strokeWidth: 8.0),
        ),
      ),
    );
  }
}
