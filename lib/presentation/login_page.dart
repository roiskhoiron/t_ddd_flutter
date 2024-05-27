import 'package:flutter/material.dart';

import '../application/user_service.dart';
import '../domain/entities/login_request.dart';
import '../infrastructure/repository/user_repository_impl.dart';
import 'next_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      // Gunakan UserService untuk login
      final userService = UserService(UserRepositoryImpl());
      if (mounted) {
        try {

          final response = await userService
              .login(LoginRequest(username: username, password: password));

          // Proses hasil login
          if (response.token.isNotEmpty) {
            // Navigasi ke NextPage
            if (!context.mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NextPage()),
            );
          } else {
            // Tampilkan pesan error
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Login gagal! Silakan coba lagi.'),
            ));
          }
        } on Exception catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                key: const Key('username'),
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                key: const Key('password'),
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () => _login(context),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
