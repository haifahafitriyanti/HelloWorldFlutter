import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hello_word/pages/MAPS/page_maps_dua.dart';
import 'package:hello_word/pages/MAPS/page_maps_hybrid.dart';
import 'package:hello_word/pages/MAPS/page_maps_multiple.dart';
import 'package:hello_word/pages/MAPS/page_maps_terrain.dart';
import 'package:hello_word/pages/MAPS/page_maps_tiga.dart';

class PageMaps extends StatelessWidget {
  const PageMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        backgroundColor: Colors.purpleAccent,
      ),

      body: GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(-0.914321168202979, 100.46616172883562), zoom: 17),)
    );
  }
}

class PageMainMaps extends StatelessWidget {
  const PageMainMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Maps'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30,),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageMaps()),
                  );
                },
              child: Text('Maps Pertama'),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageMapsDua()),
                );
              },
              child: Text('Maps Kedua'),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageMapsTiga()),
                );
              },
              child: Text('Maps Normal'),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageMapsHybrid()),
                );
              },
              child: Text('Maps Hybrid'),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageMapsTerrain()),
                );
              },
              child: Text('Maps Terrain'),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageMapsMultiple()),
                );
              },
              child: Text('Map Multiple'),
            ),
          ],
        ),
      ),
    );
  }
}

