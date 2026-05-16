import 'package:flutter/material.dart';
import 'package:hello_word/models/model_users.dart';

class PageDetailUsers extends StatelessWidget {
  final ModelUsers user;

  const PageDetailUsers({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        backgroundColor: Colors.pinkAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          Text("Username: ${user.username}"),
          Text("Email: ${user.email}"),
          Text("Phone: ${user.phone}"),
          Text("Website: ${user.website}"),

          const Divider(height: 30),

          const Text(
            "Address",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("${user.address.street}, ${user.address.suite}"),
          Text("${user.address.city}, ${user.address.zipcode}"),
          Text("Lat: ${user.address.geo.lat}"),
          Text("Lng: ${user.address.geo.lng}"),

          const Divider(height: 30),

          const Text(
            "Company",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("Name: ${user.company.name}"),
          Text("CatchPhrase: ${user.company.catchPhrase}"),
          Text("BS: ${user.company.bs}"),
        ],
      ),
    );
  }
}