import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../application/user_service.dart';
import '../domain/entities/login_request.dart';
import '../infrastructure/repository/user_repository_impl.dart';
import 'next_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      // Gunakan UserService untuk login
      final userService = UserService(UserRepositoryImpl());
      final response = await userService.login(LoginRequest(username: username, password: password)).catchError((error) {
        // Tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
        ));
      });

      // Proses hasil login
      if (response.token.isNotEmpty) {
        // Navigasi ke NextPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NextPage()),
        );
      } else {
        // Tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login gagal! Silakan coba lagi.'),
        ));
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                key: Key('username'),
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                key: Key('password'),
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
