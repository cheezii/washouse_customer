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

class _OrderHistoryScreenState extends State<OrderHistoryScreen> with TickerProviderStateMixin {
  Color filterColor = textColor;
  late String filterOrder;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    filterOrder = 'Tất cả';
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

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
              size: 24,
            ),
          ),
          centerTitle: true,
          title: const Text('Lịch sử giao dịch', style: TextStyle(color: textColor, fontSize: 27)),
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
                Navigator.push(context, PageTransition(child: const SearchOrderScreen(), type: PageTransitionType.fade));
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
          bottom: TabBar(
            controller: _tabController,
            unselectedLabelColor: textColor,
            labelColor: textColor,
            tabs: [Tab(text: 'Đã hoàn thành'), Tab(text: 'Đã hủy')],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            OrderCompleteScreen(filter: filterOrder),
            OrderCancelScreen(filter: filterOrder),
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
                        setState(() {
                          print(value);
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
                        setState(() {
                          print(value);
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
                          print("Làm mới");
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
