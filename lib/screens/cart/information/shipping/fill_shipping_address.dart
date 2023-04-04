// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:washouse_customer/resource/models/cart.dart';
import 'package:washouse_customer/screens/cart/checkout_screen.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../components/constants/text_constants.dart';

class FillAddressScreen extends StatefulWidget {
  const FillAddressScreen({super.key});

  @override
  State<FillAddressScreen> createState() => _FillAddressScreenState();
}

class _FillAddressScreenState extends State<FillAddressScreen> {
  List districtList = [];
  List wardList = [];

  String? myDistrict;
  String? myWard;

  var isSelectedDistrict = false;

  Future getDistrictList() async {
    Response response = await get(Uri.parse('$baseUrl/districts'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        districtList = data['data'];
      });
    } else {
      throw Exception("Lỗi khi load Json");
    }
  }

  Future getWardsList() async {
    int districtId = int.parse(myDistrict!);
    Response response =
        await get(Uri.parse('$baseUrl/districts/$districtId/wards'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        wardList = data['data'];
      });
    } else {
      throw Exception("Lỗi khi load Json");
    }
  }

  @override
  void initState() {
    getDistrictList();
    super.initState();
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const Text(
                'Quận/huyện',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              DropdownButton(
                isDense: true,
                isExpanded: true,
                items: districtList.map((item) {
                  return DropdownMenuItem(
                    value: item['districtId'].toString(),
                    child: Text(item['districtName']),
                  );
                }).toList(),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                iconSize: 30,
                value: myDistrict,
                hint: const Text('Chọn quận/huyện'),
                style: const TextStyle(color: textColor),
                onChanged: (String? newValue) {
                  setState(() {
                    myDistrict = newValue!;
                    getWardsList();
                    isSelectedDistrict = true;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Phường/xã',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              //if (isSelectedDistrict)
              DropdownButton(
                isExpanded: true,
                items: wardList.map((item) {
                  return DropdownMenuItem(
                    value: item['wardId'].toString(),
                    child: Text(item['wardName']),
                  );
                }).toList(),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                iconSize: 30,
                value: myWard,
                hint: const Text('Chọn phường/xã'),
                style: const TextStyle(color: textColor),
                onChanged: (newValue) {
                  setState(() {
                    myWard = newValue!;
                  });
                },
              ),
            ],
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
