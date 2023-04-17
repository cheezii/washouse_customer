// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import 'package:washouse_customer/resource/models/service.dart';
import 'package:washouse_customer/screens/center/component/details/category_menu.dart';

import '../../../resource/controller/center_controller.dart';
import '../../../resource/controller/service_controller.dart';
import '../../../utils/formatter_util.dart';
import '../../../utils/price_util.dart';

import 'package:washouse_customer/resource/controller/cart_provider.dart';
import 'package:washouse_customer/resource/models/cart_item.dart';
import 'package:washouse_customer/resource/models/center.dart';

class ServiceDetailScreen extends StatefulWidget {
  final centerData;
  final serviceData;
  const ServiceDetailScreen({
    Key? key,
    this.serviceData,
    this.centerData,
  }) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  late List<Prices> priceList;
  Service serviceArgs = Service();
  ServiceController serviceController = ServiceController();
  CenterController centerController = CenterController();
  BaseController baseController = BaseController();

  Service serviceDetails = Service();

  DateTime now = DateTime.now();

  bool isLoadingDetail = true;

  TextEditingController quantityController = TextEditingController();
  TextEditingController kilogramController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  LaundryCenter centerArgs = LaundryCenter();
  late int quantity;
  late num kilogram;
  double currPrice = 0;

  //double? selectedDropdownValue;

  @override
  void initState() {
    getServiceDetail();
    quantity = 1;
    quantityController.text = quantity.toString();
    kilogram = 1.0;
    kilogramController.text = kilogram.toString();
    super.initState();
    centerArgs = widget.centerData;
    serviceArgs = widget.serviceData;
    priceList = serviceArgs.prices!;
    if (serviceArgs.unit != null && serviceArgs.unit == "Kg") {
      currPrice = serviceArgs.prices![0].price!.toDouble();
    }
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
    //print(centerArgs.id);
    var provider = Provider.of<CartProvider>(context);
    var cart = provider.cartItems;
    Size size = MediaQuery.of(context).size;
    List<double> ratings = [];
    CartItem cartItem;
    double? productPrice;
    bool checkUnitType = false;
    bool checkPriceChart = false;
    bool checkRatingNull = false;
    bool checkPriceType = false;
    int PriceMin = 0;
    int PriceMax = 0;

    bool checkAdded = false;
    double minPrice = serviceArgs.priceType! ? serviceArgs.minPrice!.toDouble() : 0;

    double _maxMeasurementValue = serviceArgs.priceType! ? serviceArgs.prices!.last.maxValue!.toDouble() : 0;
    //List<double> _values = [];

    if (serviceArgs.rating == null) {
      checkRatingNull = true;
    }

    if (serviceArgs.priceType!) {
      checkPriceType = true;
      // for (var i = 1; i <= (serviceArgs.prices!.last.maxValue! * 10); i++) {
      //   _values.add(i / 10);
      // }
    }

    if (serviceArgs.priceType != null && serviceArgs.priceType == true) {
      checkPriceChart = true;
    }

    if (serviceArgs.unit != null && serviceArgs.unit == "Kg") {
      checkUnitType = true;
      //currPrice = serviceArgs.prices![0].price!.toDouble();
      //displayPrice = currPrice * kilogram;
    }

    if (serviceArgs.ratings != null && serviceArgs.numOfRating != 0) {
      double star1 = serviceArgs.ratings![0] / serviceArgs.numOfRating!;
      double star2 = serviceArgs.ratings![1] / serviceArgs.numOfRating!;
      double star3 = serviceArgs.ratings![2] / serviceArgs.numOfRating!;
      double star4 = serviceArgs.ratings![3] / serviceArgs.numOfRating!;
      double star5 = serviceArgs.ratings![4] / serviceArgs.numOfRating!;
      ratings.addAll([star1, star2, star3, star4, star5]);
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
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 87,
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
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      Text('Đơn vị tính: ${serviceArgs.unit}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade800)),
                    ],
                  )
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
                  const SizedBox(height: 20),
                  checkPriceChart
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Giá dịch vụ tối thiểu : ${PriceUtils().convertFormatPrice(serviceArgs.minPrice!.toInt())} đ',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            const Text(
                              '*Nếu giá tiền của dịch vụ bạn đặt tính theo bảng giá dưới mức giá tối thiểu, giá tiền của dịch vụ sẽ là giá tối thiểu',
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.red, fontStyle: FontStyle.italic),
                            ),
                          ],
                        )
                      : const SizedBox(height: 0, width: 0),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Thời gian dự tính:   ',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        TextSpan(text: serviceArgs.timeEstimate!.toString() + " phút", style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  checkPriceChart
                      ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                'Bảng giá',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              SizedBox(
                                width: size.width,
                                child: DataTable(
                                  columns: const <DataColumn>[
                                    DataColumn(
                                      label: Text(
                                        'Tối đa',
                                        style: TextStyle(fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Giá thành',
                                        style: TextStyle(fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ],
                                  rows: priceList
                                      .map<DataRow>((e) => DataRow(cells: [
                                            DataCell(Text(e.maxValue.toString() + ' ${serviceArgs.unit}')),
                                            DataCell(Text('${PriceUtils().convertFormatPrice(e.price?.round() as num)} đ/${serviceArgs.unit}')),
                                          ]))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(height: 0, width: 0),
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
                                        style: const TextStyle(
                                          fontSize: 42,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const TextSpan(
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
                                  style: const TextStyle(
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
                                        width: MediaQuery.of(context).size.width / 2.8,
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
                      : Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: const [
                              Icon(Icons.star_rounded, color: kPrimaryColor, size: 60),
                              SizedBox(height: 10),
                              Text(
                                'Chưa có đánh giá nào',
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                              )
                            ],
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
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -15),
                  blurRadius: 20,
                  color: const Color(0xffdadada).withOpacity(0.15),
                ),
              ],
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.note_alt_outlined,
                      color: textColor.withOpacity(.5),
                    ),
                    hintText: 'Có ghi chú cho trung tâm?',
                  ),
                  controller: noteController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    checkUnitType
                        // ? Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       SizedBox(
                        //         height: 90,
                        //         width: size.width / 5,
                        //         child: Align(
                        //           alignment: Alignment.center,
                        //           child: SizedBox(
                        //             height: 50,
                        //             child: DropdownButtonFormField<double>(
                        //               value: _selectedValue,
                        //               //value: 3,
                        //               decoration: const InputDecoration(
                        //                 enabledBorder: OutlineInputBorder(
                        //                   borderSide: BorderSide(
                        //                       color: Colors.black, width: 1),
                        //                   borderRadius:
                        //                       BorderRadius.all(Radius.circular(10)),
                        //                 ),
                        //                 focusedBorder: OutlineInputBorder(
                        //                   borderSide: BorderSide(
                        //                       color: Colors.black, width: 1),
                        //                   borderRadius:
                        //                       BorderRadius.all(Radius.circular(10)),
                        //                 ),
                        //                 contentPadding: EdgeInsets.only(left: 10),
                        //                 hintText: 'Số ký',
                        //                 hintStyle: TextStyle(
                        //                   fontSize: 18,
                        //                   height: 1.4,
                        //                 ),
                        //               ),
                        //               items: _values.map((value) {
                        //                 return DropdownMenuItem(
                        //                   value: value,
                        //                   child: Text(value.toString()),
                        //                 );
                        //               }).toList(),
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   _selectedValue = value;
                        //                   selectedDropdownValue = value;
                        //                   //print(_selectedValue);
                        //                 });
                        //               },
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       const SizedBox(width: 15),
                        //       const Text(
                        //         'kg',
                        //         style: TextStyle(fontSize: 18),
                        //       )
                        //     ],
                        //   )
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (kilogram > 1) {
                                      kilogram--;
                                      kilogramController.text = kilogram.toString();
                                    } else {
                                      kilogram = 1;
                                    }
                                    for (var itemPrice in serviceArgs.prices!) {
                                      if (kilogram <= itemPrice.maxValue!) {
                                        currPrice = itemPrice.price!.toDouble();
                                        break;
                                      }
                                    }
                                  });
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Icon(Icons.remove, color: Colors.white, size: 15),
                                ),
                              ),
                              Container(
                                height: 90,
                                width: size.width / 6,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 50,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        height: 50,
                                        child: TextField(
                                          readOnly: false,
                                          controller: kilogramController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              kilogram = double.parse(value.toString());
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            enabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.all(0),
                                          ),
                                          style: const TextStyle(
                                            height: 1.4,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (kilogram <= (_maxMeasurementValue - 1) && checkPriceType) {
                                      kilogram += 1.0;
                                      kilogramController.text = kilogram.toString();
                                    } else if (kilogram <= (_maxMeasurementValue) && checkPriceType) {
                                      kilogram = _maxMeasurementValue;
                                      kilogramController.text = kilogram.toString();
                                    } else {
                                      kilogram += 1.0;
                                      kilogramController.text = kilogram.toString();
                                    }
                                    for (var itemPrice in serviceArgs.prices!) {
                                      if (kilogram <= itemPrice.maxValue!) {
                                        currPrice = itemPrice.price!.toDouble();
                                        break;
                                      }
                                    }
                                  });
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Icon(Icons.add, color: Colors.white, size: 15),
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (quantity > 1) {
                                      quantity--;
                                      quantityController.text = quantity.toString();
                                    } else {
                                      quantity = 1;
                                    }
                                  });
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Icon(Icons.remove, color: Colors.white, size: 15),
                                ),
                              ),
                              Container(
                                height: 90,
                                width: size.width / 6,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 50,
                                    child: TextField(
                                      readOnly: true,
                                      controller: quantityController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.all(0),
                                      ),
                                      style: const TextStyle(
                                        height: 1.4,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (quantity <= (_maxMeasurementValue - 1) && checkPriceType) {
                                      quantity++;
                                      quantityController.text = quantity.toString();
                                    } else if (quantity <= (_maxMeasurementValue) && checkPriceType) {
                                      quantity = _maxMeasurementValue.toInt();
                                      quantityController.text = quantity.toString();
                                    } else {
                                      quantity++;
                                      quantityController.text = quantity.toString();
                                    }
                                  });
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Icon(Icons.add, color: Colors.white, size: 15),
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), backgroundColor: kPrimaryColor),
                        onPressed: () async {
                          double measurementInput;
                          //debugPrint('Selected value: $selectedDropdownValue');
                          // checkUnitType
                          //     ? measurementInput = (selectedDropdownValue == null
                          //         ? serviceArgs.prices!.first.maxValue!.toDouble()
                          //         : selectedDropdownValue!)
                          //     : measurementInput = quantity.toDouble();
                          checkUnitType ? measurementInput = kilogram.toDouble() : measurementInput = quantity.toDouble();

                          debugPrint('Selected: $measurementInput');
                          //Kiểm tra unit Price nằm trong khoảng nào
                          double currentPrice = 0;
                          double totalCurrentPrice = 0;
                          if (serviceArgs.priceType!) {
                            bool check = false;
                            for (var itemPrice in serviceArgs.prices!) {
                              if (measurementInput <= itemPrice.maxValue! && !check) {
                                currentPrice = itemPrice.price!.toDouble();
                              }
                              if (currentPrice > 0) {
                                check = true;
                              }
                            }
                            if (serviceArgs.minPrice != null && currentPrice * measurementInput < serviceArgs.minPrice!) {
                              totalCurrentPrice = serviceArgs.minPrice!.toDouble();
                            } else {
                              totalCurrentPrice = currentPrice * measurementInput;
                            }
                          } else {
                            totalCurrentPrice = serviceArgs.price! * measurementInput.toDouble();
                            currentPrice = serviceArgs.price!.toDouble();
                          }
                          //print(totalCurrentPrice);
                          //cartItem = CartItem(service: serviceArgs, measurement: 1);
                          //provider.addToCartWithQuantity(cartItem); //add to cart
                          cartItem = CartItem(
                              serviceId: serviceArgs.serviceId!.toInt(),
                              centerId: centerArgs.id!.toInt(),
                              name: serviceArgs.serviceName!,
                              priceType: serviceArgs.priceType!,
                              measurement: measurementInput,
                              thumbnail: serviceArgs.image,
                              price: totalCurrentPrice,
                              unitPrice: currentPrice,
                              customerNote: noteController.text,
                              weight: serviceArgs.rate! * measurementInput.toDouble(),
                              unit: serviceArgs.unit,
                              minPrice: serviceArgs.minPrice == null ? null : serviceArgs.minPrice!.toDouble(),
                              prices: serviceArgs.prices);

                          if (provider.cartItems.isEmpty) {
                            print("provider.cartItems.isEmpty");
                            provider.addItemToCart(cartItem); //add to cart
                            provider.updateCenter(cartItem.centerId);
                            checkAdded = true;
                          } else if (provider.centerId != null && provider.centerId != 0 && provider.centerId != cartItem.centerId) {
                            checkAdded = false;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Thông báo'),
                                  content: Text('Bạn đang có giỏ hàng của cửa hàng khác tồn tại! Đặt với cửa hàng mới hoặc vẫn giữ giỏ hàng cũ?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        provider.removeCart();
                                        provider.addItemToCart(cartItem);
                                        provider.updateCenter(cartItem.centerId);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Đặt mới'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Giữ lại'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            print("else");
                            provider.addItemToCart(cartItem); //add to cart
                            provider.updateCenter(cartItem.centerId);
                            checkAdded = true;
                            //provider.centerId =
                          }
                          bool checkMax = (provider.cartItems.length != 0 && provider.cartItems.last.measurement == _maxMeasurementValue);
                          //await baseController.saveStringtoSharedPreference("customerNote", noteController.text);
                          // ignore: use_build_context_synchronously
                          checkAdded
                              // ignore: use_build_context_synchronously
                              ? showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Thông báo'),
                                      content: checkMax
                                          ? Text(
                                              'Dịch vụ đã được thêm vào giỏ với lượng tối đa cho phép. ($_maxMeasurementValue ${serviceArgs.unit})')
                                          : Text('Dịch vụ đã được thêm vào giỏ.'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: Text('Đóng'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : "";
                          // double measurementInput = checkUnitType
                          //     ? int.parse(kilogramController.text)
                          //     : quantity;

                          //print(cart.length);
                          //provider.addCounter(); //để hiện thị số lượng trong giỏ hàng
                          // productPrice =
                          //     (serviceArgs.price! * measurement) as double?;
                          // provider.addTotalPrice(productPrice!); //add được rồi
                          //_setNameCenter;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Thêm',
                              style: TextStyle(fontSize: 17),
                            ),
                            const SizedBox(width: 7),
                            const Icon(Icons.circle_rounded, size: 3),
                            const SizedBox(width: 7),
                            Text(
                                checkPriceType
                                    ? '${PriceUtils().convertFormatPrice(((currPrice * kilogram < minPrice) ? minPrice : (currPrice * kilogram)).round())} đ'
                                    : '${PriceUtils().convertFormatPrice((quantity * serviceArgs.price!).round())} đ',
                                style: TextStyle(fontSize: 17))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
        ]),
      ),
    );
  }
}
