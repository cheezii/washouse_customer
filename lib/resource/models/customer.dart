// ignore_for_file: public_member_api_docs, sort_constructors_first
class Customer {
  int id;
  String accountId;
  String firstName;
  String lastName;
  String gender;
  DateTime dob;
  String address;
  String phone;
  String email;
  String password;
  bool status;
  Customer({
    required this.id,
    required this.accountId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dob,
    required this.address,
    required this.phone,
    required this.email,
    required this.password,
    required this.status,
  });
}

Customer customer = Customer(
  id: 1,
  accountId: 'chipnq',
  firstName: 'Chi',
  lastName: 'Phan',
  gender: 'F',
  dob: DateTime(2001, 1, 26),
  address: '477 Man Thiện',
  phone: '0945620313',
  email: 'chipnquynh@gmail.com',
  password: '123456',
  status: true,
);
