import 'package:flutter/material.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/models/promotion.dart';
import '../../../center/component/promotion/promotion_widget.dart';

class AddVoucherScreen extends StatefulWidget {
  const AddVoucherScreen({super.key});

  @override
  State<AddVoucherScreen> createState() => _AddVoucherScreenState();
}

class _AddVoucherScreenState extends State<AddVoucherScreen> {
  List<PromotionModel> displayList = demoPromotionList;

  void getSuggest(String value) {
    setState(() {
      displayList = demoPromotionList
          .where((element) =>
              element.code.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        centerTitle: true,
        title: const Text('Mã khuyến mãi',
            style: TextStyle(color: Colors.white, fontSize: 23)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 22),
            child: Icon(Icons.abc, color: kPrimaryColor),
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
          Expanded(
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: PromotionWidget(
                    description: displayList[index].description,
                    expiredDate: displayList[index].expiredDate,
                    code: displayList[index].code,
                    press: () {},
                  ),
                );
              }),
              itemCount: displayList.length,
            ),
          ),
        ],
      ),
    );
  }
}
