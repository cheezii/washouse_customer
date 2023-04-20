import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';
import 'package:washouse_customer/screens/order/component/tabview/all_order_screen.dart';
import 'package:washouse_customer/screens/order/component/tabview/confirmed_screen.dart';
import 'package:washouse_customer/screens/order/component/tabview/received_screen.dart';

import 'component/tabview/pending_screen.dart';
import 'component/tabview/processing_screen.dart';
import 'component/tabview/ready_screen.dart';
import 'order_history_screen.dart';
import 'search_order_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Color filterColor = textColor;
  String? filterOrder;
  //late OrderController orderController;
  //List<Order_Item> orderItems = [];
  //bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //orderController = OrderController(context);
    // centerArgs = widget.orderId;
    //getOrderItems();
  }

  // void getOrderItems() async {
  //   // Show loading indicator
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     // Wait for getOrderInformation to complete
  //     List<Order_Item> result = await orderController.getOrderList(1, 100, null, null, null, "pending", null);
  //     setState(() {
  //       // Update state with loaded data
  //       orderItems = result;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     // Handle error
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print('Error loading data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //var orderListPending = orderItems.where((element) => element.status!.toLowerCase().compareTo('pending') == 0).toList();
    //var orderListConfirmed = orderItems.where((element) => element.status!.toLowerCase().compareTo('confirmed') == 0).toList();
    //var orderListProcessing = orderItems.where((element) => element.status!.toLowerCase().compareTo('processing') == 0).toList();
    //print('processing-${orderListProcessing.length}');
    //var orderListReady = orderItems.where((element) => element.status!.toLowerCase().compareTo('ready') == 0).toList();
    return DefaultTabController(
      initialIndex: 0,
      length: 6,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text('Đơn hàng',
                style: TextStyle(
                    color: textColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            actions: [
              IconButton(
                  onPressed: () {
                    showFilterModelBottomSheet(context);
                  },
                  icon: Icon(Icons.filter_alt_outlined, color: filterColor)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const SearchOrderScreen(),
                          type: PageTransitionType.fade));
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.search_rounded,
                    color: textColor,
                    size: 27,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const OrderHistoryScreen(),
                          type: PageTransitionType.rightToLeftWithFade));
                },
                child: const Text(
                  'Lịch sử',
                  style: TextStyle(fontSize: 18, color: kPrimaryColor),
                ),
              )
            ],
            bottom: const TabBar(
              unselectedLabelColor: textColor,
              labelColor: textColor,
              isScrollable: true,
              tabs: [
                Tab(text: 'Tất cả'),
                Tab(text: pending),
                Tab(text: confirmed),
                Tab(text: received),
                Tab(text: processing),
                Tab(text: ready),
              ],
            ),
          ),
          body: const TabBarView(children: [
            AllOrderScreen(),
            OrderPendingScreen(),
            OrderConfirmedScreen(),
            OrderReceivedScreen(),
            OrderProcessingScreen(),
            OrderReadyScreen(),
          ])),
    );
  }

  Future<dynamic> showFilterModelBottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: ((context) => Container(
            height: 380,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: StatefulBuilder(
              builder: (context, setState) => Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      const SizedBox(width: 90),
                      const Text(
                        'Lọc theo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.grey.shade300),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const Text('Tất cả'),
                    trailing: Radio<String>(
                      value: 'Tất cả',
                      groupValue: filterOrder,
                      onChanged: (value) {
                        Navigator.pop(context);
                        setState(() {
                          filterOrder = value;
                        });
                        this.setState(() {
                          filterColor = kPrimaryColor;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Đặt bởi tôi'),
                    trailing: Radio<String>(
                      value: 'Đặt bởi tôi',
                      groupValue: filterOrder,
                      onChanged: (value) {
                        Navigator.pop(context);
                        setState(() {
                          filterOrder = value;
                        });
                        this.setState(() {
                          filterColor = kPrimaryColor;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Đặt hộ tôi'),
                    trailing: Radio<String>(
                      value: 'Đặt hộ tôi',
                      groupValue: filterOrder,
                      onChanged: (value) {
                        Navigator.pop(context);
                        setState(() {
                          filterOrder = value;
                        });
                        this.setState(() {
                          filterColor = kPrimaryColor;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: size.width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          filterOrder = null;
                          Navigator.pop(context);
                        });
                        this.setState(() {
                          filterColor = textColor;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          backgroundColor: kPrimaryColor),
                      child:
                          const Text('Làm mới', style: TextStyle(fontSize: 17)),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
