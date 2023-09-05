import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../utils/colors.dart';
import '../widgets/text_widget.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  List<Marker> myMarkers = [];

  final mapController = MapController();

  bool hasLoaded = true;
  String nameSearched = '';
  final searchController = TextEditingController();
  int dropValue = 0;
  String station = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
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
                      text: 'SentiNex',
                      fontSize: 38,
                      color: Colors.white,
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TabBar(
                labelStyle: const TextStyle(
                  color: Colors.red,
                ),
                tabs: [
                  Tab(
                    child:
                        TextBold(text: 'Map', fontSize: 18, color: Colors.blue),
                  ),
                  Tab(
                    child: TextBold(
                        text: 'Logs', fontSize: 18, color: Colors.blue),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                child: TabBarView(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mapWidget(),
                        SizedBox(
                          width: 375,
                          height: 700,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextRegular(
                                            text: 'Station',
                                            fontSize: 18,
                                            color: Colors.black),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 35,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Center(
                                            child: TextRegular(
                                                text: 'Station 1',
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextRegular(
                                            text: 'Patrol',
                                            fontSize: 18,
                                            color: Colors.black),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 35,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Center(
                                            child: TextRegular(
                                                text: 'Patrol 1',
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Users')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return const Center(
                                            child: Text('Error'));
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
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            for (int i = 0;
                                                i < data.docs.length;
                                                i++)
                                              Container(
                                                height: 105,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 20, 10, 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextBold(
                                                          text: data.docs[i]
                                                              ['name'],
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      TextRegular(
                                                          text: data.docs[i]
                                                              ['status'],
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      TextRegular(
                                                          text: DateFormat
                                                                  .yMMMd()
                                                              .add_jm()
                                                              .format(data
                                                                  .docs[i][
                                                                      'timestamp']
                                                                  .toDate()),
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  mapWidget() {
    return SizedBox(
      child: Stack(
        children: [
          SizedBox(
            width: 1000,
            height: 700,
            child: StreamBuilder<QuerySnapshot>(
                stream: station == ''
                    ? FirebaseFirestore.instance.collection('Users').snapshots()
                    : FirebaseFirestore.instance
                        .collection('Users')
                        .where('station', isEqualTo: station)
                        .snapshots(),
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

                  GeoPoint geoPoint = data.docs[0]['location'];

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
                              radius: 25,
                              borderStrokeWidth: 2,
                              borderColor: Colors.black,
                              useRadiusInMeter: true,
                              color: Colors.blue,
                              point:
                                  LatLng(geoPoint.latitude, geoPoint.longitude),
                            ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
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
                            hintStyle: TextStyle(fontFamily: 'QRegular'),
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
                                    toBeginningOfSentenceCase(nameSearched))
                            .where('name',
                                isLessThan:
                                    '${toBeginningOfSentenceCase(nameSearched)}z')
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
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            width: 300,
                            height: data.docs.isNotEmpty ? 125 : 75,
                            child: data.docs.isNotEmpty
                                ? ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return const Divider();
                                    },
                                    itemCount: data.docs.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          mapController.move(
                                              LatLng(
                                                  data.docs[index]['location']
                                                      [0]['lat'],
                                                  data.docs[index]['location']
                                                      [0]['long']),
                                              18);
                                        },
                                        title: TextBold(
                                            text: data.docs[index]['name'],
                                            fontSize: 16,
                                            color: Colors.black),
                                        subtitle: TextBold(
                                            text: data.docs[index]
                                                ['contactNumber'],
                                            fontSize: 12,
                                            color: Colors.grey),
                                        trailing: const Icon(
                                          Icons.arrow_forward_ios_rounded,
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
    );
  }
}
