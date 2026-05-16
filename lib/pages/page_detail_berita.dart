import 'package:flutter/material.dart';
import 'package:hello_word/models/model_berita.dart';

class PageDetailBerita extends StatelessWidget {
  final Datum berita;

  const PageDetailBerita({
    super.key,
    required this.berita,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Berita"),
        backgroundColor: Colors.purpleAccent,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Image.network(
              "http://172.20.10.2/berita_api/gambar/${berita.gambarBerita}",
              webHtmlElementStrategy: WebHtmlElementStrategy.prefer, //agar bisa keluar gambar di web
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    berita.judul,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        "${berita.tglBerita.year}-${berita.tglBerita.month}-${berita.tglBerita.day}",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Text(
                    berita.isiBerita,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}