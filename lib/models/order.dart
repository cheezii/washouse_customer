// ignore_for_file: public_member_api_docs, sort_constructors_first
class Order {
  String id;
  double freight;
  String centerName;
  String deliveryType;
  DateTime createdDate;
  String serviceName;
  int status; //0 = đã hủy, 1 = chờ xác nhận, 2 = chờ xử lý, 3 = chờ giao, 4 = đã hoàn thành
  int quantity;
  Order({
    required this.id,
    required this.freight,
    required this.centerName,
    required this.deliveryType,
    required this.createdDate,
    required this.serviceName,
    required this.quantity,
    required this.status,
  });
}

List<Order> orderList = [
  Order(
    id: '202308031111',
    freight: 0.0,
    centerName: 'The Clean House',
    deliveryType: 'Không vận chuyển',
    createdDate: DateTime(8, 3, 2023, 13, 44),
    serviceName: 'Giặt hấp caravat',
    quantity: 2,
    status: 2,
  ),
  Order(
    id: '202308031111',
    freight: 0.0,
    centerName: 'The Clean House',
    deliveryType: 'Không vận chuyển',
    createdDate: DateTime(8, 3, 2023, 13, 44),
    serviceName: 'Giặt hấp caravat',
    quantity: 2,
    status: 1,
  ),
  Order(
    id: '202308032222',
    freight: 0.0,
    centerName: 'Washouse',
    deliveryType: 'Vận chuyển 1 chiều đi',
    createdDate: DateTime(4, 3, 2023, 8, 20),
    serviceName: 'Giặt gối cổ',
    quantity: 2,
    status: 4,
  ),
  Order(
    id: '202308032222',
    freight: 0.0,
    centerName: 'Washouse',
    deliveryType: 'Vận chuyển 1 chiều đi',
    createdDate: DateTime(4, 3, 2023, 8, 20),
    serviceName: 'Giặt gối cổ',
    quantity: 2,
    status: 0,
  ),
];
