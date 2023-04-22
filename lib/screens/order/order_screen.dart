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

class _OrderScreenState extends State<OrderScreen> with TickerProviderStateMixin {
  Color filterColor = textColor;
  late String filterOrder;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    filterOrder = 'Tất cả';
    _tabController = TabController(initialIndex: 0, length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 6,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text('Đơn hàng', style: TextStyle(color: textColor, fontSize: 30, fontWeight: FontWeight.bold)),
            actions: [
              IconButton(
                  onPressed: () {
                    showFilterModelBottomSheet(context);
                  },
                  icon: Icon(Icons.filter_alt_outlined, color: filterColor)),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, PageTransition(child: const SearchOrderScreen(), type: PageTransitionType.fade));
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
                  Navigator.push(context, PageTransition(child: const OrderHistoryScreen(), type: PageTransitionType.rightToLeftWithFade));
                },
                child: const Text(
                  'Lịch sử',
                  style: TextStyle(fontSize: 18, color: kPrimaryColor),
                ),
              )
            ],
            bottom: TabBar(
              unselectedLabelColor: textColor,
              controller: _tabController,
              labelColor: Colors.blue,
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
          body: TabBarView(controller: _tabController, children: [
            AllOrderScreen(filter: filterOrder),
            OrderPendingScreen(filter: filterOrder),
            OrderConfirmedScreen(filter: filterOrder),
            OrderReceivedScreen(filter: filterOrder),
            OrderProcessingScreen(filter: filterOrder),
            OrderReadyScreen(filter: filterOrder),
          ])),
    );
  }

  // Update the filterOrder value and call animateTo() on the TabController
  void updateFilterOrder(String value) {
    setState(() {
      filterOrder = value;
      print(filterOrder);
    });
    _tabController?.animateTo(_tabController!.index); // Reload current tab view
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
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                        updateFilterOrder(value!);
                        setState(() {
                          filterOrder = value!;
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
                        updateFilterOrder(value!);
                        setState(() {
                          filterOrder = value!;
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
                        updateFilterOrder(value!);
                        setState(() {
                          filterOrder = value!;
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
                          filterOrder = 'Tất cả';
                          Navigator.pop(context);
                        });
                        this.setState(() {
                          filterColor = textColor;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: kPrimaryColor),
                      child: const Text('Làm mới', style: TextStyle(fontSize: 17)),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
