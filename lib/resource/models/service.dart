class Service {
  num? serviceId;
  num? categoryId;
  String? serviceName;
  String? description;
  String? image;
  bool? priceType;
  num? price;
  num? minPrice;
  String? unit;
  num? rate;
  List<Prices>? prices;
  num? timeEstimate;
  num? rating;
  num? numOfRating;
  List<int>? ratings;

  Service(
      {this.serviceId,
      this.categoryId,
      this.serviceName,
      this.description,
      this.image,
      this.priceType,
      this.price,
      this.minPrice,
      this.unit,
      this.rate,
      this.prices,
      this.timeEstimate,
      this.rating,
      this.numOfRating,
      this.ratings});

  Service.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    categoryId = json['categoryId'];
    serviceName = json['serviceName'];
    description = json['description'];
    image = json['image'];
    priceType = json['priceType'];
    price = json['price'];
    minPrice = json['minPrice'];
    unit = json['unit'];
    rate = json['rate'];
    if (json['prices'] != null) {
      prices = <Prices>[];
      json['prices'].forEach((v) {
        prices!.add(new Prices.fromJson(v));
      });
    }
    timeEstimate = json['timeEstimate'];
    rating = json['rating'];
    numOfRating = json['numOfRating'];
    ratings = json['ratings'].cast<int>();
  }
}

class Prices {
  num? maxValue;
  num? price;

  Prices({this.maxValue, this.price});

  Prices.fromJson(Map<String, dynamic> json) {
    maxValue = json['maxValue'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxValue'] = this.maxValue;
    data['price'] = this.price;
    return data;
  }
}

// import 'category.dart';
// import 'center.dart';

// class Service {
//   int? id;
//   String? serviceName;
//   String? alias;
//   int? categoryId;
//   String? description;
//   bool? priceType;
//   String? image;
//   int? price;
//   int? minPrice;
//   String? unit;
//   int? rate;
//   int? timeEstimate;
//   bool? isAvailable;
//   String? status;
//   bool? homeFlag;
//   bool? hotFlag;
//   int? rating;
//   int? numOfRating;
//   int? centerId;
//   ServiceCategory? category;
//   LaundryCenter? center;
//   //List<Null>? orderDetails;
//   List<ServiceGalleries>? serviceGalleries;
//   List<ServicePrices>? servicePrices;
//   String? createdDate;
//   String? createdBy;
//   String? updatedDate;
//   String? updatedBy;

//   Service({
//     this.id,
//     this.serviceName,
//     this.alias,
//     this.categoryId,
//     this.description,
//     this.priceType,
//     this.image,
//     this.price,
//     this.minPrice,
//     this.unit,
//     this.rate,
//     this.timeEstimate,
//     this.isAvailable,
//     this.status,
//     this.homeFlag,
//     this.hotFlag,
//     this.rating,
//     this.numOfRating,
//     this.centerId,
//     this.category,
//     this.center,
//     //this.orderDetails,
//     this.serviceGalleries,
//     this.servicePrices,
//     this.createdDate,
//     this.createdBy,
//     this.updatedDate,
//     this.updatedBy,
//   });

//   Service.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     serviceName = json['serviceName'];
//     alias = json['alias'];
//     categoryId = json['categoryId'];
//     description = json['description'];
//     priceType = json['priceType'];
//     image = json['image'];
//     price = json['price'];
//     minPrice = json['minPrice'];
//     unit = json['unit'];
//     rate = json['rate'];
//     timeEstimate = json['timeEstimate'];
//     isAvailable = json['isAvailable'];
//     status = json['status'];
//     homeFlag = json['homeFlag'];
//     hotFlag = json['hotFlag'];
//     rating = json['rating'];
//     numOfRating = json['numOfRating'];
//     centerId = json['centerId'];
//     category = json['category'] != null
//         ? new ServiceCategory.fromJson(json['category'])
//         : null;
//     center = json['center'] != null
//         ? new LaundryCenter.fromJson(json['center'])
//         : null;
//     // if (json['orderDetails'] != null) {
//     // 	orderDetails = <Null>[];
//     // 	json['orderDetails'].forEach((v) { orderDetails!.add(new Null.fromJson(v)); });
//     // }
//     if (json['serviceGalleries'] != null) {
//       serviceGalleries = <ServiceGalleries>[];
//       json['serviceGalleries'].forEach((v) {
//         serviceGalleries!.add(new ServiceGalleries.fromJson(v));
//       });
//     }
//     if (json['servicePrices'] != null) {
//       servicePrices = <ServicePrices>[];
//       json['servicePrices'].forEach((v) {
//         servicePrices!.add(new ServicePrices.fromJson(v));
//       });
//     }
//     createdDate = json['createdDate'];
//     createdBy = json['createdBy'];
//     updatedDate = json['updatedDate'];
//     updatedBy = json['updatedBy'];
//   }
// }

// class ServiceGalleries {
//   int? id;
//   int? serviceId;
//   String? image;
//   String? createdBy;
//   String? createdDate;
//   Null? service;

//   ServiceGalleries(
//       {this.id,
//       this.serviceId,
//       this.image,
//       this.createdBy,
//       this.createdDate,
//       this.service});

//   ServiceGalleries.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     serviceId = json['serviceId'];
//     image = json['image'];
//     createdBy = json['createdBy'];
//     createdDate = json['createdDate'];
//     service = json['service'];
//   }
// }

// class ServicePrices {
//   int? id;
//   int? serviceId;
//   int? maxValue;
//   int? price;
//   Null? service;
//   String? createdDate;
//   String? createdBy;
//   String? updatedDate;
//   String? updatedBy;

//   ServicePrices(
//       {this.id,
//       this.serviceId,
//       this.maxValue,
//       this.price,
//       this.service,
//       this.createdDate,
//       this.createdBy,
//       this.updatedDate,
//       this.updatedBy});

//   ServicePrices.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     serviceId = json['serviceId'];
//     maxValue = json['maxValue'];
//     price = json['price'];
//     service = json['service'];
//     createdDate = json['createdDate'];
//     createdBy = json['createdBy'];
//     updatedDate = json['updatedDate'];
//     updatedBy = json['updatedBy'];
//   }
// }
