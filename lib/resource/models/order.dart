// ignore_for_file: public_member_api_docs, sort_constructors_first
class Order {
  String id;
  double freight;
  String centerName;
  String deliveryType;
  DateTime createdDate;
  String serviceName;
  String status; //0 = đang chờ, 1 = xác nhận, 2 = xử lý, 3 = sẵn sàng, 4 = hoàn tất, 5 = đã hủy
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

// List<Order> orderList = [
//   Order(
//     id: '202308031111',
//     freight: 0.0,
//     centerName: 'The Clean House',
//     deliveryType: 'Không vận chuyển',
//     createdDate: DateTime(8, 3, 2023, 13, 44),
//     serviceName: 'Giặt hấp caravat',
//     quantity: 2,
//     status: 'Đang chờ',
//   ),
//   Order(
//     id: '202308031111',
//     freight: 0.0,
//     centerName: 'The Clean House',
//     deliveryType: 'Không vận chuyển',
//     createdDate: DateTime(8, 3, 2023, 13, 44),
//     serviceName: 'Giặt hấp caravat',
//     quantity: 2,
//     status: 'Xác nhận',
//   ),
//   Order(
//     id: '202308032222',
//     freight: 0.0,
//     centerName: 'Washouse',
//     deliveryType: 'Vận chuyển 1 chiều đi',
//     createdDate: DateTime(4, 3, 2023, 8, 20),
//     serviceName: 'Giặt gối cổ',
//     quantity: 2,
//     status: 'Xử lý',
//   ),
//   Order(
//     id: '202308032222',
//     freight: 0.0,
//     centerName: 'Washouse',
//     deliveryType: 'Vận chuyển 1 chiều đi',
//     createdDate: DateTime(4, 3, 2023, 8, 20),
//     serviceName: 'Giặt gối cổ',
//     quantity: 2,
//     status: 'Sẵn sàng',
//   ),
//   Order(
//     id: '202308032222',
//     freight: 0.0,
//     centerName: 'Washouse',
//     deliveryType: 'Vận chuyển 1 chiều đi',
//     createdDate: DateTime(4, 3, 2023, 8, 20),
//     serviceName: 'Giặt gối cổ',
//     quantity: 2,
//     status: 'Hoàn tất',
//   ),
//   Order(
//     id: '202308032222',
//     freight: 0.0,
//     centerName: 'Washouse',
//     deliveryType: 'Vận chuyển 1 chiều đi',
//     createdDate: DateTime(4, 3, 2023, 8, 20),
//     serviceName: 'Giặt gối cổ',
//     quantity: 2,
//     status: 'Đã hủy',
//   ),
// ];
