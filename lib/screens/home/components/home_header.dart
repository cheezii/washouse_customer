import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:washouse_customer/resource/controller/center_controller.dart';
import 'package:washouse_customer/resource/models/center.dart';

import '../../../components/constants/color_constants.dart';
import '../../../components/constants/text_constants.dart';
import '../../../resource/controller/map_controller.dart';
import '../../../resource/models/response_models/notification_item_response.dart';
import '../../../resource/provider/notify_provider.dart';
import '../../center/component/list_center_skeleton.dart';
import '../../center/list_center.dart';
import '../../notification/list_notification_screen.dart';
import '../current_location_screen.dart';
import '../../center/search_center_screen.dart';

class HomeHeader extends StatefulWidget {
  final pickedLocation;
  const HomeHeader({
    super.key,
    this.pickedLocation,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

NotifyProvider notifyProvider = NotifyProvider();

class _HomeHeaderState extends State<HomeHeader> {
  final mapController = MapUserController();
  CenterController centerController = CenterController();

  List<LaundryCenter> centerLists = [];

  Position? _currentPosition;
  String _currentAddress = "";
  bool isLoading = true;
  bool isLoadingNoti = true;

  List<LaundryCenter>? centers;
  List<LaundryCenter>? suggestion;

  int numOfNotifications = 0;

  // Stream<NotificationResponse> getNotis() async* {
  //   NotificationResponse notificationResponse = NotificationResponse();
  //   try {
  //     String url = '$baseUrl/notifications/me-noti';
  //     Response response =
  //         await baseController.makeAuthenticatedRequest(url, {});

  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body)["data"];
  //       notificationResponse = NotificationResponse.fromJson(data);
  //     } else {
  //       throw Exception(
  //           'Error fetching getNotifications: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('error: getNotifications-$e');
  //   }
  //   yield notificationResponse;
  // }

  Future<NotificationResponse> getNotifications() async {
    NotificationResponse notificationResponse = NotificationResponse();
    try {
      String url = '$baseUrl/notifications/me-noti';
      Response response =
          await baseController.makeAuthenticatedRequest(url, {});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)["data"];
        notificationResponse = NotificationResponse.fromJson(data);
      } else {
        throw Exception(
            'Error fetching getNotifications: ${response.statusCode}');
      }
    } catch (e) {
      print('error: getNotifications-$e');
    }
    return notificationResponse;
  }

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

  // void getNotify() async {
  //   NotificationResponse notis = await getNotifications();
  //   setState(() {
  //     numOfNotifications = notis.numOfUnread!;
  //     isLoadingNoti = false;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    notifyProvider.addListener(() => mounted ? setState(() {}) : null);
    notifyProvider.getNoti();
    //getNotify();
  }

  @override
  void dispose() {
    notifyProvider.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
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
                            child: CurrentLocationScreen(
                                currentPosition: _currentPosition!),
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
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const ListNotificationScreen(),
                          type: PageTransitionType.rightToLeftWithFade));
                },
                icon: Stack(
                  children: [
                    const Icon(
                      Icons.notifications,
                      color: textColor,
                      size: 30.0,
                    ),
                    if (notifyProvider.numOfNotifications > 0)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${notifyProvider.numOfNotifications}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: size.width,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchCenterScreen()));
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Colors.grey.shade200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_rounded,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Tìm tiệm giặt',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w400),
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
