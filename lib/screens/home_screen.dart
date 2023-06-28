import 'package:cyberwatch/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<Marker> myMarkers = [];

  bool hasLoaded = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasLoaded
          ? Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 80,
                  color: primary,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 80,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextBold(
                          text: 'Cyberwatch',
                          fontSize: 38,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
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
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
