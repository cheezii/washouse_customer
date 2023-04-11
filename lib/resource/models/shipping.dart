// ignore_for_file: public_member_api_docs, sort_constructors_first
class Shipping {
  String fullName;
  String shippedAddress;
  String shippedPhone;
  Shipping({
    required this.fullName,
    required this.shippedAddress,
    required this.shippedPhone,
  });
}

Shipping shipping = Shipping(
    fullName: 'Phan Nguyễn Quỳnh Chi', shippedAddress: '477 Man Thiện, phường Tăng Nhơn Phú A, thành phố Thủ Đức', shippedPhone: '0912345678');
