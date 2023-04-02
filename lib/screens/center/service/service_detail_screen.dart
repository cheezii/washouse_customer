// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/resource/models/service.dart';
import 'package:washouse_customer/screens/center/component/details/category_menu.dart';

import '../../../resource/controller/center_controller.dart';
import '../../../resource/controller/service_controller.dart';
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
  Service serviceArgs = Service();
  ServiceController serviceController = ServiceController();
  CenterController centerController = CenterController();

  Service serviceDetails = Service();

  DateTime now = DateTime.now();

  bool isLoadingDetail = true;

  @override
  void initState() {
    super.initState();
    serviceArgs = widget.serviceData;
  }

  void getServiceDetail() async {
    Service service = widget.serviceData;
    serviceController.getServiceById(service.serviceId!.toInt()).then(
      (result) {
        setState(() {
          serviceDetails = result;
          isLoadingDetail = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<double> ratings = [0.5, 0.3, 0.5, 0.7, 0.9];
    bool checkUnitType = false;
    bool checkRatingNull = false;
    bool checkPriceType = false;
    int PriceMin = 0;
    int PriceMax = 0;
    double? _selectedValue;

    List<double> _values = [];

    if (serviceArgs.rating == null) {
      checkRatingNull = true;
      print(checkRatingNull);
    }
    if (serviceArgs.priceType!) {
      checkPriceType = true;
      for (var i = 1; i < (serviceArgs.prices!.last.maxValue! * 10 + 1); i++) {
        _values.add(i / 10);
      }
    }
    if (serviceArgs.unit != null && serviceArgs.unit == "Kg") {
      checkUnitType = true;
    }
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
              background: Image.network(
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
                      serviceArgs.serviceName!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 24),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.25,
                    child: Text(
                      checkPriceType
                          ? '${PriceUtils().convertFormatPrice(serviceArgs.prices!.last.price!.toInt())} đ - ${PriceUtils().convertFormatPrice(serviceArgs.prices!.first.price!.toInt())} đ'
                          : '${PriceUtils().convertFormatPrice(serviceArgs.price!.toInt())} đ',
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
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Thời gian dự tính:   ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        TextSpan(
                            text:
                                serviceArgs.timeEstimate!.toString() + " phút",
                            style: TextStyle(fontSize: 17)),
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
                  !checkRatingNull
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: serviceArgs.rating!.toString(),
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
                                  rating: serviceArgs.rating!.toDouble(),
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kPrimaryColor,
                                  ),
                                  itemCount: 5,
                                  itemSize: 30,
                                  direction: Axis.horizontal,
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  '${serviceArgs.numOfRating} đánh giá',
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
                                      const Icon(Icons.star,
                                          color: kPrimaryColor),
                                      const SizedBox(width: 8.0),
                                      LinearPercentIndicator(
                                        lineHeight: 6.0,
                                        // linearStrokeCap: LinearStrokeCap.roundAll,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.8,
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
                        )
                      : const Text(
                          'Chưa có đánh giá',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w700,
                          ),
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
                checkUnitType
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 90,
                            width: size.width / 6,
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 50,
                                // child: TextField(
                                //   textAlign: TextAlign.center,
                                //   keyboardType: TextInputType.numberWithOptions(
                                //       decimal: true),
                                //   decoration: InputDecoration(
                                //     enabledBorder: OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //           color: Colors.black, width: 1),
                                //       borderRadius:
                                //           BorderRadius.all(Radius.circular(10)),
                                //     ),
                                //     contentPadding: EdgeInsets.all(0),
                                //     hintText: 'Số ký',
                                //     hintStyle: TextStyle(
                                //       fontSize: 18,
                                //       height: 1.4,
                                //     ),
                                //   ),
                                //   cursorHeight: 17,
                                //   inputFormatters: [
                                //     FilteringTextInputFormatter.allow(
                                //         RegExp(r'^\d+\.?\d{0,3}')),
                                //   ],
                                //   style: TextStyle(
                                //     height: 1,
                                //     fontSize: 18,
                                //   ),
                                // ),
                                child: DropdownButtonFormField<double>(
                                  value: _selectedValue,
                                  // decoration: InputDecoration(
                                  //   labelText: 'Select',
                                  //   border: OutlineInputBorder(),
                                  // ),
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
                                  items: _values.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValue = value;
                                    });
                                  },
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
                  width: 200,
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
