import 'package:flutter/material.dart';
import 'package:hello_word/models/model_photos.dart';
import 'package:hello_word/pages/page_detail_photos.dart';
import 'package:hello_word/services/api_service.dart';

class PagePhotosJson extends StatefulWidget {
  const PagePhotosJson({super.key});

  @override
  State<PagePhotosJson> createState() => _PagePhotosJsonState();
}

class _PagePhotosJsonState extends State<PagePhotosJson> {
  late Future<List<ModelPhotos>> futurePhotos;
  List<ModelPhotos> allPhotos = [];
  List<ModelPhotos> filteredPhotos = [];
  TextEditingController txtSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    futurePhotos = ApiService.fetchDataPhotos();
  }

  void searchPhotos(String keyword) {
    final results = allPhotos.where((photo) {
      final title = photo.title.toLowerCase();
      final input = keyword.toLowerCase();
      return title.contains(input);
    }).toList();

    setState(() {
      filteredPhotos = results;
    });
  }

  void navigateToDetail(ModelPhotos photo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageDetailPhotos(photo: photo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photos Json (Random Picsum)"),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder<List<ModelPhotos>>(
        future: futurePhotos,
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

          if (allPhotos.isEmpty) {
            allPhotos = snapshot.data!;
            filteredPhotos = allPhotos;
          }

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: txtSearch,
                  decoration: InputDecoration(
                    hintText: "Cari judul foto...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    searchPhotos(value);
                  },
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: filteredPhotos.isEmpty
                      ? const Center(child: Text("Foto tidak ditemukan"))
                      : GridView.builder(
                    itemCount: filteredPhotos.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final photo = filteredPhotos[index];
                      return GestureDetector(
                        onTap: () => navigateToDetail(photo),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                child: Image.network(
                                  photo.thumbnailUrl,
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const SizedBox(
                                      height: 120,
                                      child: Center(child: CircularProgressIndicator()),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 120,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.broken_image, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  photo.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.redAccent,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}