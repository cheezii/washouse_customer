class Order_Item {
  String? orderId;
  String? orderDate;
  String? customerName;
  double? totalOrderValue;
  double? discount;
  double? totalOrderPayment;
  String? status;
  int? centerId;
  String? centerName;
  bool? isFeedback;
  bool? isPayment;
  List<OrderedServices>? orderedServices;

  Order_Item(
      {this.orderId,
      this.orderDate,
      this.customerName,
      this.totalOrderValue,
      this.discount,
      this.totalOrderPayment,
      this.status,
      this.centerId,
      this.centerName,
      this.isFeedback,
      this.isPayment,
      this.orderedServices});

  Order_Item.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderDate = json['orderDate'];
    customerName = json['customerName'];
    totalOrderValue = (json['totalOrderValue'] as num?)?.toDouble();
    discount = (json['discount'] as num?)?.toDouble();
    totalOrderPayment = (json['totalOrderPayment'] as num?)?.toDouble();
    status = json['status'];
    centerId = json['centerId'];
    centerName = json['centerName'];
    isFeedback = json['isFeedback'];
    isPayment = json['isPayment'];
    if (json['orderedServices'] != null) {
      orderedServices = <OrderedServices>[];
      json['orderedServices'].forEach((v) {
        orderedServices!.add(new OrderedServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['orderDate'] = this.orderDate;
    data['customerName'] = this.customerName;
    data['totalOrderValue'] = this.totalOrderValue;
    data['discount'] = this.discount;
    data['totalOrderPayment'] = this.totalOrderPayment;
    data['status'] = this.status;
    data['centerId'] = this.centerId;
    data['centerName'] = this.centerName;
    data['isFeedback'] = this.isFeedback;
    data['isPayment'] = this.isPayment;
    if (this.orderedServices != null) {
      data['orderedServices'] = this.orderedServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderedServices {
  int? serviceId;
  String? serviceName;
  String? serviceCategory;
  double? measurement;
  String? unit;
  String? image;
  double? price;

  OrderedServices({this.serviceId, this.serviceName, this.serviceCategory, this.measurement, this.unit, this.image, this.price});

  OrderedServices.fromJson(Map<String, dynamic> json) {
    serviceId = (json['serviceId'] as int?)?.toInt();
    serviceName = json['serviceName'] as String;
    serviceCategory = json['serviceCategory'] as String;
    measurement = (json['measurement'] as num?)?.toDouble();
    unit = json['unit'] as String;
    image = json['image'];
    price = (json['price'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceName'] = this.serviceName;
    data['serviceId'] = this.serviceId;
    data['serviceCategory'] = this.serviceCategory;
    data['measurement'] = this.measurement;
    data['unit'] = this.unit;
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }
}
