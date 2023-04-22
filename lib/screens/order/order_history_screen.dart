import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/controller/order_controller.dart';
import '../../resource/models/response_models/order_item_list.dart';
import 'component/tabview/cancel_history_screen.dart';
import 'component/tabview/complete_history_screen.dart';
import 'search_order_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  Color filterColor = textColor;
  String? filterOrder;
  //late OrderController orderController;
  //List<Order_Item> orderCompletedItems = [];
  //List<Order_Item> orderCancelledItems = [];
  //bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //orderController = OrderController(context);
    // centerArgs = widget.orderId;
    //getorderHistoryItems();
  }

  // void getorderHistoryItems() async {
  //   // Show loading indicator
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     // Wait for getOrderInformation to complete
  //     List<Order_Item> completedResult = await orderController.getOrderList(1, 100, null, null, null, "completed", null);
  //     List<Order_Item> cancelledResult = await orderController.getOrderList(1, 100, null, null, null, "cancelled", null);

  //     setState(() {
  //       // Update state with loaded data
  //       orderCompletedItems = completedResult;
  //       orderCancelledItems = cancelledResult;
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
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
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
              size: 22,
            ),
          ),
          centerTitle: true,
          title: const Text('Lịch sử giao dịch',
              style: TextStyle(color: textColor, fontSize: 25)),
          actions: [
            IconButton(
                onPressed: () {
                  showFilterModelBottomSheet(context);
                },
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: filterColor,
                )),
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
                  size: 30,
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            unselectedLabelColor: textColor,
            labelColor: textColor,
            tabs: [Tab(text: 'Đã hoàn thành'), Tab(text: 'Đã hủy')],
          ),
        ),
        body: TabBarView(
          children: [
            OrderCompleteScreen(),
            OrderCancelScreen(),
          ],
        ),
      ),
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
