// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'package:washouse_customer/resource/controller/base_controller.dart';
import 'package:washouse_customer/utils/price_util.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/controller/account_controller.dart';
import '../../resource/controller/center_controller.dart';
import '../../resource/models/center_operating_time.dart';
import '../../resource/models/wallet.dart';
import '../../resource/provider/cart_provider.dart';
import '../../resource/models/cart_item.dart';
import '../../utils/custom_timer_picker_util.dart';
import 'components/checkout/order_card.dart';
import 'components/checkout/service_ordered.dart';
import 'information/shipping/shipping_address.dart';
import 'information/shipping/shipping_method.dart';

class CheckoutScreen extends StatefulWidget {
  final CartItem cart;
  const CheckoutScreen({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  BaseController baseController = BaseController();
  TextEditingController noteController = TextEditingController();
  AccountController accountController = AccountController();
  CenterController centerController = CenterController();

  int payment = 0;
  int? h, m;
  int? _centerId;

  TimeOfDay? minToday;
  TimeOfDay? maxToday;
  TimeOfDay? minTomorrow;
  TimeOfDay? maxTomorrow;

  bool isLoading = false;
  bool checkSendOrder = false;
  bool isHidden = true;
  bool isHaveTransaction = true;
  bool isHaveWallet = false;

  Wallet? _wallet;

  String? sendOrderDate;
  String sendOrderTime = 'Chọn giờ';

  Future getCenterOperatingTime() async {
    CenterOperatingTime centerOperatingTime;
    var centerId = await baseController.getInttoSharedPreference("centerId");
    print('centerId $centerId');
    var _centerOperatingTime =
        await centerController.getCenterOperatingTime(centerId);
    if (_centerOperatingTime.operatingTimes != null) {
      DateTime now = DateTime.now();
      int dayOfWeek = now.weekday;

// Set Sunday as 0 and Saturday as 6
      //dayOfWeek = (dayOfWeek + 6) % 7;
      var today = _centerOperatingTime.operatingTimes!
          .firstWhere((element) => element.day! == dayOfWeek);
      var tomorrow = _centerOperatingTime.operatingTimes!
          .firstWhere((element) => element.day! == ((dayOfWeek + 1) % 7));
      setState(() {
        _centerId = centerId;
        if (today.closeTime != null) {
          maxToday = TimeOfDay(
              hour: int.parse(today.closeTime!.substring(0, 2)),
              minute: int.parse(today.closeTime!.substring(3, 5)));
        }
        if (tomorrow.openTime != null) {
          minTomorrow = TimeOfDay(
              hour: int.parse(tomorrow.openTime!.substring(0, 2)),
              minute: int.parse(tomorrow.openTime!.substring(3, 5)));
        }
        print(minTomorrow);
      });
    }
  }

  void getMyWallet() async {
    setState(() {
      isLoading = true;
    });

    try {
      Wallet? wallet = await accountController.getMyWallet();
      if (wallet != null) {
        setState(() {
          _wallet = wallet;
          isHaveWallet = true;
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
      print('Error loading wallet: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyWallet();
    getCenterOperatingTime();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: LoadingAnimationWidget.prograssiveDots(
            color: kPrimaryColor, size: 50),
      );
    } else {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              kPrimaryColor, //Theme.of(context).scaffoldBackgroundColor
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: const Align(
            alignment: Alignment.center,
            child: Text('Thanh toán',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 22),
              child: Icon(Icons.abc, color: kPrimaryColor),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const ShippingAddress(),
              // separateLine(),
              const SizedBox(height: 16),
              const ServiceOrdered(), //map data của cart vào cái này
              separateLine(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Phương thức thanh toán',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 35,
                                child: Image.asset(
                                    'assets/images/shipping/cash-on-delivery.png'),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Thanh toán bằng tiền mặt',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Radio(
                            activeColor: kPrimaryColor,
                            value: 0,
                            groupValue: payment,
                            onChanged: (newVal) {
                              setState(() {
                                payment = newVal!;
                                baseController.saveInttoSharedPreference(
                                    "paymentMethod", 0);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    isHaveWallet
                        ? Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            height: 50,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 35,
                                      child: Image.asset(
                                          'assets/images/shipping/vnpay-icon.png'),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Thanh toán bằng Ví Washouse',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Radio(
                                  value: 1,
                                  groupValue: payment,
                                  onChanged: (newVal) {
                                    setState(() {
                                      payment = newVal!;
                                      print(newVal);
                                      baseController.saveInttoSharedPreference(
                                          "paymentMethod", 1);
                                    });
                                  },
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                  ],
                ),
              ),
              separateLine(),
              const ShippingMethod(),
              separateLine(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text(
                      'Thời gian gửi đơn',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
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
                            onChanged: (String? newValue) async {
                              setState(() {
                                sendOrderDate = newValue!;
                              });
                              String? chooseDate;
                              if (newValue!.compareTo("Hôm nay") == 0) {
                                chooseDate = DateFormat('dd-MM-yyyy')
                                    .format(DateTime.now());
                              } else if (newValue.compareTo("Ngày mai") == 0) {
                                chooseDate = DateFormat('dd-MM-yyyy').format(
                                    DateTime.now().add(Duration(days: 1)));
                              }
                              baseController.saveStringtoSharedPreference(
                                  "preferredDropoffTime_Date", chooseDate!);
                              print(await baseController
                                  .getStringtoSharedPreference(
                                      "preferredDropoffTime_Date"));
                            },
                          ),
                        ),
                        sendOrderDate != null
                            ? Center(
                                child: Column(
                                  children: [
                                    sendOrderDate!.compareTo("Hôm nay") == 0
                                        ?

                                        /// wrap with sizedBOx
                                        SizedBox(
                                            height: 200,
                                            child: CustomTimerPicker(
                                              intiTimeOfDay: TimeOfDay.now(),
                                              maxTimeOfDay: maxToday,
                                              onChanged: (selectedHour,
                                                  selectedMinute) async {
                                                setState(() {
                                                  h = selectedHour;
                                                  m = selectedMinute;
                                                });
                                                debugPrint(
                                                    "H: $selectedHour minute: $selectedMinute");
                                                String hourSave = h
                                                    .toString()
                                                    .padLeft(2, '0');
                                                String minuteSave = m
                                                    .toString()
                                                    .padLeft(2, '0');
                                                String secondSave = '00';
                                                String sendOrderTimeSave =
                                                    '$hourSave:$minuteSave:$secondSave';
                                                baseController
                                                    .saveStringtoSharedPreference(
                                                        "preferredDropoffTime_Time",
                                                        sendOrderTimeSave);
                                                print(await baseController
                                                    .getStringtoSharedPreference(
                                                        "preferredDropoffTime_Time"));
                                              },
                                            ),
                                          )
                                        : SizedBox(
                                            height: 200,
                                            child: CustomTimerPicker(
                                              intiTimeOfDay:
                                                  minTomorrow, // Giờ bắt đầu ngày mai
                                              maxTimeOfDay:
                                                  TimeOfDay.now().replacing(
                                                hour: TimeOfDay.now().hour +
                                                            24 >=
                                                        24
                                                    ? TimeOfDay.now().hour +
                                                        24 -
                                                        24
                                                    : TimeOfDay.now().hour + 24,
                                                minute: TimeOfDay.now().minute,
                                              ), // Giờ này 24 tiếng sau.
                                              onChanged: (selectedHour,
                                                  selectedMinute) async {
                                                setState(() {
                                                  h = selectedHour;
                                                  m = selectedMinute;
                                                });
                                                debugPrint(
                                                    "H: $selectedHour minute: $selectedMinute");

                                                String hourSave = h
                                                    .toString()
                                                    .padLeft(2, '0');
                                                String minuteSave = m
                                                    .toString()
                                                    .padLeft(2, '0');
                                                String secondSave = '00';
                                                String sendOrderTimeSave =
                                                    '$hourSave:$minuteSave:$secondSave';
                                                baseController
                                                    .saveStringtoSharedPreference(
                                                        "preferredDropoffTime_Time",
                                                        sendOrderTimeSave);
                                                print(await baseController
                                                    .getStringtoSharedPreference(
                                                        "preferredDropoffTime_Time"));
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                height: 0,
                              ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 10),
              separateLine(),
              Consumer<CartProvider>(
                builder: (context, value, child) {
                  {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Chi tiết thanh toán',
                            style: TextStyle(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Tổng đơn hàng:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      //'${PriceUtils().convertFormatPrice(value.getTotalPrice().round())} đ',
                                      (value.cartItems != null &&
                                              value.cartItems.isNotEmpty)
                                          ? '${PriceUtils().convertFormatPrice(value.cartItems.fold(0.0, (sum, item) => sum + item.price!).round())} đ'
                                          : '0 đ',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Chiết khấu:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      (value.discount != null &&
                                              value.discount != 0)
                                          ? '- ${PriceUtils().convertFormatPrice((value.cartItems.fold(0.0, (sum, item) => sum + item.price!) * (value.discount)).round())} đ'
                                          : '- 0 đ',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Phí vận chuyển:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      (value.deliveryPrice != null &&
                                              value.deliveryPrice != 0)
                                          ? '${PriceUtils().convertFormatPrice(value.deliveryPrice.round())} đ'
                                          : '0 đ',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Divider(
                                  height: 40,
                                  color: Colors.grey.shade300,
                                  thickness: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Tổng cộng dự kiến:',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      //'${PriceUtils().convertFormatPrice(value.getTotalPrice().round())} đ',
                                      (value.cartItems.isNotEmpty)
                                          ? '${PriceUtils().convertFormatPrice((value.cartItems.fold(0.0, (sum, item) => sum + item.price!) * (1 - value.discount) + value.deliveryPrice).round())} đ'
                                          : '0 đ',

                                      style: const TextStyle(
                                          fontSize: 17,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  }
                },
              ),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.note_alt_outlined,
                    color: textColor.withOpacity(.5),
                  ),
                  hintText: 'Có ghi chú cho trung tâm?',
                ),
                controller: noteController,
                onSubmitted: (String value) async {
                  setState(() {
                    noteController.text = value;
                  });
                  await baseController.saveStringtoSharedPreference(
                      "customerMessage", value);
                  print(value);
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const OrderCard(),
      );
    }
  }

  Column separateLine() {
    return Column(
      children: [
        const SizedBox(height: 15),
        Container(
          height: 10,
          width: double.infinity,
          color: Colors.grey.shade200,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
