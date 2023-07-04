import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyberwatch/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;
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

  final mapController = MapController();

  bool hasLoaded = true;
  String nameSearched = '';
  final searchController = TextEditingController();
  int dropValue = 0;
  String station = '';
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
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Stations')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Center(child: Text('Error'));
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.black,
                                  )),
                                );
                              }

                              final data = snapshot.requireData;
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25),
                                  child: DropdownButton(
                                      value: dropValue,
                                      underline: const SizedBox(),
                                      items: [
                                        for (int i = 0;
                                            i < data.docs.length;
                                            i++)
                                          DropdownMenuItem(
                                            onTap: () {
                                              setState(() {
                                                station = data.docs[i]['name'];
                                              });
                                            },
                                            value: i,
                                            child: TextRegular(
                                              text: data.docs[i]['name'],
                                              fontSize: 14,
                                              color: primary,
                                            ),
                                          ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          dropValue =
                                              int.parse(value.toString());
                                        });
                                      }),
                                ),
                              );
                            }),
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
                        StreamBuilder<QuerySnapshot>(
                            stream: station == ''
                                ? FirebaseFirestore.instance
                                    .collection('Users')
                                    .snapshots()
                                : FirebaseFirestore.instance
                                    .collection('Users')
                                    .where('station', isEqualTo: station)
                                    .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Center(child: Text('Error'));
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.black,
                                  )),
                                );
                              }

                              final data = snapshot.requireData;
                              return FlutterMap(
                                mapController: mapController,
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
                                          radius: 12.5,
                                          borderStrokeWidth: 1,
                                          borderColor: Colors.black,
                                          useRadiusInMeter: true,
                                          color: Colors.blue,
                                          point: LatLng(
                                              data.docs[i]['location'][0]
                                                  ['lat'],
                                              data.docs[i]['location'][0]
                                                  ['long']),
                                        ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
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
                              const SizedBox(
                                height: 10,
                              ),
                              nameSearched != ''
                                  ? StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('Users')
                                          .where('name',
                                              isGreaterThanOrEqualTo:
                                                  toBeginningOfSentenceCase(
                                                      nameSearched))
                                          .where('name',
                                              isLessThan:
                                                  '${toBeginningOfSentenceCase(nameSearched)}z')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          return const Center(
                                              child: Text('Error'));
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Padding(
                                            padding: EdgeInsets.only(top: 50),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Colors.black,
                                            )),
                                          );
                                        }

                                        final data = snapshot.requireData;
                                        return Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          width: 300,
                                          height:
                                              data.docs.isNotEmpty ? 125 : 75,
                                          child: data.docs.isNotEmpty
                                              ? ListView.separated(
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const Divider();
                                                  },
                                                  itemCount: data.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      onTap: () {
                                                        mapController.move(
                                                            LatLng(
                                                                data.docs[index]
                                                                        [
                                                                        'location']
                                                                    [0]['lat'],
                                                                data.docs[index]
                                                                        [
                                                                        'location']
                                                                    [
                                                                    0]['long']),
                                                            18);
                                                      },
                                                      title: TextBold(
                                                          text: data.docs[index]
                                                              ['name'],
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                      subtitle: TextBold(
                                                          text: data.docs[index]
                                                              ['contactNumber'],
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                      trailing: const Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Center(
                                                  child: TextBold(
                                                      text: 'No Result',
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                ),
                                        );
                                      })
                                  : const SizedBox(),
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
