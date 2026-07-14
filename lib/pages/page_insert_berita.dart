import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hello_word/pages/page_list_berita.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';

import '../models/berita_insert_model.dart';
import '../models/model_berita.dart';
import '../services/api_service.dart';

class PageInsertBerita extends StatefulWidget {
  const PageInsertBerita({super.key});

  @override
  State<PageInsertBerita> createState() => _PageInsertBeritaState();
}

class _PageInsertBeritaState extends State<PageInsertBerita> {
  TextEditingController judulController = TextEditingController();
  TextEditingController isiController = TextEditingController();

  File? _fileGambar;
  final _imgPicker = ImagePicker();

  final _formkey = GlobalKey<FormState>();

  //fungsi mengambil gambar Image Picker
  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? ambilGambar = await _imgPicker.pickImage(source: source);
      if (ambilGambar != null) {
        setState(() {
          _fileGambar = File(ambilGambar.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //Fungsi untuk pilihan gambar
  void _pilihGambar(BuildContext context) {
    //pilih gambar dari galeri
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilih Gambar"),
          content: Text("Pilih Sumber Gambar"),
          actions: [
            ElevatedButton(
              onPressed: () {
                _getImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: Text("Galeri"),
            ),
            ElevatedButton(
              onPressed: () {
                _getImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: Text("camera"),
            ),
          ],
        );
      },
    );
  }

  String _message = "";
  bool _isLoading = false;

  Future<void> insertBerita() async {
    try {
      _isLoading = true;
      final url = Uri.parse("${ApiService.baseUrl}/insertBerita.php");
      var request = http.MultipartRequest("POST", url);
      request.fields["judul"] = judulController.text;
      request.fields["isi_berita"] = isiController.text;

      request.files.add(
        await http.MultipartFile.fromPath("gambar_berita", _fileGambar!.path),
      );

      http.StreamedResponse streamedResponse = await request.send();

      http.Response response = await http.Response.fromStream(streamedResponse);

      final beritaInsertModel = beritaInsertModelFromJson(response.body);
      // _message = beritaInsertModel.message;

      if (beritaInsertModel.isSuccess) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(beritaInsertModel.message)));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PageListBerita()),
        );
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(beritaInsertModel.message)));
    } catch (e) {
      _message = "Error : $e";
      _isLoading = false;
    } finally {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Berita"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: judulController,
                  decoration: InputDecoration(
                    labelText: "Judul Berita",
                    prefixIcon: Icon(Icons.wrap_text, color: Colors.red),
                    filled: true,
                    fillColor: Colors.amber.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (val) {
                    return val!.isEmpty ? "Judul tidak boleh kosong" : null;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _pilihGambar(context);
                  },
                  child: Text("Pilih Gambar"),
                ),
                _fileGambar != null
                    ? Image.file(
                        _fileGambar!,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      )
                    : Text("Gambar belum dipilih"),
                SizedBox(height: 10),
                TextFormField(
                  controller: isiController,
                  maxLines: 6,

                  decoration: InputDecoration(
                    hintText: "Isi Berita",
                    filled: true,
                    fillColor: Colors.amber.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (val) {
                    return val!.isEmpty ? "Isi tidak boleh kosong" : null;
                  },
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_formkey.currentState!.validate()) {
                        if (_fileGambar == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Pilih Gambar terlebih dahulu"),
                            ),
                          );
                          return;
                        } else {
                          insertBerita();
                        }
                      }
                    });

                    //String pesan = insertBerita();
                  },
                  child: Text("SIMPAN"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
