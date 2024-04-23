import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

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
