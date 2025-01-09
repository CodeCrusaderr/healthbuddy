import 'dart:async';
import 'dart:convert';
import 'package:dashboard/lab_select.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  String address = '';
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final String apiKey =
      'AIzaSyDgTVZbiRzr92tYp2_g2jmxXl_oSu5UUKI'; // Replace 'YOUR_API_KEY' with your actual API key

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final Position position = await _getUserCurrentLocation();
    final LatLng userLocation = LatLng(position.latitude, position.longitude);
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    final add = placemarks.first;
    address = add.locality.toString() +
        " " +
        add.administrativeArea.toString() +
        " " +
        add.subAdministrativeArea.toString() +
        " " +
        add.country.toString();

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(userLocation, 14));

    final List<Place> diagnosticLabs =
        await _fetchNearbyDiagnosticLabs(position.latitude, position.longitude);
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('UserLocation'),
          position: userLocation,
          infoWindow: const InfoWindow(
            title: 'Your Location',
          ),
        ),
      );
      _markers.addAll(diagnosticLabs.map((lab) => Marker(
            markerId: MarkerId(lab.id),
            position: LatLng(lab.latitude, lab.longitude),
            infoWindow: InfoWindow(
              title: lab.name,
              snippet: lab.address,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor
                .hueBlue), // Custom marker icon for diagnostic labs
          )));
    });
  }

  Future<Position> _getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  Future<List<Place>> _fetchNearbyDiagnosticLabs(
      double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json'
          '?location=$latitude,$longitude'
          '&radius=4000' // 4km radius
          '&types=health|doctor|hospital|laboratory' // types of places to search for
          '&keyword=diagnostic' // keyword to filter only diagnostic labs
          '&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      return results.map<Place>((result) {
        return Place(
          id: result['place_id'],
          name: result['name'],
          address: result['vicinity'],
          latitude: result['geometry']['location']['lat'],
          longitude: result['geometry']['location']['lng'],
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch nearby diagnostic labs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Lab Tests',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: GoogleMap(
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0), // Modify this target if needed
                zoom: 1, // Modify the zoom level if needed
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'The above are the laboratories in your vicinity!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2.0,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Book Appointments with HealthBuddy Labs!',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LabTestSelectPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
                      ),
                      child: Text(
                        'Book Now',
                        style: TextStyle(color: Colors.white,fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Place {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  Place({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

void main() {
  runApp(MaterialApp(
    home: CurrentLocationScreen(),
  ));
}
