import 'package:flutter/material.dart';
import 'package:hello_word/models/model_photos.dart';

class PageDetailPhotos extends StatelessWidget {
  final ModelPhotos photo;
  const PageDetailPhotos({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.title),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: [
          Image.network(
            photo.url, // url full size, bukan thumbnailUrl
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                height: 250,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 250,
                color: Colors.grey[200],
                child: Icon(Icons.broken_image, color: Colors.grey, size: 60),
              );
            },
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  photo.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(height: 8),
                Text("Album ID : ${photo.albumId}", style: TextStyle(fontSize: 14)),
                Text("Photo ID : ${photo.id}", style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}