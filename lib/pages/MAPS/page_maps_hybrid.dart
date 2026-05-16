import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageMapsHybrid extends StatefulWidget {
  const PageMapsHybrid({super.key});

  @override
  State<PageMapsHybrid> createState() => _PageMapsHybridState();
}

class _PageMapsHybridState extends State<PageMapsHybrid> {

  final Set<Marker> _markers = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(
        Marker(
            markerId: const MarkerId("Campus"),
            position: const LatLng(-0.9149838682485573, 100.45809517116436),
            infoWindow: const InfoWindow(title: "Kampus UNAND")
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(initialCameraPosition: const CameraPosition(target: LatLng(-0.9149838682485573, 100.45809517116436), zoom: 15),
      mapType: .hybrid,
      markers: _markers,);
  }
}