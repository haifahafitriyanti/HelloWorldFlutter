import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageMapsTiga extends StatefulWidget {
  const PageMapsTiga({super.key});

  @override
  State<PageMapsTiga> createState() => _PageMapsTigaState();
}

class _PageMapsTigaState extends State<PageMapsTiga> {

  final Set<Marker> _markers = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(
        Marker(
            markerId: const MarkerId("Home"),
            position: const LatLng(-0.9144069879603821, 100.46618318650691),
            infoWindow: const InfoWindow(title: "Ini rumah Saya")
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(initialCameraPosition: const CameraPosition(target: LatLng(-0.9144069879603821, 100.46618318650691), zoom: 15),
      mapType: .normal,
      markers: _markers,);
  }
}