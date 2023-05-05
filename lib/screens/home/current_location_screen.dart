// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as map;
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:latlong2/latlong.dart' as latLng;

import 'package:washouse_customer/components/constants/color_constants.dart';

import '';
import 'components/search_bar_map.dart';

class CurrentLocationScreen extends StatefulWidget {
  final Position currentPosition;
  const CurrentLocationScreen({
    Key? key,
    required this.currentPosition,
  }) : super(key: key);

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController googleMapController;
  TextEditingController searchController = TextEditingController();
  map.MapOptions mapOptions = map.MapOptions();
  latLng.LatLng? currentPoint;
  //MapController mapController = MapController();

  // static CameraPosition initialCameraPosition = CameraPosition(
  //     target: LatLng(widget.currentPosition.latitude, widget.currentPosition.latitude), zoom: 14);

  //Set<Marker> markers = {};
  String query = '';

  @override
  void initState() {
    super.initState();
    // markers.add(Marker(
    //     markerId: const MarkerId('currentLocation'),
    //     position: LatLng(widget.currentPosition.latitude,
    //         widget.currentPosition.longitude)));
    // mapController = MapController(
    //   initMapWithUserPosition: false,
    //   initPosition: GeoPoint(
    //     latitude: widget.currentPosition.latitude,
    //     longitude: widget.currentPosition.latitude,
    //   ),
    //   areaLimit: BoundingBox(
    //     east: 10.4922941,
    //     north: 47.8084648,
    //     south: 45.817995,
    //     west: 5.9559113,
    //   ),
    // );
    currentPoint = latLng.LatLng(
        widget.currentPosition.latitude, widget.currentPosition.longitude);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        target: LatLng(
            widget.currentPosition.latitude, widget.currentPosition.longitude),
        zoom: 14);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Địa chỉ hiện tại"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // GoogleMap(
          //   initialCameraPosition: initialCameraPosition,
          //   markers: markers,
          //   zoomControlsEnabled: false,
          //   mapType: MapType.normal,
          //   onMapCreated: (GoogleMapController controller) {
          //     googleMapController = controller;
          //   },
          // ),

          // OSMFlutter(controller: mapController)
          // OpenStreetMapSearchAndPick(
          //     center: LatLong(widget.currentPosition.latitude,
          //         widget.currentPosition.longitude),
          //     onPicked: (pickedData) {

          //     })
          map.FlutterMap(
            options: map.MapOptions(
              onTap: (tapPosition, point) {
                print('latitude: ${point.latitude}');
                setState(() {
                  currentPoint = point;
                });
              },
              center: latLng.LatLng(widget.currentPosition.latitude,
                  widget.currentPosition.longitude),
              // center: latLng.LatLng(49.5, -0.09),
              zoom: 15,
            ),
            children: [
              map.TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              map.MarkerLayer(
                markers: [
                  map.Marker(
                      point: currentPoint!,
                      builder: ((context) => const Icon(
                            Icons.location_on_rounded,
                            color: Colors.red,
                            size: 40,
                          )))
                ],
              )
            ],
          ),
          SearchBar(
            onChanged: (z) {
              setState(() => query = z.toLowerCase());
              print('query: $query');
            },
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {
      //     Position position = await _determinePosition();

      //     googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      //         CameraPosition(
      //             target: LatLng(position.latitude, position.longitude),
      //             zoom: 14)));

      //     markers.clear();

      //     markers.add(Marker(
      //         markerId: const MarkerId('currentLocation'),
      //         position: LatLng(position.latitude, position.longitude)));

      //     setState(() {});
      //   },
      //   label: const Text("Địa chỉ hiện tại"),
      //   icon: const Icon(Icons.location_history),
      //   backgroundColor: kPrimaryColor,
      // ),
    );
  }

  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  // void placeAutocomplete(String query) async {
  //   Uri uri =
  //       Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
  //     "input": query,
  //     "key": apiKey,
  //   });
  //   String? response = await NetworkUtilility.fetchUrl(uri);
  //   if (response != null) {
  //     print(response);
  //   }
  // }
}
