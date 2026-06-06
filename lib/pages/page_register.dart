import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_word/pages/page_list_berita.dart';
import 'package:hello_word/pages/page_login.dart';
import 'package:hello_word/services/api_service.dart';
import 'package:http/http.dart' as http;

class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _namaLengkapController = TextEditingController();

  void register() async {
    if (_usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _namaLengkapController.text.isEmpty) {
      _showSnackBar("Semua field harus diisi");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(ApiService.urlRegister),
        body: {
          "username": _usernameController.text,
          "password": _passwordController.text,
          "email": _emailController.text,
          "fullname": _namaLengkapController.text,
        },
      );

      final data = jsonDecode(response.body);

      if (data['is_success']) {
        _showSnackBar('Berhasil register');
        // kita arahkan ke halaman login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PageLogin()),
        );
      } else {
        _showSnackBar('Gagal register');
      }
    } catch (e) {
      _showSnackBar('Terjadi kesalahan saat melakukan registrasi ${e}');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _namaLengkapController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nama Lengkap",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                ),
                onPressed: register,
                child: const Text("Register"),
              ),
            ),
            Padding(padding: EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PageLogin()),
                  );
                },
                child: const Text("Sudah punya akun? Login"), // tambah child
              ),
            )
          ],
        ),
      ),
    );
  }
}