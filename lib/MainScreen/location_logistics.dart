import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(-9.4438, 147.1703),
  //   zoom: 13,
  //   tilt: 59.440717697143555,
  // );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(-9.4438, 147.1803),
  //     tilt: 59.440717697143555,
  //     zoom: 22);

  // List<Marker> markers = [];

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: StreamBuilder(
  //     stream: FirebaseFirestore.instance
  //         .collection('WarehouseLocation')
  //         .snapshots(),
  //     builder: (context, snapshot) {

  //       markers.add(snapshot.data!.docs[]);

  //       return GoogleMap(
  //         markers: ,
  //         mapType: MapType.hybrid,
  //         initialCameraPosition: _kGooglePlex,
  //         onMapCreated: (GoogleMapController controller) {
  //           _controller.complete(controller);
  //         },
  //       );
  //     },
  //   ));
  // }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  late GoogleMapController controller;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(specify['warehouse'].latitude, specify['warehouse'].longitude),
      infoWindow: InfoWindow(title: 'Warehouse', snippet: specify['name']),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    FirebaseFirestore.instance
        .collection('WarehouseLocation')
        .get()
        .then((myMockDoc) {
      if (myMockDoc.docs.isNotEmpty) {
        for (int i = 0; i < myMockDoc.docs.length; i++) {
          initMarker(myMockDoc.docs[i].data(), myMockDoc.docs[i].id);
        }
      }
    });
  }

  @override
  void initState() {
    getMarkerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> getMarker() {
      return <Marker>[
        Marker(
            markerId: MarkerId('Shop'),
            position: LatLng(-9.4438, 147.1803),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Home'))
      ].toSet();
    }

    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        mapType: MapType.hybrid,
        initialCameraPosition:
            CameraPosition(target: LatLng(-9.4438, 147.1803), zoom: 13.0),
        onMapCreated: (GoogleMapController controller) {
          controller = controller;
        },
      ),
    );
  }
}
