import 'package:flutter/material.dart';

class InvalidPage extends StatelessWidget {
  const InvalidPage({super.key});

  static const String routeName = '/invalid';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Invalid Page'),
      ),
    );
  }
}
