import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Berikutnya'),
      ),
      body: Center(
        child: Text('Selamat datang di halaman berikutnya!'),
      ),
    );
  }
}
