import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:anamnesis/database/database.dart';
import 'package:anamnesis/presentation/memory_screen/memory_screen.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapState();
}

class _MapState extends State<MapWidget> {
  late Future<LatLng> _locationFuture = Future.value(const LatLng(0, 0));
  late Future<List<Marker>> _memoryPinsFuture = _getMemoryPins();

  @override
  void initState() {
    super.initState();
    _locationFuture = _determinePosition();
    _memoryPinsFuture = _getMemoryPins();
  }

  Future<LatLng> _determinePosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Marker>> _getMemoryPins() async {
    List<Marker> mapPins = [];
    DatabaseHelper dbHelper = DatabaseHelper();
    List<Map<String, dynamic>> memories = await dbHelper.getMemories();
    for (Map<String, dynamic> memory in memories) {
      mapPins.add(_buildMapPin(context, memory));
    }
    return mapPins;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
        future: _locationFuture,
        builder: (context, snapshot1) {
          if (snapshot1.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show loading spinner while waiting for location
          } else if (snapshot1.hasError) {
            return Text(
                'Error: ${snapshot1.error}'); // Show error message if an error occurred
          } else {
            LatLng _userLocation = snapshot1.data!;
            return FutureBuilder<List<Marker>>(
                future: _memoryPinsFuture,
                builder: (context, snapshot2) {
                  print('memoryPins = $snapshot2.data');
                  List<Marker> memoryPins = snapshot2.data ?? [];
                  return FlutterMap(
                    options: MapOptions(
                      initialCenter: _userLocation,
                      initialZoom: 7.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      ),
                      MarkerLayer(
                        markers: [_buildUserPin(_userLocation)] + memoryPins,
                      ),
                    ],
                  );
                });
          }
        });
  }

  Marker _buildUserPin(LatLng userLocation) {
    return Marker(
        width: 30.0,
        height: 30.0,
        point: userLocation,
        child: Icon(
          Icons.person_pin_circle_outlined,
          size: 30.0,
          color: Colors.blue.shade300,
          shadows: [
            Shadow(
              color: Colors.blue.shade200,
              blurRadius: 20.0,
            ),
            Shadow(
              color: Colors.blue.shade200,
              blurRadius: 10.0,
            )
          ],
        ));
  }

  Marker _buildMapPin(BuildContext context, Map<String, dynamic> memory) {
    LatLng location = memory['location'];
    String thumbnail = memory['thumbnail'];
    int memId = memory['id'];
    return Marker(
        width: 30.0,
        height: 30.0,
        point: location,
        child: GestureDetector(
          onTap: () {
            // Navigate to memory screen, normally passing the memory id as an argument
            print(memId);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MemoryScreen.builder(context)),
            );
          },
          child: ClipOval(
            child: Container(
              padding: EdgeInsets.all(
                  2), // Adjust this value to change the border width
              color: Colors.white, // This is the border color
              child: ClipOval(
                child: Image.asset(thumbnail,
                    fit: BoxFit
                        .cover), // Replace this with the path to your image
              ),
            ),
          ),
        ));
  }
}
