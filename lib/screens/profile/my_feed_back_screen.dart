import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:washouse_customer/resource/controller/account_controller.dart';
import 'package:washouse_customer/screens/profile/feedback_order_screen.dart';
import 'package:washouse_customer/screens/profile/feedback_service_screen.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/models/feedback.dart';

class MyFeedbackScreen extends StatefulWidget {
  const MyFeedbackScreen({super.key});

  @override
  State<MyFeedbackScreen> createState() => _MyFeedbackScreenState();
}

class _MyFeedbackScreenState extends State<MyFeedbackScreen> {
  AccountController accountController = AccountController();
  List<FeedbackModel> _list = [];
  bool isLoading = false;
  void getMyFeedback() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<FeedbackModel>? list = await accountController.getMyFeedback();
      if (list != null) {
        setState(() {
          _list = list;
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
      print('Error loading feedbacks: $e');
    }
  }

  String _currentUserName = '';
  String? _currentUserAvartar;

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final name =
          await baseController.getStringtoSharedPreference("CURRENT_USER_NAME");
      final avatar = await baseController
          .getStringtoSharedPreference("CURRENT_USER_AVATAR");
      setState(() {
        _currentUserName = name != "" ? name : "Undentified Name";
        _currentUserAvartar = avatar != ""
            ? avatar
            : "https://storage.googleapis.com/washousebucket/anonymous-20230330210147.jpg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=washouse-sa%40washouse-381309.iam.gserviceaccount.com%2F20230330%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20230330T210148Z&X-Goog-Expires=1800&X-Goog-SignedHeaders=host&X-Goog-Signature=7c813f26489c9ba06cdfff27db9faa2ca4d7c046766aeb3874fdf86ec7c91ae904951f7b2617b6e78598d46f8b91d842d2f4c2a10696539bcf09c839d51d9565831f6c503b3e37f899ab8920f69c3aaa30e0ff2d9c598d1a4c523c1e8038520a32fe49a92c4448c49e602b77312444fe3505afa30da1c4bfbdf0f7a5ab9f2783005c1f3624b3417e17c0067f65f4c02fd03bbe9a0eed8390b56aa2b78a34ca88b52bbce7e1d364dc24e6650a68954e36439102f19a3b332fcb1562260d5223db1e09748eee5d7e6b0cba62dc7cfda9e1e00690f334b9e4b85c710ed77dee42759b48f98df0f05e1adf686351f6232a7d157c9f988248af0c69ec64af0cdbe247";
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
  void initState() {
    super.initState();
    getMyFeedback();
    _loadData();
  }

  bool isHaveFeedBack = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                width: 100,
                height: 100,
                child: LoadingAnimationWidget.threeRotatingDots(
                    color: kPrimaryColor, size: 50),
              ),
            ),
          )
        ],
      );
    } else {
      var _listOrder = _list;
      var _listService = _list;
      if (_list != null) {
        _listOrder = _list.where((element) => element.orderId != null).toList();
        _listService =
            _list.where((element) => element.serviceId != null).toList();
      }
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
            title: const Text('Đánh giá của tôi',
                style: TextStyle(color: textColor, fontSize: 25)),
            // bottom: const TabBar(
            //   unselectedLabelColor: textColor,
            //   labelColor: textColor,
            //   tabs: [Tab(text: 'Đơn hàng'), Tab(text: 'Dịch vụ')],
            // ),
          ),
          body: FeedbackToOrderScreen(
              list: _listOrder,
              name: _currentUserName,
              avatar: _currentUserAvartar!),
        ),
      );
    }
  }
}
