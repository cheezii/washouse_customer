// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';

import 'package:washouse_customer/resource/models/cart_item.dart';
import 'package:washouse_customer/screens/cart/checkout_screen.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../components/constants/text_constants.dart';
import '../../../../resource/controller/cart_provider.dart';

class FillAddressScreen extends StatefulWidget {
  const FillAddressScreen({super.key});

  @override
  State<FillAddressScreen> createState() => _FillAddressScreenState();
}

class _FillAddressScreenState extends State<FillAddressScreen> {
  BaseController baseController = BaseController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  GlobalKey<FormState> _formNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formPhoneNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formAddressKey = GlobalKey<FormState>();
  final typePhoneNum = RegExp(r'(((\+|)84)|0)(3|5|7|8|9)+([0-9]{8})\b');
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
    List<CartItem> cartItems = Provider.of<CartProvider>(context).cartItems;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          child: Text('Thông tin khách hàng',
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
              Form(
                key: _formNameKey,
                child: FillingShippingInfo(
                  lableText: 'Họ và tên',
                  hintText: 'Nhập họ và tên của bạn',
                  controller: nameController,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formPhoneNumberKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Không được để trống trường này';
                    }
                    if (!typePhoneNum.hasMatch(value)) {
                      return 'Số điện thoại phải có mười số';
                    }
                  },
                  onSaved: (newValue) {
                    phoneController.text = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Số điện thoại',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    hintText: 'Nhập số điện thoại của bạn',
                    hintStyle: TextStyle(
                      color: textNoteColor,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formAddressKey,
                child: FillingShippingInfo(
                  lableText: 'Địa chỉ cá nhân',
                  hintText: 'Nhập số nhà, tên đường...',
                  controller: adressController,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Tỉnh / thành phố',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              DropdownButton(
                isDense: true,
                isExpanded: true,
                items: <String>[
                  'Thành phố Hồ Chí Minh',
                  'Chọn tỉnh / thành phố'
                ].map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                underline: Container(
                  height: 1,
                  color: Colors.grey.shade500,
                ),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                iconSize: 30,
                hint: const Text('Thành phố Hồ Chí Minh'),
                style: const TextStyle(color: textColor),
                onChanged: null,
              ),
              const SizedBox(height: 25),
              const Text(
                'Quận / huyện',
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
                underline: Container(
                  height: 1,
                  color: Colors.grey.shade500,
                ),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                iconSize: 30,
                value: myDistrict,
                hint: const Text('Chọn quận/huyện'),
                style: const TextStyle(color: textColor),
                onChanged: (String? newValue) {
                  setState(() {
                    myWard = null;
                    myDistrict = newValue!;
                    getWardsList();
                    isSelectedDistrict = true;
                    if (myWard!.isNotEmpty) {
                      myWard = '';
                    }
                  });
                },
              ),
              const SizedBox(height: 25),
              const Text(
                'Phường / xã',
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
                underline: Container(
                  height: 1,
                  color: Colors.grey.shade500,
                ),
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
            onPressed: () async {
              if (_formNameKey.currentState!.validate() &&
                  _formPhoneNumberKey.currentState!.validate() &&
                  _formAddressKey.currentState!.validate()) {
                _formNameKey.currentState!.save();
                _formPhoneNumberKey.currentState!.save();
                _formAddressKey.currentState!.save();
                baseController.saveStringtoSharedPreference(
                    "customerName", nameController.value.text);
                baseController.saveStringtoSharedPreference(
                    "customerAddressString", adressController.value.text);
                baseController.saveStringtoSharedPreference(
                    "customerPhone", phoneController.value.text);
                baseController.saveInttoSharedPreference(
                    "customerWardId", int.parse(myWard!));

                print(
                    '_formNameKey.currentState!=${nameController.value.text}');
                print(
                    'address!=${await baseController.getStringtoSharedPreference("customerAddressString")}');
                await baseController.printAllSharedPreferences();
                // print(
                //     '_formPhoneNumberKey.currentState!=${_formPhoneNumberKey.currentState!}');
                // print(
                //     '_formAddressKey.currentState!=${_formAddressKey.currentState!}');
                // print(
                //     '_formNameKey.currentState!=${_formNameKey.currentState!}');
                // print(
                //     '_formPhoneNumberKey.currentState!=${_formPhoneNumberKey.currentState!}');
                // print(
                //     '_formAddressKey.currentState!=${_formAddressKey.currentState!}');
                // print('myWard=${myWard}');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CheckoutScreen(cart: cartItems[0])));
              }
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
  final TextEditingController controller;
  const FillingShippingInfo({
    Key? key,
    required this.lableText,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Không được để trống trường này';
        }
      },
      onSaved: (newValue) {
        controller.text = newValue!;
      },
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
      controller: controller,
      style: const TextStyle(
        color: textColor,
        fontSize: 16,
      ),
    );
  }
}
