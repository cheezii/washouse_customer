import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:washouse_customer/resource/controller/promotion_controller.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/provider/cart_provider.dart';
import '../../../../resource/models/promotion.dart';
import '../../../center/component/promotion/promotion_widget.dart';
import '../../cart_screen.dart';

class AddVoucherScreen extends StatefulWidget {
  const AddVoucherScreen({super.key});

  @override
  State<AddVoucherScreen> createState() => _AddVoucherScreenState();
}

class _AddVoucherScreenState extends State<AddVoucherScreen> {
  List<PromotionModel> displayList = [];
  PromotionController promotionController = PromotionController();
  void getSuggest(String value) {
    setState(() {
      displayList = displayList.where((element) => element.code.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    promotionList();
    super.initState();
  }

  void promotionList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int centerId = prefs.getInt('centerId');
    var promotions = await promotionController.getPromotionListOfCenter(centerId);
    if (promotions.isNotEmpty) {
      setState(() {
        displayList = promotions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor, //Theme.of(context).scaffoldBackgroundColor
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text('Mã khuyến mãi', style: TextStyle(color: Colors.white, fontSize: 23)),
        actions: [
          IconButton(
            onPressed: () {
              PromotionModel nonPromotion = PromotionModel(code: '', discount: 0, startDate: '', expireDate: '', isAvailable: false);
              provider.updatePromotion(nonPromotion);
              Navigator.push(context, PageTransition(child: const CartScreen(), type: PageTransitionType.rightToLeftWithFade));
            },
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: TextField(
              onChanged: (value) => getSuggest(value),
              decoration: InputDecoration(
                hintText: 'Tìm kiếm',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey.shade500,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
            ),
          ),
          Consumer<CartProvider>(builder: (context, value, child) {
            return Expanded(
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: PromotionWidget(
                      description: displayList[index].description!,
                      expiredDate: displayList[index].expireDate,
                      code: displayList[index].code,
                      press: () async {
                        provider.updatePromotion(displayList[index]);
                        Navigator.push(context, PageTransition(child: const CartScreen(), type: PageTransitionType.rightToLeftWithFade));
                      },
                    ),
                  );
                }),
                itemCount: displayList.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}
