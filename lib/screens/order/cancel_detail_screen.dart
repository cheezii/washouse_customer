import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/controller/order_controller.dart';
import '../../resource/models/response_models/order_detail_information.dart';
import 'component/details_widget/detail_service.dart';
import 'search_order_screen.dart';

class CancelDetailScreen extends StatefulWidget {
  final orderId;
  const CancelDetailScreen({super.key, this.orderId});

  @override
  State<CancelDetailScreen> createState() => _CancelDetailScreenState();
}

class _CancelDetailScreenState extends State<CancelDetailScreen> {
  late OrderController orderController;
  Order_Infomation order_infomation = Order_Infomation();
  bool isLoading = false;
  bool _isDisposed = false;
  @override
  void initState() {
    super.initState();
    orderController = OrderController(context);
    // centerArgs = widget.orderId;
    getOrderDetailInformation();
  }

  void getOrderDetailInformation() async {
    // Show loading indicator
    setState(() {
      isLoading = true;
    });

    // try {
    //   // Wait for getOrderInformation to complete
    //   Order_Infomation result = await orderController.getOrderInformation(widget.orderId);
    //   //await Future.delayed(Duration(seconds: 5));
    //   //print('result.toJson()${result.toJson()}');
    //   if (!_isDisposed) {
    //     setState(() {
    //       // Update state with loaded data
    //       order_infomation = result;
    //       isLoading = false;
    //     });
    //   }
    // } catch (e) {
    //   // Handle error
    //   setState(() {
    //     isLoading = false;
    //   });
    //   print('Error loading data: $e');
    // }

    try {
      // Wait for getOrderInformation to complete
      Order_Infomation result = await orderController.getOrderInformation(widget.orderId);
      setState(() {
        // Update state with loaded data
        order_infomation = result;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
      print('Error loading data: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    } else {
      String cancelledBy = "";
      String cancelledReason = "";
      if (order_infomation.cancelReasonByCustomer != null) {
        cancelledBy = "bạn";
        cancelledReason = order_infomation.cancelReasonByCustomer!;
      } else if (order_infomation.cancelReasonByStaff != null) {
        cancelledBy = "Trung tâm";
        cancelledReason = order_infomation.cancelReasonByStaff!;
      }
      String truncatedText = cancelledReason;
      if (cancelledReason.length > 500) {
        // Truncate text if it exceeds maxChars
        truncatedText = cancelledReason.substring(0, 500);
      }
      String paymentMethodString = "";
      if (order_infomation.orderPayment!.paymentMethod == 0) {
        paymentMethodString = "Thanh toán khi nhận hàng";
      } else if (order_infomation.orderPayment!.paymentMethod == 1) {
        paymentMethodString = "Thanh toán bằng ví Washouse";
      }
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
          title: const Align(
            alignment: Alignment.center,
            child: Text('Chi tiết đơn hủy', style: TextStyle(color: textColor, fontSize: 27)),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, PageTransition(child: const SearchOrderScreen(), type: PageTransitionType.fade));
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.search_rounded,
                  color: kBackgroundColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Đã hủy đơn hàng',
                        style: TextStyle(
                          color: cancelColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        (order_infomation.orderTrackings != null)
                            ? '${order_infomation.orderTrackings!.firstWhere((element) => (element.status!.trim().toLowerCase().compareTo("cancelled") == 0)).createdDate}'
                            : '',
                        style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.check_circle_outline_sharp,
                    color: cancelColor,
                    size: 35,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Divider(thickness: 8, color: Colors.grey.shade200),
            const SizedBox(height: 10),
            DetailService(
              order_information: order_infomation,
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                CancelDetailFooter(from: 'Yêu cầu bởi', to: '$cancelledBy'),
                CancelDetailFooter(
                  from: 'Yêu cầu vào',
                  to: (order_infomation.orderTrackings != null)
                      ? '${order_infomation.orderTrackings!.firstWhere((element) => (element.status!.trim().toLowerCase().compareTo("cancelled") == 0)).createdDate}'
                      : '',
                ),
                //CancelDetailFooter(from: 'Lý do', to: '${order_infomation.cancelReasonByStaff}'), //làm sao để ô này hiển thị lớn hơn
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lý do',
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                      ),
                      Container(
                        alignment: Alignment.topRight, // Align container to top right
                        width: 300,
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //     color: Colors.grey.shade500, // Set border color
                        //     width: 1.0, // Set border width
                        //   ),
                        // ),
                        padding: EdgeInsets.all(0.0), // Add padding inside container
                        child: Flexible(
                          fit: FlexFit.loose, // Allow text to break to new line
                          child: Text(
                            truncatedText,
                            maxLines: 20,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right, // Align text to the right
                            style: TextStyle(fontSize: 15.0), // Set desired font size
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                CancelDetailFooter(from: 'Phương thức thanh toán', to: paymentMethodString),
              ],
            ),
          ],
        ),
      );
    }
  }
}

class CancelDetailFooter extends StatelessWidget {
  final String from;
  final String to;
  const CancelDetailFooter({
    super.key,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            from,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
          ),
          Text(to, style: const TextStyle(fontSize: 15))
        ],
      ),
    );
  }
}
