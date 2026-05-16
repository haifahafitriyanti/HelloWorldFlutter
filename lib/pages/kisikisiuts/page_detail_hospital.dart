import 'package:flutter/material.dart';
import 'package:hello_word/pages/kisikisiuts/model/hospital.dart';
import 'package:hello_word/pages/kisikisiuts/page_maps_hospital.dart';

class PageDetailHospital extends StatelessWidget {
  final Hospital hospital;
  const PageDetailHospital({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hospital.title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            hospital.image,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospital.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  hospital.desc,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                // Tombol Maps
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageMapsHospital(
                            latitude: hospital.latitude,
                            longitude: hospital.longitude,
                            hospitalName: hospital.title,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.local_hospital, color: Colors.white),
                    label: Text(
                      'Lihat Lokasi di Peta',
                      // style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}