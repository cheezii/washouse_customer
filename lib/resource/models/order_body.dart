class OrderBody {
  int? centerId;
  Order? order;
  List<Order_Details>? orderDetails;
  List<Deliveries>? deliveries;
  String? promoCode;
  int? paymentMethod;

  OrderBody({this.centerId, this.order, this.orderDetails, this.deliveries, this.promoCode, this.paymentMethod});

  OrderBody.fromJson(Map<String, dynamic> json) {
    centerId = json['centerId'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    if (json['orderDetails'] != null) {
      orderDetails = <Order_Details>[];
      json['orderDetails'].forEach((v) {
        orderDetails!.add(new Order_Details.fromJson(v));
      });
    }
    if (json['deliveries'] != null) {
      deliveries = <Deliveries>[];
      json['deliveries'].forEach((v) {
        deliveries!.add(new Deliveries.fromJson(v));
      });
    }
    promoCode = json['promoCode'];
    paymentMethod = json['paymentMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['centerId'] = this.centerId;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails!.map((v) => v.toJson()).toList();
    }
    if (this.deliveries != null) {
      data['deliveries'] = this.deliveries!.map((v) => v.toJson()).toList();
    }
    data['promoCode'] = this.promoCode;
    data['paymentMethod'] = this.paymentMethod;
    return data;
  }
}

class Order {
  String? customerName;
  String? customerAddressString;
  int? customerWardId;
  String? customerEmail;
  String? customerMobile;
  String? customerMessage;
  int? deliveryType;
  double? deliveryPrice;
  String? preferredDropoffTime;
  String? preferredDeliverTime;

  Order(
      {this.customerName,
      this.customerAddressString,
      this.customerWardId,
      this.customerEmail,
      this.customerMobile,
      this.customerMessage,
      this.deliveryType,
      this.deliveryPrice,
      this.preferredDropoffTime,
      this.preferredDeliverTime});

  Order.fromJson(Map<String, dynamic> json) {
    customerName = json['customerName'];
    customerAddressString = json['customerAddressString'];
    customerWardId = json['customerWardId'];
    customerEmail = json['customerEmail'];
    customerMobile = json['customerMobile'];
    customerMessage = json['customerMessage'];
    deliveryType = json['deliveryType'];
    deliveryPrice = json['deliveryPrice'];
    preferredDropoffTime = json['preferredDropoffTime'];
    preferredDeliverTime = json['preferredDeliverTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['customerAddressString'] = this.customerAddressString;
    data['customerWardId'] = this.customerWardId;
    data['customerEmail'] = this.customerEmail;
    data['customerMobile'] = this.customerMobile;
    data['customerMessage'] = this.customerMessage;
    data['deliveryType'] = this.deliveryType;
    data['deliveryPrice'] = this.deliveryPrice;
    data['preferredDropoffTime'] = this.preferredDropoffTime;
    data['preferredDeliverTime'] = this.preferredDeliverTime;
    return data;
  }
}

class Order_Details {
  int? serviceId;
  double? measurement;
  double? price;
  String? customerNote;
  String? staffNote;

  Order_Details({this.serviceId, this.measurement, this.price, this.customerNote, this.staffNote});

  Order_Details.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    measurement = json['measurement'];
    price = json['price'];
    customerNote = json['customerNote'];
    staffNote = json['staffNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = this.serviceId;
    data['measurement'] = this.measurement;
    data['price'] = this.price;
    data['customerNote'] = this.customerNote;
    data['staffNote'] = this.staffNote;
    return data;
  }
}

class Deliveries {
  String? addressString;
  int? wardId;
  bool? deliveryType;

  Deliveries({this.addressString, this.wardId, this.deliveryType});

  Deliveries.fromJson(Map<String, dynamic> json) {
    addressString = json['addressString'];
    wardId = json['wardId'];
    deliveryType = json['deliveryType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressString'] = this.addressString;
    data['wardId'] = this.wardId;
    data['deliveryType'] = this.deliveryType;
    return data;
  }
}
