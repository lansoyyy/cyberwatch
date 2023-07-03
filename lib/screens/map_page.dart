import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Marker> myMarkers = [];
  List<CircleMarker> myCircles = [];

  bool hasLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasLoaded
          ? StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Users').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                print(data.docs);
                return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(8.477217, 124.645920),
                        zoom: 16.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: myMarkers,
                        ),
                        CircleLayer(
                          circles: [
                            for (int i = 0; i < data.docs.length; i++)
                              CircleMarker(
                                point: LatLng(
                                    data.docs[i]['location'][0]['lat'],
                                    data.docs[i]['location'][0]['long']),
                                radius: 500,
                              ),
                          ],
                        ),
                      ],
                    ));
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
