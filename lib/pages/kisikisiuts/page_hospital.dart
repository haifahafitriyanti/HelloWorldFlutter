import 'package:flutter/material.dart';
import 'package:hello_word/pages/kisikisiuts/model/hospital.dart';
import 'package:hello_word/pages/kisikisiuts/page_detail_hospital.dart';

class PageHospital extends StatefulWidget {
  const PageHospital({super.key});

  @override
  State<PageHospital> createState() => _PageHospitalState();
}

class _PageHospitalState extends State<PageHospital> {
  List<Map<String, dynamic>> hospital = [
    {
      "title" : "Rumah Sakit Yos Sudarso",
      "image" : "images/h1.jpg",
      "desc" : "Ketika Aku Sakit Kamu Merawat Aku di RS YOS SUDARSO PADANG Jl. Situjuh No. 1",
      "latitude": -0.935471383225451,
      "longitude": 100.3625540183051
    },
    {
      "title" : "RSUP Dr. M. Djamil Padang",
      "image" : "images/h2.jpg",
      "desc" : " RSUP Dr M Djamil KEPUASAN ANDA ADALAH KEPEDULIAN KAMI",
      "latitude": -0.9426593242159839,
      "longitude": 100.36707013778512
    },
    {
      "title" : "Rumah Sakit Khusus Bedah Ropanasuri Padang",
      "image" : "images/h3.jpg",
      "desc" : "Rumah Sakit Khusus Bedah (RSK) Ropanasuri merupakan rumah sakit swasta di Kota Padang yang memberikan pelayanan khusus bedah.",
      "latitude": -0.9348375746067664,
      "longitude": 100.35946769882149
    },
    {
      "title" : "RS. Bhayangkara Padang",
      "image" : "images/h4.jpg",
      "desc" : " RS Bhayangkara TK III Padang berkomitmen memberikan pelayanan terbaik, tidak hanya secara medis tetapi juga melalui perhatian dan ...",
      "latitude": -0.9322303208496812,
      "longitude": 100.36574797438536
    },
    {
      "title" : "RSU Selaguri",
      "image" : "images/h5.jpg",
      "desc" : "Rumah Sakit Selaguri berada dibawah naungan PT Selaguri Citratama Medika Padang dan berlokasi di Padang, Sumatera Barat. Rumah Sakit menyediakan layanan ...",
      "latitude": -0.9419616101183096,
      "longitude": 100.35792517494001
    },
    {
      "title" : "RUMAH SAKIT NAILI DBS",
      "image" : "images/h6.jpg",
      "desc" : "umah Sakit Naili DBS Padang merupakan Rumah Sakit Umum milik Swasta bertipe C yang berada di Padang, Sumatera Barat.",
      "latitude": -0.9445259677473825,
      "longitude": 100.3591076802773
    }
  ];

  List<Map<String, dynamic>> filteredHospital = [];
  TextEditingController txtSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredHospital = hospital;
  }

  //Fitur Search
  void searchHospital(String keyword) {
    final results = hospital.where((item) {
      final title = item['title'].toLowerCase();
      final input = keyword.toLowerCase();

      return title.contains(input);
    }).toList();

    setState(() {
      filteredHospital = results;
    });
  }

  //ketika klik item di list maka akan diarahkan ke detail
  void navigateToDetail(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageDetailHospital(
          hospital: Hospital.fromJson(item),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rumah Sakit Daerah Kota Padang"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: txtSearch,
              decoration: InputDecoration(
                hintText: "Cari nama rumah sakit...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                searchHospital(value);
              },
            ),
            SizedBox(height: 12),
            Expanded(
              child: filteredHospital.isEmpty
                  ? Center(child: Text("rumah sakit tidak ditemukan"))
                  : GridView.builder(
                itemCount: filteredHospital.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final item = filteredHospital[index];
                  return GestureDetector(
                    onTap: () => navigateToDetail(item),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.asset(
                              item['image'],
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              item['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
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
      ),
    );
  }
}