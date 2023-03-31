import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/screens/center/component/details/category_menu.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../utils/price_util.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final arguments = ModalRoute.of(context)!.settings.arguments as ServiceDemo;
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
                arguments.image,
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
                      arguments.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 26),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.2,
                    child: Text(
                      '${PriceUtils().convertFormatPrice(arguments.price)} đ',
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
                    arguments.description,
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
                      Container(
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
                                SizedBox(width: 4.0),
                                Icon(Icons.star, color: kPrimaryColor),
                                SizedBox(width: 8.0),
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
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
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
                    children: [
                      Container(
                        height: 50,
                        width: size.width / 6,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Số ký',
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          cursorHeight: 17,
                          style: TextStyle(
                            height: 1,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'kg',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  )
                : Row(
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
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '1',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 15),
                      ),
                    ],
                  ),
            const Spacer(),
            SizedBox(
              width: 230,
              height: 40,
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
    );
  }
}
