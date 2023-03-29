import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skeletons/skeletons.dart';
import 'package:washouse_customer/resource/controller/center_controller.dart';
import 'package:washouse_customer/resource/models/center.dart';

import '../../../components/constants/color_constants.dart';
import '../../../resource/controller/map_controller.dart';
import '../../center/component/list_center_skeleton.dart';
import '../../center/list_center_screen.dart';
import '../current_location_screen.dart';
import 'search_bar_home.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final mapController = MapUserController();

  List<LaundryCenter> centerLists = [];

  Position? _currentPosition;
  String _currentAddress = "";
  String _searchText = "";
  bool isLoading = true;

  List<LaundryCenter>? centers;
  List<LaundryCenter>? suggestion;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        isLoading = false;
      });
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: kPrimaryColor,
                  ),
                  const SizedBox(width: 6),
                  Skeleton(
                    isLoading: isLoading,
                    skeleton: SkeletonLine(
                        style: SkeletonLineStyle(
                      height: 20,
                      width: 150,
                      borderRadius: BorderRadius.circular(8),
                    )),
                    child: Text(
                      _currentAddress,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            child: const CurrentLocationScreen(),
                            type: PageTransitionType.fade),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.notifications,
                color: textColor,
                size: 30.0,
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: size.width,
            height: 45,
            child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         child: const ListCenterScreen(
                  //           pageName: 'Tìm tiệm giặt',
                  //           isNearby: false,
                  //           isSearch: true,
                  //         ),
                  //         type: PageTransitionType.fade));
                  showSearch(
                    context: context,
                    delegate: CustomSearch(),
                  );
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_rounded,
                      color: kPrimaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Tìm tiệm giặt',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
