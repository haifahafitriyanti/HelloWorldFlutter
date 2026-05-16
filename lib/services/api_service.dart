import 'dart:convert';
import 'package:hello_word/models/model_users.dart';
import 'package:http/http.dart' as http;
import 'package:hello_word/models/model_photos.dart';

class ApiService {
  static const String urlPhotos = "https://jsonplaceholder.typicode.com/photos";
  static const String urlUsers = "https://jsonplaceholder.typicode.com/users";

  static Future<List<ModelPhotos>> fetchDataPhotos() async{
    final response = await http.get(Uri.parse(urlPhotos));

    if (response.statusCode == 200){
      List jsonData = json.decode(response.body);
      return jsonData.take(50) //dibatasi 50 data dulu
          .map((e) => ModelPhotos.fromJson(e))
          .toList();
    }else{
      throw Exception("Gagal mengambil data");
    }
  }

  static Future<List<ModelUsers>> fetchDataUsers() async{
    final response = await http.get(Uri.parse(urlUsers));

    if (response.statusCode == 200){
      List jsonData = json.decode(response.body);
      return jsonData.take(50) //dibatasi 50 data dulu
          .map((e) => ModelUsers.fromJson(e))
          .toList();
    }else{
      throw Exception("Gagal mengambil data");
    }
  }
}