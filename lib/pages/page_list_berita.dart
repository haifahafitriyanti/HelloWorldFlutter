import 'package:flutter/material.dart';
import 'package:hello_word/pages/page_detail_berita.dart';
import 'package:hello_word/services/api_service.dart';
import 'package:hello_word/models/model_berita.dart';

class PageListBerita extends StatefulWidget {
  const PageListBerita({super.key});

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {
  late Future<List<Datum>> futureBerita;

  List<Datum> _allBerita = [];
  List<Datum> _filteredBerita = [];

  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureBerita = ApiService.getDataBerita();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // fungsi search
  void _onSearchBar(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredBerita = List.from(_allBerita);
      } else {
        _filteredBerita = _allBerita.where((berita) {
          return berita.judul
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Berita'),
        backgroundColor: Colors.purpleAccent,
      ),

      body: FutureBuilder<List<Datum>>(
        future: futureBerita,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          else if (snapshot.hasData) {

            // agar data tidak reset saat search
            if (_allBerita.isEmpty) {
              _allBerita = snapshot.data!;
              _filteredBerita = List.from(_allBerita);
            }
          }

          return Column(
            children: [

              // search bar
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: _onSearchBar,

                  decoration: InputDecoration(
                    hintText: "Cari berita...",

                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.green,
                    ),

                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear),

                      onPressed: () {
                        _searchCtrl.clear();
                        _onSearchBar('');
                      },
                    )
                        : null,

                    filled: true,
                    fillColor: Colors.grey.shade100,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: Colors.grey.shade300),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),

              // jumlah hasil search
              if (_searchCtrl.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    bottom: 8,
                  ),

                  child: Text(
                    "${_filteredBerita.length} berita ditemukan",
                  ),
                ),

              // list berita
              Expanded(
                child: _filteredBerita.isEmpty

                    ? const Center(
                  child: Text("Berita tidak ditemukan"),
                )

                    : RefreshIndicator(
                  color: Colors.green,

                  onRefresh: () async {
                    setState(() {
                      _allBerita.clear();

                      futureBerita =
                          ApiService.getDataBerita();
                    });
                  },

                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),

                    itemCount: _filteredBerita.length,

                    itemBuilder: (context, index) {
                      return _buildBeritaCard(
                        _filteredBerita[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBeritaCard(Datum berita) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      elevation: 3,

      margin: const EdgeInsets.only(bottom: 12),

      child: InkWell(
        onTap: () {
          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (context) =>
                  PageDetailBerita(berita: berita),
            ),
          );
        },

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // gambar berita
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),

              child: Image.network(
                "http://172.20.10.2/berita_api/gambar/${berita.gambarBerita}",

                webHtmlElementStrategy:
                WebHtmlElementStrategy.prefer,

                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,

                errorBuilder:
                    (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey.shade300,

                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),

            // judul berita
            Padding(
              padding: const EdgeInsets.all(10),

              child: Text(
                berita.judul,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}