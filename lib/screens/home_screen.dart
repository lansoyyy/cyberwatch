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
  String nameSearched = '';
  final searchController = TextEditingController();
  int dropValue = 0;
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
                        const Expanded(
                          child: SizedBox(),
                        ),
                        TextBold(
                          text: 'Stations:',
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: DropdownButton(
                                value: dropValue,
                                underline: const SizedBox(),
                                items: [
                                  for (int i = 0; i < 5; i++)
                                    DropdownMenuItem(
                                      value: i,
                                      child: TextRegular(
                                        text: 'Station $i',
                                        fontSize: 14,
                                        color: primary,
                                      ),
                                    ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    dropValue = int.parse(value.toString());
                                  });
                                }),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: Stack(
                      children: [
                        FlutterMap(
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 45,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      nameSearched = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Search officer',
                                      suffixIcon: Icon(Icons.search),
                                      hintStyle:
                                          TextStyle(fontFamily: 'QRegular'),
                                      prefixIcon: Icon(
                                        Icons.local_police_outlined,
                                        color: Colors.black,
                                      )),
                                  controller: searchController,
                                ),
                              ),
                            ],
                          ),
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
