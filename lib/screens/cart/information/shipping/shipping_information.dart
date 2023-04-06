// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:washouse_customer/screens/cart/information/shipping/fill_shipping_address.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../components/constants/text_constants.dart';
import '../../../../resource/controller/cart_provider.dart';
import '../../../../resource/models/cart_item.dart';
import '../../checkout_screen.dart';

class FillShippingInformation extends StatefulWidget {
  final bool isSend;
  final bool isReceive;
  const FillShippingInformation({
    Key? key,
    required this.isSend,
    required this.isReceive,
  }) : super(key: key);

  @override
  State<FillShippingInformation> createState() =>
      _FillShippingInformationState();
}

class _FillShippingInformationState extends State<FillShippingInformation> {
  TextEditingController sendAdressController = TextEditingController();
  TextEditingController receiveAdressController = TextEditingController();
  GlobalKey<FormState> _formSendAddressKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formReceiveAddressKey = GlobalKey<FormState>();
  bool checkSendOrder = false;
  bool checkReceiveOrder = false;

  String? sendOrderDate;
  String? receiveOrderDate;
  String sendOrderTime = 'Chọn giờ';
  String receiveOrderTime = 'Chọn giờ';
  String? sendDistrict;
  String? sendWard;
  String? receiveDistrict;
  String? receiveWard;

  List districtList = [];
  List wardList = [];

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

  Future getWardsList(String district) async {
    int districtId = int.parse(district);
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            kPrimaryColor, //Theme.of(context).scaffoldBackgroundColor
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
        title: const Align(
          alignment: Alignment.center,
          child: Text('Thông tin vận chuyển',
              style: TextStyle(color: Colors.white, fontSize: 22)),
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Thời gian gửi đơn',
                    style: TextStyle(
                        fontSize: 18,
                        color: textBoldColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  FlutterSwitch(
                      value: checkSendOrder,
                      width: 50,
                      height: 25,
                      toggleSize: 20,
                      onToggle: (val) {
                        setState(() {
                          checkSendOrder = val;
                        });
                      })
                ],
              ),
              const SizedBox(height: 10),
              checkSendOrder
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 40,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: textColor, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 0, bottom: 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: textColor, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            isDense: true,
                            isExpanded: true,
                            items: <String>['Hôm nay', 'Ngày mai']
                                .map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 25,
                            ),
                            iconSize: 30,
                            hint: const Text('Chọn ngày'),
                            value: sendOrderDate,
                            style: const TextStyle(color: textColor),
                            onChanged: (String? newValue) {
                              setState(() {
                                sendOrderDate = newValue!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              TimeOfDay? orderTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (orderTime != null) {
                                setState(() {
                                  sendOrderTime =
                                      '${orderTime.hour}:${orderTime.minute}';
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 19, vertical: 10),
                              foregroundColor: kPrimaryColor.withOpacity(.7),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: textColor, width: 1),
                              ),
                              backgroundColor: kBackgroundColor,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  sendOrderTime,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.watch_later_outlined,
                                  size: 20,
                                  color: Colors.grey.shade600,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Thời gian trả đơn',
                    style: TextStyle(
                        fontSize: 18,
                        color: textBoldColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  FlutterSwitch(
                      value: checkReceiveOrder,
                      width: 50,
                      height: 25,
                      toggleSize: 20,
                      onToggle: (val) {
                        setState(() {
                          checkReceiveOrder = val;
                        });
                      })
                ],
              ),
              const SizedBox(height: 10),
              checkReceiveOrder
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 40,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: textColor, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 0, bottom: 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: textColor, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            isDense: true,
                            isExpanded: true,
                            items: <String>['Hôm nay', 'Ngày mai']
                                .map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 25,
                            ),
                            iconSize: 30,
                            hint: const Text('Chọn ngày'),
                            value: sendOrderDate,
                            style: const TextStyle(color: textColor),
                            onChanged: (String? newValue) {
                              setState(() {
                                receiveOrderDate = newValue!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              TimeOfDay? orderTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (orderTime != null) {
                                setState(() {
                                  receiveOrderTime =
                                      '${orderTime.hour}:${orderTime.minute}';
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 19, vertical: 10),
                              foregroundColor: kPrimaryColor.withOpacity(.7),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: textColor, width: 1),
                              ),
                              backgroundColor: kBackgroundColor,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  receiveOrderTime,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.watch_later_outlined,
                                  size: 20,
                                  color: Colors.grey.shade600,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 10),
              widget.isSend
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Địa chỉ lấy đơn',
                          style: TextStyle(
                              fontSize: 18,
                              color: textBoldColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Form(
                          key: _formSendAddressKey,
                          child: FillingShippingInfo(
                            lableText: 'Địa chỉ',
                            hintText: 'Nhập địa chỉ',
                            controller: sendAdressController,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 20,
                          ),
                          iconSize: 30,
                          hint: const Text('Thành phố Hồ Chí Minh'),
                          style: const TextStyle(color: textColor),
                          onChanged: null,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Quận / huyện',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 40,
                                  width: 150,
                                  child: DropdownButton(
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
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 20,
                                    ),
                                    iconSize: 30,
                                    value: sendDistrict,
                                    hint: const Text('Chọn quận/huyện'),
                                    style: const TextStyle(color: textColor),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        sendDistrict = newValue!;
                                        getWardsList(newValue);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Phường / xã',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: DropdownButton(
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
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 20,
                                    ),
                                    iconSize: 30,
                                    value: sendWard,
                                    hint: const Text('Chọn phường/xã'),
                                    style: const TextStyle(color: textColor),
                                    onChanged: (newValue) {
                                      setState(() {
                                        sendWard = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 10),
              widget.isReceive
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Địa chỉ trả đơn',
                          style: TextStyle(
                              fontSize: 18,
                              color: textBoldColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Form(
                          key: _formReceiveAddressKey,
                          child: FillingShippingInfo(
                            lableText: 'Địa chỉ',
                            hintText: 'Nhập địa chỉ',
                            controller: receiveAdressController,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 20,
                          ),
                          iconSize: 30,
                          hint: const Text('Thành phố Hồ Chí Minh'),
                          style: const TextStyle(color: textColor),
                          onChanged: null,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Quận / huyện',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 40,
                                  width: 150,
                                  child: DropdownButton(
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
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 20,
                                    ),
                                    iconSize: 30,
                                    value: receiveDistrict,
                                    hint: const Text('Chọn quận/huyện'),
                                    style: const TextStyle(color: textColor),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        receiveDistrict = newValue!;
                                        getWardsList(newValue);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Phường / xã',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: DropdownButton(
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
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 20,
                                    ),
                                    iconSize: 30,
                                    value: receiveWard,
                                    hint: const Text('Chọn phường/xã'),
                                    style: const TextStyle(color: textColor),
                                    onChanged: (newValue) {
                                      setState(() {
                                        receiveWard = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  : Container(),
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
              // if (_formSendAddressKey.currentState!.validate() ||
              //     _formReceiveAddressKey.currentState!.validate()) {
              //   _formSendAddressKey.currentState!.save();
              //   _formReceiveAddressKey.currentState!.save();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CheckoutScreen(cart: cartItems[0])));
              //}
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
