import 'package:flutter/material.dart';
import 'package:hello_word/models/model_users.dart';
import 'package:hello_word/pages/page_detail_users.dart';
import 'package:hello_word/services/api_service.dart';

class PageUsersJson extends StatefulWidget {
  const PageUsersJson({super.key});

  @override
  State<PageUsersJson> createState() => _PageUsersJsonState();
}

class _PageUsersJsonState extends State<PageUsersJson> {
  late Future<List<ModelUsers>> futureUsers;
  List<ModelUsers> allUsers = [];
  List<ModelUsers> filteredUsers = [];
  TextEditingController txtSearch = TextEditingController();
  bool isGrid = false; // toggle view

  @override
  void initState() {
    super.initState();
    futureUsers = ApiService.fetchDataUsers();
  }

  void searchUsers(String keyword) {
    final results = allUsers.where((user) {
      final name = user.name.toLowerCase();
      final username = user.username.toLowerCase();
      final input = keyword.toLowerCase();
      return name.contains(input) || username.contains(input);
    }).toList();

    setState(() {
      filteredUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users Json"),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ModelUsers>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi Kesalahan Load Data"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Data Kosong"));
          }

          if (allUsers.isEmpty) {
            allUsers = snapshot.data!;
            filteredUsers = allUsers;
          }

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: txtSearch,
                  decoration: InputDecoration(
                    hintText: "Cari nama atau username...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) => searchUsers(value),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: filteredUsers.isEmpty
                      ? const Center(child: Text("User tidak ditemukan"))
                      : isGrid
                      ? buildGridView()
                      : buildListView(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageDetailUsers(user: user),
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.pinkAccent,
              child: Text(
                user.name[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              user.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Text(user.username, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Text(user.email, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Text(
                      user.address.city,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        user.company.name,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      itemCount: filteredUsers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageDetailUsers(user: user),
            ),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.pinkAccent,
                    child: Text(
                      user.name[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.pinkAccent,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          user.username,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          user.address.city,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          user.company.name,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}