//ignore_for_file: public_member_api_docs, sort_constructors_first
import 'center_delivery_price.dart';
import 'service.dart';

class LaundryCenter {
  int? id;
  String? thumbnail;
  String? title;
  String? alias;
  String? description;
  List<CenterServices>? centerServices;
  num? rating;
  num? numOfRating;
  String? phone;
  String? centerAddress;
  num? distance;
  num? minPrice;
  num? maxPrice;
  bool? monthOff;
  bool? hasDelivery;
  bool? hasOnlinePayment;
  bool? isOpening;
  int? numOfPromotionAvailable;
  List<CenterDeliveryPrice>? centerDeliveryPrices;
  CenterLocation? centerLocation;
  List<CenterOperatingHours>? centerOperatingHours;

  LaundryCenter(
      {this.id,
      this.thumbnail,
      this.title,
      this.alias,
      this.description,
      this.centerServices,
      this.rating,
      this.numOfRating,
      this.phone,
      this.centerAddress,
      this.distance,
      this.minPrice,
      this.maxPrice,
      this.monthOff,
      this.hasDelivery,
      this.hasOnlinePayment,
      this.isOpening,
      this.numOfPromotionAvailable,
      this.centerDeliveryPrices,
      this.centerLocation,
      this.centerOperatingHours});

  LaundryCenter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    alias = json['alias'];
    description = json['description'];
    if (json['centerServices'] != null) {
      centerServices = <CenterServices>[];
      json['centerServices'].forEach((v) {
        centerServices!.add(new CenterServices.fromJson(v));
      });
    }
    rating = json['rating'];
    numOfRating = json['numOfRating'];
    phone = json['phone'];
    centerAddress = json['centerAddress'];
    distance = json['distance'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    monthOff = json['monthOff'];
    hasDelivery = json['hasDelivery'];
    hasOnlinePayment = json['hasOnlinePayment'];
    isOpening = json['isOpening'];
    numOfPromotionAvailable = json['numOfPromotionAvailable'];
    if (json['centerDeliveryPrices'] != null) {
      centerDeliveryPrices = <CenterDeliveryPrice>[];
      json['centerDeliveryPrices'].forEach((v) {
        centerDeliveryPrices?.add(new CenterDeliveryPrice.fromJson(v));
      });
    }
    centerLocation = json['centerLocation'] != null ? new CenterLocation.fromJson(json['centerLocation']) : null;
    if (json['centerOperatingHours'] != null) {
      centerOperatingHours = <CenterOperatingHours>[];
      json['centerOperatingHours'].forEach((v) {
        centerOperatingHours!.add(new CenterOperatingHours.fromJson(v));
      });
    }
  }
}

class CenterServices {
  int? serviceCategoryID;
  String? serviceCategoryName;
  List<Service>? services;

  CenterServices({
    this.serviceCategoryID,
    this.serviceCategoryName,
    this.services,
  });

  CenterServices.fromJson(Map<String, dynamic> json) {
    serviceCategoryID = json['serviceCategoryID'];
    serviceCategoryName = json['serviceCategoryName'];
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services!.add(new Service.fromJson(v));
      });
    }
  }
}

class CenterLocation {
  double? latitude;
  double? longitude;

  CenterLocation({this.latitude, this.longitude});

  CenterLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}

class CenterOperatingHours {
  int? day;
  String? openTime;
  String? closeTime;

  CenterOperatingHours({this.day, this.openTime, this.closeTime});

  CenterOperatingHours.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
  }
}
// class LaundryCenter {
//   String? thumbnail;
//   String? title;
//   double? distance;
//   double? rating;
//   LaundryCenter({
//     this.thumbnail,
//     this.title,
//     this.distance,
//     this.rating,
//   });
// }

// List<LaundryCenter> centerList = [
//   LaundryCenter(
//       thumbnail: 'assets/images/post/service.png',
//       title: 'abcd',
//       distance: 0,
//       rating: 2.3)
// ];
