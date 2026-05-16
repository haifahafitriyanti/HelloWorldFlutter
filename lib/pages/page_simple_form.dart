import 'package:flutter/material.dart';
import 'package:hello_word/Dasar/page_utama.dart';

class PageSimpleForm extends StatefulWidget {
  const PageSimpleForm({super.key});

  @override
  State<PageSimpleForm> createState() => _PageSimpleFormState();
}

class _PageSimpleFormState extends State<PageSimpleForm> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Simple Form'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          Card(
            margin: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.all(15),
              color: Colors.lightBlue,
              alignment: Alignment.centerLeft,
              child: const Text(
                "Form Simple Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: txtUsername,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.lightBlue),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: txtPassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.lightBlue),
              ),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                String nUsername = txtUsername.text;
                String nPassword = txtPassword.text;

                print("Username anda adalah " + nUsername + " dan Password ${nPassword}");

                if (nUsername == "admin" && nPassword == "admin") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PageUtama(),
                    ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("username atau password salah")
                    ),
                  );
                }
              },
              child: const Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}