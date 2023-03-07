// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:washouse_customer/models/cart.dart';
import 'package:washouse_customer/screens/cart/checkout_screen.dart';

import '../../../../components/constants/color_constants.dart';

class FillAddressScreen extends StatefulWidget {
  const FillAddressScreen({super.key});

  @override
  State<FillAddressScreen> createState() => _FillAddressScreenState();
}

class _FillAddressScreenState extends State<FillAddressScreen> {
  List _districtsList = [];
  List _wardsList = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/location.json');
    final data = await json.decode(response);
    //final data = jsonDecode(response);
    setState(() {
      _districtsList = data['districts'];
      _wardsList = data['wards'];
    });
  }

  String _myDistrict = '';
  String _myWard = '';

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            kPrimaryColor, //Theme.of(context).scaffoldBackgroundColor
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
        title: const Align(
          alignment: Alignment.center,
          child: Text('Thông tin giao hàng',
              style: TextStyle(color: Colors.white, fontSize: 24)),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 22),
            child: Icon(
              Icons.abc,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              const FillingShippingInfo(
                lableText: 'Tên người nhận',
                hintText: 'Nhập họ và tên người nhận',
              ),
              const SizedBox(height: 20),
              const FillingShippingInfo(
                lableText: 'Số điện thoại',
                hintText: 'Nhập số điện thoại người nhận hàng',
              ),
              const SizedBox(height: 20),
              const FillingShippingInfo(
                lableText: 'Địa chỉ nhận hàng',
                hintText: 'Nhập số nhà, tên đường...',
              ),
              const SizedBox(height: 20),
              // DropdownButton(
              //   items: _districtsList
              //       .map<DropdownMenuItem>((value) =>
              //           DropdownMenuItem(value: value, child: Text(value)))
              //       .toList(),
              //   value: _dropdownDistrict,
              //   hint: Text('Chọn quận/huyện'),
              //   style: TextStyle(color: textNoteColor),
              //   onChanged: (value) {
              //     setState(() {
              //       if (value != null) _dropdownDistrict = value;
              //     });
              //   },
              // ),
              DropdownButton(
                items: _districtsList.map((item) {
                  return DropdownMenuItem(
                    value: item['district_id'].toString(),
                    child: Text(item['district_name']),
                  );
                }).toList(),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                iconSize: 30,
                value: _myDistrict,
                hint: const Text('Chọn quận/huyện'),
                style: const TextStyle(color: textColor),
                onChanged: (newValue) {
                  setState(() {
                    if (newValue != null) _myDistrict = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                items: _districtsList.map((item) {
                  return DropdownMenuItem(
                    value: item['ward_id'].toString(),
                    child: Text(item['ward_name']),
                  );
                }).toList(),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                iconSize: 30,
                value: _myWard,
                hint: const Text('Chọn phường/xã'),
                style: const TextStyle(color: textColor),
                onChanged: (newValue) {
                  setState(() {
                    if (newValue != null) _myWard = newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xffdadada).withOpacity(0.15),
            ),
          ],
        ),
        child: SizedBox(
          width: 190,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                backgroundColor: kPrimaryColor),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CheckoutScreen(cart: demoCarts[0])));
            },
            child: const Text(
              'Xác nhận',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}

class FillingShippingInfo extends StatelessWidget {
  final String lableText;
  final String hintText;
  const FillingShippingInfo({
    Key? key,
    required this.lableText,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: lableText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: textNoteColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
