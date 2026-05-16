import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageMapsHospital extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String hospitalName;

  const PageMapsHospital({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.hospitalName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokasi $hospitalName'),
        // backgroundColor: Colors.green,
        // foregroundColor: Colors.white,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 17,
        ),
        mapType: .hybrid,
        markers: {
          Marker(
            markerId: MarkerId(hospitalName),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: hospitalName,
              snippet: 'Lokasi Rumah Sakit',
            ),
          ),
        },
      ),
    );
  }
}