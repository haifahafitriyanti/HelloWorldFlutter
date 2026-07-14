import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_word/helper/session_manager.dart';
import 'package:hello_word/pages/page_register.dart';
import 'package:hello_word/pages/page_list_berita.dart';
import 'package:http/http.dart' as http;

import 'package:hello_word/services/api_service.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void login() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar("Semua field harus diisi");
      return;
    }
    try {
      final response = await http.post(
        Uri.parse(ApiService.urlLogin),
        body: {
          "username": _usernameController.text,
          "password": _passwordController.text,
        },
      );

      final data = jsonDecode(response.body); // pindah ke dalam try + tambah ;
      if (data['is_success'] == true) {

        _showSnackBar('Berhasil login');
        //arahkan ke page berita list

        //simpan data session
        await SessionManager.saveUserSession(data['data']);

        if(!mounted) return;
        _showSnackBar("Berhasil login");
        //arahkan ke page berita list
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PageListBerita()),
        );
      } else {
        String pesanGagal = data['message'] ?? 'Login gagal';
        _showSnackBar(pesanGagal); // hapus "pesanGagal" dari dalam string
      }
    } catch (e) {
      _showSnackBar(
        'Terjadi kesalahan saat melakukan login: $e',
      ); // tambah catch
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // tambah children: [
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                ),
                onPressed: login,
                child: Text("Login"),
              ),
            ),
            Padding(padding: EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PageRegister()),
                  );
                },
                child: const Text("Belum punya akun? Register"), // tambah child
              ),
            )
          ], // tutup ]
        ),
      ),
    );
  }
}