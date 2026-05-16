import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class PageMapsMultiple extends StatefulWidget {
  const PageMapsMultiple({super.key});

  @override
  State<PageMapsMultiple> createState() => _PageMapsMultipleState();
}

class _PageMapsMultipleState extends State<PageMapsMultiple> {
  final Set<Marker> _markers = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId("pnp"),
      position: LatLng(-0.9143211, 100.466),
      infoWindow: InfoWindow(title: "Politeknik Negeri Padang"),
    ));

    _markers.add(Marker(
      markerId: MarkerId("unand"),
      position: LatLng(-0.9116, 100.4583),
      infoWindow: InfoWindow(title: "Universitas Andalas"),
    ));

    _markers.add(Marker(
      markerId: MarkerId("unp"),
      position: LatLng(-0.8956, 100.3533),
      infoWindow: InfoWindow(title: "Universitas Negeri Padang"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(-0.9143211, 100.466),
        zoom: 15,
      ),
      mapType: .normal,
      markers: _markers,
    );
  }
}
//tambahkan beberapa page untuk maps
//1. Buat maps tipe satellite
//2. Buat maps normal
//3. Buat maps yang hybrid
//4. Buat maps yang terrain
//5. Bikin maps dengan multiple markers(PNP, Unand, UNP dll)