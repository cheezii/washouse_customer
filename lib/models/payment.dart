// ignore_for_file: public_member_api_docs, sort_constructors_first
class Payment {
  int id;
  String name;
  Payment({
    required this.id,
    required this.name,
  });
}

List<Payment> payment = [
  Payment(id: 1, name: 'Cash'),
  Payment(id: 2, name: 'Momo'),
];
