import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404'),
        foregroundColor: Colors.white,
      ),
      body: const Center(
          child: Text(
        'Page does not exists',
        style: TextStyle(
          color: Colors.black87,
        ),
      )),
    );
  }
}
