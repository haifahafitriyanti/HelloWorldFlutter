import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageMapsTerrain extends StatefulWidget {
  const PageMapsTerrain({super.key});

  @override
  State<PageMapsTerrain> createState() => _PageMapsTerrainState();
}

class _PageMapsTerrainState extends State<PageMapsTerrain> {

  final Set<Marker> _markers = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(
        Marker(
            markerId: const MarkerId("Campus"),
            position: const LatLng(-0.8938831726061004, 100.35006413728998),
            infoWindow: const InfoWindow(title: "Kampus UNP")
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(initialCameraPosition: const CameraPosition(target: LatLng(-0.8938831726061004, 100.35006413728998), zoom: 15),
      mapType: .terrain,
      markers: _markers,);
  }
}