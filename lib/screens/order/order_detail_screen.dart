// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skeletons/skeletons.dart';
import 'package:timelines/timelines.dart';
import 'package:washouse_customer/resource/controller/order_controller.dart';
import 'package:flutter/src/widgets/basic.dart' as basic;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:washouse_customer/resource/models/order.dart';
import 'package:washouse_customer/resource/models/response_models/order_detail_information.dart';
import 'package:washouse_customer/resource/models/shipping.dart';
import 'package:washouse_customer/screens/order/cancel_detail_screen.dart';
import 'package:washouse_customer/utils/order_util.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/controller/tracking_controller.dart';
import '../../utils/price_util.dart';
import 'component/details_widget/detail_service.dart';
import 'generate_qr_screen.dart';
import 'search_order_screen.dart';
import 'tracking_order_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;
  final bool isPayment;
  final String status;
  const OrderDetailScreen({
    Key? key,
    required this.orderId,
    required this.isPayment,
    required this.status,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late OrderController orderController;
  TrackingController trackingController = TrackingController();
  Order_Infomation order_infomation = Order_Infomation();
  late int _processIndex;
  String? sendOrderDate;
  String sendOrderTime = 'Chọn giờ';

  Color getColor(int index) {
    if (index == _processIndex) {
      return kPrimaryColor;
    } else if (index < _processIndex) {
      return kPrimaryColor;
    } else {
      return Colors.grey.shade400;
    }
  }

  @override
  void initState() {
    super.initState();
    orderController = OrderController(context);
    print('status ${widget.status}');
    if (widget.status.trim().toLowerCase() == 'pending') {
      _processIndex = 0;
    } else if (widget.status.trim().toLowerCase() == 'confirmed') {
      _processIndex = 1;
    } else if (widget.status.trim().toLowerCase() == 'received') {
      _processIndex = 2;
    } else if (widget.status.trim().toLowerCase() == 'processing') {
      _processIndex = 3;
    } else if (widget.status.trim().toLowerCase() == 'ready') {
      _processIndex = 4;
    } else if (widget.status.trim().toLowerCase() == 'completed') {
      _processIndex = 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isPayment);
    String CancelledReason = '';
    TextEditingController _textEditingController = TextEditingController();
    bool isCancelledReasonEmpty = true;
    String status = '';
    Color statusColor = Colors.white;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
            size: 24,
          ),
        ),
        centerTitle: true,
        title: const Text('Chi tiết đơn hàng', style: TextStyle(color: textColor, fontSize: 27)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/generateQR', arguments: widget.orderId);
              },
              icon: const Icon(
                Icons.qr_code_2_rounded,
                color: textColor,
              ))
        ],
      ),
      body: FutureBuilder(
          future: orderController.getOrderInformation(widget.orderId),
          builder: (((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return basic.Center(
                child: LoadingAnimationWidget.threeRotatingDots(color: kPrimaryColor, size: 50),
              );
            } else if (snapshot.hasData) {
              Order_Infomation info = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                //'Đơn hàng: ${order_infomation.id}',
                                'Đơn hàng: ${info.id}',
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                              //DetailHeading(statusColor: statusColor, status: status)
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            info.orderTrackings != null ? 'Thời gian đặt hàng: ${info.orderTrackings!.first.createdDate}' : '',
                            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                    separateLine(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Theo dõi đơn hàng',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: TrackingOrderScreen(status: widget.status, order_infomation: info),
                                          type: PageTransitionType.rightToLeftWithFade));
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: double.infinity,
                          height: 90,
                          child: Timeline.tileBuilder(
                            theme: TimelineThemeData(
                              direction: Axis.horizontal,
                              connectorTheme: const ConnectorThemeData(
                                space: 30.0,
                                thickness: 5.0,
                              ),
                            ),
                            builder: TimelineTileBuilder.connected(
                              connectionDirection: ConnectionDirection.before,
                              itemExtentBuilder: (_, __) => MediaQuery.of(context).size.width / _processes.length,
                              contentsBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    _processes[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: getColor(index),
                                    ),
                                  ),
                                );
                              },
                              indicatorBuilder: (_, index) {
                                var color;
                                var child;
                                if (index == _processIndex) {
                                  color = kPrimaryColor;
                                  child = const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3.0,
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  );
                                } else if (index < _processIndex) {
                                  color = kPrimaryColor;
                                  child = const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15.0,
                                  );
                                } else {
                                  color = Colors.grey.shade400;
                                }
                                if (_processIndex == 5) {
                                  color = kPrimaryColor;
                                  child = const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15.0,
                                  );
                                }
                                if (index <= _processIndex) {
                                  return Stack(
                                    children: [
                                      CustomPaint(
                                        size: Size(30.0, 30.0),
                                        painter: _BezierPainter(
                                          color: color,
                                          drawStart: index > 0,
                                          drawEnd: index < _processIndex,
                                        ),
                                      ),
                                      DotIndicator(
                                        size: 30.0,
                                        color: color,
                                        child: child,
                                      ),
                                    ],
                                  );
                                } else {
                                  return Stack(
                                    children: [
                                      CustomPaint(
                                        size: Size(15.0, 15.0),
                                        painter: _BezierPainter(
                                          color: color,
                                          drawEnd: index < _processes.length - 1,
                                        ),
                                      ),
                                      OutlinedDotIndicator(
                                        borderWidth: 4.0,
                                        color: color,
                                      ),
                                    ],
                                  );
                                }
                              },
                              connectorBuilder: (_, index, type) {
                                if (index > 0) {
                                  if (index == _processIndex) {
                                    final prevColor = getColor(index - 1);
                                    final color = getColor(index);
                                    List<Color> gradientColors;
                                    if (type == ConnectorType.start) {
                                      gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
                                    } else {
                                      gradientColors = [prevColor, Color.lerp(prevColor, color, 0.5)!];
                                    }
                                    return DecoratedLineConnector(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: gradientColors,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return SolidLineConnector(
                                      color: getColor(index),
                                    );
                                  }
                                } else {
                                  return null;
                                }
                              },
                              itemCount: _processes.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                    separateLine(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Thông tin khách hàng',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            info.customerName!,
                            // order_infomation.customerName!,
                            style: const TextStyle(fontSize: 16, color: textColor),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            info.customerMobile!,
                            // order_infomation.customerMobile!,
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            info.customerAddress!,
                            // order_infomation.customerAddress!,
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ),
                    separateLine(),
                    DetailService(
                      order_information: info,
                      // order_information: order_infomation,
                    ),
                    separateLine(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Phương thức vận chuyển',
                            style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 35,
                                  child: Image.asset('assets/images/shipping/ship-di.png'),
                                ),
                                const SizedBox(width: 8),
                                (info.deliveryType == 0)
                                    ? const Text(
                                        'Không sử dụng dịch vụ vận chuyển',
                                        style: TextStyle(fontSize: 16),
                                      )
                                    : const SizedBox(height: 0),
                                (info.deliveryType == 1)
                                    ? const Text(
                                        'Vận chuyển từ khách hàng đến trung tâm',
                                        style: TextStyle(fontSize: 16),
                                      )
                                    : const SizedBox(height: 0),
                                (info.deliveryType == 2)
                                    ? const Text(
                                        'Vận chuyển từ trung tâm đến khách hàng',
                                        style: TextStyle(fontSize: 16),
                                      )
                                    : const SizedBox(height: 0),
                                (info.deliveryType == 3)
                                    ? const Text(
                                        'Vận chuyển hai chiều',
                                        style: TextStyle(fontSize: 16),
                                      )
                                    : const SizedBox(height: 0),
                              ],
                            ),
                          ),
                          (info.deliveryType != 0)
                              ? basic.Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    const Text(
                                      'Thông tin giao hàng',
                                      style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 8),
                                    (info.deliveryType == 1 || info.deliveryType == 3)
                                        ? basic.Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Lấy đơn hàng',
                                                style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
                                              ),
                                              const SizedBox(height: 8),
                                              Column(
                                                children: [
                                                  DeliveryTextBox(
                                                      from: 'Nhân viên',
                                                      to: (info.orderDeliveries!.first.shipperName == null)
                                                          ? 'Chưa xác định'
                                                          : '${info.orderDeliveries!.first.shipperName}'),
                                                  DeliveryTextBox(
                                                      from: 'SĐT nhân viên',
                                                      to: (info.orderDeliveries!.first.shipperPhone == null)
                                                          ? 'Chưa xác định'
                                                          : '${info.orderDeliveries!.first.shipperPhone}'),
                                                  DeliveryTextBox(
                                                      from: 'Ngày vận chuyển',
                                                      to: (info.orderDeliveries!.first.deliveryDate == null)
                                                          ? 'Chưa xác định'
                                                          : '${info.orderDeliveries!.first.deliveryDate}'),
                                                  DeliveryTextBox(from: 'Địa chỉ', to: '${info.orderDeliveries!.first.addressString}'),
                                                  DeliveryTextBox(from: 'Ước tính', to: '${info.orderDeliveries!.first.estimatedTime} phút'),
                                                  DeliveryTextBox(
                                                      from: 'Giờ khách hẹn giao hàng',
                                                      to: (info.preferredDropoffTime == null) ? 'Chưa xác định' : '${info.preferredDropoffTime}'),
                                                ],
                                              ),
                                            ],
                                          )
                                        : const SizedBox(height: 0),
                                    (info.deliveryType == 2 || info.deliveryType == 3)
                                        ? basic.Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              basic.Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Trả đơn hàng',
                                                    style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
                                                  ),
                                                  (info.status!.trim().toLowerCase() == 'ready')
                                                      ? TextButton(
                                                          onPressed: () async {
                                                            showDialog(
                                                                context: context,
                                                                builder: (builder) => AlertDialog(
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(15),
                                                                      ),
                                                                      title: const Align(
                                                                        alignment: Alignment.center,
                                                                        child: Text('Chọn giờ hẹn'),
                                                                      ),
                                                                      actions: [
                                                                        ElevatedButton(
                                                                          onPressed: () {},
                                                                          style: ElevatedButton.styleFrom(
                                                                              padding:
                                                                                  const EdgeInsetsDirectional.symmetric(horizontal: 19, vertical: 10),
                                                                              foregroundColor: kPrimaryColor.withOpacity(.7),
                                                                              elevation: 0,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(20),
                                                                                side: BorderSide(color: kPrimaryColor.withOpacity(.5), width: 1),
                                                                              ),
                                                                              backgroundColor: kPrimaryColor),
                                                                          child: const Text(
                                                                            'Lưu',
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                      content: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          SizedBox(
                                                                            width: 110,
                                                                            height: 40,
                                                                            child: DropdownButtonFormField(
                                                                              decoration: InputDecoration(
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: const BorderSide(color: textColor, width: 1),
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                                contentPadding:
                                                                                    const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: const BorderSide(color: textColor, width: 1),
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                              ),
                                                                              isDense: true,
                                                                              isExpanded: true,
                                                                              items: <String>['Hôm nay', 'Ngày mai'].map((String item) {
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
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  sendOrderDate = value;
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                          const SizedBox(width: 5),
                                                                          SizedBox(
                                                                            width: 120,
                                                                            height: 40,
                                                                            child: ElevatedButton(
                                                                              onPressed: () async {
                                                                                TimeOfDay? orderTime = await showTimePicker(
                                                                                    context: context, initialTime: TimeOfDay.now());
                                                                              },
                                                                              style: ElevatedButton.styleFrom(
                                                                                padding: const EdgeInsetsDirectional.symmetric(
                                                                                    horizontal: 19, vertical: 10),
                                                                                foregroundColor: kPrimaryColor.withOpacity(.7),
                                                                                elevation: 0,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  side: const BorderSide(color: textColor, width: 1),
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
                                                                      ),
                                                                    ));
                                                          },
                                                          child: const Text(
                                                            'Chọn giờ hẹn',
                                                            style: TextStyle(
                                                              color: kPrimaryColor,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 0,
                                                        ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Column(
                                                // children: [
                                                //   DeliveryTextBox(from: 'Nhân viên', to: 'tên nhân viên'),
                                                //   DeliveryTextBox(from: 'SĐT nhân viên', to: 'số điện thoại'),
                                                //   DeliveryTextBox(from: 'Ngày vận chuyển', to: 'ngày'),
                                                //   DeliveryTextBox(from: 'Địa chỉ', to: 'aiwhrpianwpfknf;nahweoihw;ena;uộtpetwre'),
                                                //   DeliveryTextBox(from: 'Ước tính', to: 'số phút'),
                                                //   DeliveryTextBox(from: 'Giờ khách hẹn trả hàng', to: 'Giờ phút'),
                                                // ],
                                                children: [
                                                  DeliveryTextBox(
                                                      from: 'Nhân viên',
                                                      to: (info.orderDeliveries!.last.shipperName == null)
                                                          ? 'Chưa xác định'
                                                          : '${info.orderDeliveries!.last.shipperName}'),
                                                  DeliveryTextBox(
                                                      from: 'SĐT nhân viên',
                                                      to: (info.orderDeliveries!.last.shipperPhone == null)
                                                          ? 'Chưa xác định'
                                                          : '${info.orderDeliveries!.last.shipperPhone}'),
                                                  DeliveryTextBox(
                                                      from: 'Ngày vận chuyển',
                                                      to: (info.orderDeliveries!.last.deliveryDate == null)
                                                          ? 'Chưa xác định'
                                                          : '${info.orderDeliveries!.last.deliveryDate}'),
                                                  DeliveryTextBox(from: 'Địa chỉ', to: '${info.orderDeliveries!.last.addressString}'),
                                                  DeliveryTextBox(from: 'Ước tính', to: '${info.orderDeliveries!.last.estimatedTime} phút'),
                                                  DeliveryTextBox(
                                                      from: 'Giờ khách hẹn trả hàng',
                                                      to: (info.preferredDeliverTime == null) ? 'Chưa xác định' : '${info.preferredDeliverTime}'),
                                                ],
                                              ),
                                            ],
                                          )
                                        : const SizedBox(height: 0),
                                  ],
                                )
                              : const SizedBox(height: 0),
                        ],
                      ),
                    ),
                    separateLine(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Phương thức thanh toán',
                            style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 35,
                                  child: Image.asset('assets/images/shipping/cash-on-delivery.png'),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  OrderUtils.getTextOfPaymentMethod(info.orderPayment!.paymentMethod!),
                                  // OrderUtils.getTextOfPaymentMethod(order_infomation.orderPayment!.paymentMethod!),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    separateLine(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Chi tiết thanh toán',
                            style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Tổng đơn hàng:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '${PriceUtils().convertFormatPrice((info.totalOrderValue!).round())} đ',
                                      // '${PriceUtils().convertFormatPrice((order_infomation.totalOrderValue!).round())} đ',
                                      style: TextStyle(fontSize: 16, color: kPrimaryColor, fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Phí vận chuyển:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      (info.deliveryPrice == null) ? '0 đ' : '${PriceUtils().convertFormatPrice((info.deliveryPrice!).round())} đ',
                                      // '${PriceUtils().convertFormatPrice((order_infomation.deliveryPrice!).round())} đ',
                                      style: TextStyle(fontSize: 16, color: kPrimaryColor, fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Chiếu khấu:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      info.orderPayment!.discount != null
                                          // order_infomation.orderPayment!.discount != null
                                          ? '- ${PriceUtils().convertFormatPrice((info.totalOrderValue! * (info.orderPayment!.discount!)).round())} đ'
                                          // ? '- ${PriceUtils().convertFormatPrice((order_infomation.totalOrderValue! * (order_infomation.orderPayment!.discount!)).round())} đ'
                                          : '0 đ',
                                      style: TextStyle(fontSize: 16, color: kPrimaryColor, fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Divider(
                                  height: 40,
                                  color: Colors.grey.shade300,
                                  thickness: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Tổng thanh toán:',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      '${PriceUtils().convertFormatPrice((info.orderPayment!.paymentTotal!).round())} đ',
                                      // '${PriceUtils().convertFormatPrice((order_infomation.orderPayment!.paymentTotal!).round())} đ',
                                      style: TextStyle(fontSize: 17, color: kPrimaryColor, fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  Text('Oops'),
                  Text('Có lỗi xảy ra rồi!'),
                ],
              );
            }
            return Container();
          }))),
      bottomNavigationBar: (widget.status.trim().toLowerCase() == 'pending' || widget.status.trim().toLowerCase() == 'confirmed')
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: cancelledColor),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Thông báo'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  'Bạn có chắn chắn muốn hủy đơn hàng ${widget.orderId}? Vui lòng đợi trong giây lát để cửa hàng xác nhận đơn hàng của bạn nhé!'),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Lý do hủy'),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                maxLines: 6,
                                maxLength: 500,
                                controller: _textEditingController,
                                decoration: InputDecoration(
                                  hintText: 'Nhập lý do hủy',
                                  contentPadding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    CancelledReason = value;
                                    isCancelledReasonEmpty = false;
                                  });
                                },
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: cancelledColor),
                              onPressed: () async {
                                String result = await trackingController.cancelledOrder(widget.orderId, CancelledReason);
                                if (result.compareTo("success") == 0) {
                                  Navigator.of(context).pop();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Thông báo'),
                                        content: Text('Đơn hàng đã được hủy thành công!'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child: CancelDetailScreen(orderId: widget.orderId),
                                                      type: PageTransitionType.rightToLeftWithFade));
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  Navigator.of(context).pop();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Thông báo'),
                                        content:
                                            Text('Có lỗi xảy ra trong quá trình xử lý hoặc đơn hàng của bạn không thể hủy! Bạn vui lòng thử lại sau'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Text('Xác nhận hủy'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: kPrimaryColor),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Giữ lại'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Hủy dịch vụ',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            )
          : (widget.status.trim().toLowerCase() == 'ready')
              ? Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
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
                    child: (widget.isPayment == true)
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), backgroundColor: kPrimaryColor),
                            onPressed: null,
                            child: const Text(
                              'Đã thanh toán',
                              style: TextStyle(fontSize: 17),
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), backgroundColor: kPrimaryColor),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Thông báo'),
                                    content: Text('Bạn có chắn chắn muốn thanh toán đơn hàng ${widget.orderId} qua ví?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Hủy bỏ'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          String result = await orderController.paymentOrder(widget.orderId);
                                          if (result.compareTo("success") == 0) {
                                            Navigator.of(context).pop();
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Thông báo'),
                                                  content: Text('Đơn hàng của bạn đã được thanh toán thành công!'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                        Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                child: OrderDetailScreen(
                                                                  orderId: widget.orderId,
                                                                  isPayment: true,
                                                                  status: 'ready',
                                                                ),
                                                                type: PageTransitionType.rightToLeftWithFade));
                                                      },
                                                      child: Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else {
                                            Navigator.of(context).pop();
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Thông báo'),
                                                  content: Text('Có lỗi xảy ra trong quá trình xử lý thanh toán! Bạn vui lòng thử lại sau. $result'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: Text('Xác nhận thanh toán'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text(
                              'Thanh toán',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                  ),
                )
              : SizedBox(width: 0, height: 0),
    );
  }

  Column separateLine() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Divider(thickness: 5, color: Colors.grey.shade200),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius, radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.drawStart != drawStart || oldDelegate.drawEnd != drawEnd;
  }
}

final _processes = [
  'Đang chờ',
  'Xác nhận',
  'Đã nhận',
  'Xử lý',
  'Sẵn sàng',
  'Hoàn tất',
];

class DeliveryTextBox extends StatelessWidget {
  final String from;
  final String to;
  const DeliveryTextBox({
    super.key,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            from,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
          ),
          SizedBox(
            width: 340 / 2,
            child: Text(
              to,
              style: const TextStyle(fontSize: 15),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
