// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/screens/center/component/details/category_menu.dart';

import '../../../utils/price_util.dart';

class ServiceDetailScreen extends StatefulWidget {
  final serviceData;
  const ServiceDetailScreen({
    Key? key,
    this.serviceData,
  }) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  ServiceDemo serviceArgs = ServiceDemo();

  @override
  void initState() {
    super.initState();
    serviceArgs = widget.serviceData;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];
    bool checkPriceType = true;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            stretch: true,
            elevation: 0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                serviceArgs.image!,
                fit: BoxFit.cover,
              ),
            ),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.only(left: 16),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: Text(
                      serviceArgs.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 26),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.2,
                    child: Text(
                      '${PriceUtils().convertFormatPrice(serviceArgs.price!)} đ',
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              //height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông tin dịch vụ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Mô tả',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    serviceArgs.description!,
                    style: const TextStyle(fontSize: 17, color: textColor),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 15),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Thời gian dự tính:   ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        TextSpan(
                            text: '150 phút', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(thickness: 1.0, color: Colors.grey.shade300),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Đánh giá',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "4.6",
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: " / 5",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          RatingBarIndicator(
                            rating: 4.6,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: kPrimaryColor,
                            ),
                            itemCount: 5,
                            itemSize: 30,
                            direction: Axis.horizontal,
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            "13 đánh giá",
                            style: TextStyle(
                              fontSize: 18,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 200.0,
                        height: 120,
                        child: ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Text(
                                  '${index + 1}',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                const SizedBox(width: 4.0),
                                const Icon(Icons.star, color: kPrimaryColor),
                                const SizedBox(width: 8.0),
                                LinearPercentIndicator(
                                  lineHeight: 6.0,
                                  // linearStrokeCap: LinearStrokeCap.roundAll,
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  animation: true,
                                  animationDuration: 2500,
                                  percent: ratings[index],
                                  progressColor: kPrimaryColor,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SingleChildScrollView(
        reverse: true,
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -15),
                  blurRadius: 20,
                  color: const Color(0xffdadada).withOpacity(0.15),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                checkPriceType
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 90,
                            width: size.width / 6,
                            child: const Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    contentPadding: EdgeInsets.all(0),
                                    hintText: 'Số ký',
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      height: 1.4,
                                    ),
                                  ),
                                  cursorHeight: 17,
                                  style: TextStyle(
                                    height: 1,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'kg',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(Icons.remove,
                                color: Colors.white, size: 15),
                          ),
                          Container(
                            height: 90,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '1',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(Icons.add,
                                color: Colors.white, size: 15),
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                SizedBox(
                  width: 230,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: kPrimaryColor),
                    onPressed: () {},
                    child: const Text(
                      'Đặt dịch vụ',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom))
        ]),
      ),
    );
  }
}
