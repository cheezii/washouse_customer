// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/resource/controller/center_controller.dart';

import 'package:washouse_customer/resource/models/cart_item.dart';
import 'package:washouse_customer/screens/center/component/details/category_menu.dart';

import '../../../../resource/controller/cart_provider.dart';
import '../../../../resource/models/center.dart';
import '../../../../utils/formatter_util.dart';
import '../../../../utils/price_util.dart';
import '../../../../utils/shared_preferences_util.dart';
import 'temp_delete/cart_item_card.dart';

class CartBodyScreen extends StatefulWidget {
  const CartBodyScreen({super.key});

  @override
  State<CartBodyScreen> createState() => _CartBodyScreenState();
}

class _CartBodyScreenState extends State<CartBodyScreen> {
  //TextEditingController kilogramController = TextEditingController();
  CenterController centerController = CenterController();
  LaundryCenter center = LaundryCenter();
  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().loadCartItemsFromPrefs();
    getCenterDetail();
  }

  void getCenterDetail() async {
    centerController.getCenterById(context.read<CartProvider>().centerId!).then(
      (result) {
        setState(() {
          center = result;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);
    //LaundryCenter center = await centerController.getCenterById(provider.centerId!);
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Consumer<CartProvider>(builder: (context, value, child) {
        //var cart = value.getCart(); //lấy cart để hiện thị ở đây

        return provider.cartItems.length > 0
            ? Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.local_laundry_service_rounded,
                        color: kPrimaryColor,
                        size: 28,
                      ),
                      SizedBox(width: 6),
                      (center.title != null)
                          ? Text(
                              //'The Clean House', //lấy name của center, mà chưa nghĩ ra :)
                              center.title!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            )
                          : CircularProgressIndicator()
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.cartItems.length,
                      itemBuilder: (context, index) {
                        int? id = value.cartItems[index].serviceId;
                        num measurement =
                            value.cartItems[index]?.measurement ?? 0;
                        //ServiceDemo? service = cart[index]?.service;
                        String? unit = value.cartItems[index].unit ?? '';
                        String image = value.cartItems[index].thumbnail ?? '';
                        double? price = value.cartItems[index].price! ?? 0;
                        double? productPrice = price * measurement;
                        bool checkPriceType = false;
                        double _maxMeasurementValue =
                            value.cartItems[index].priceType
                                ? value.cartItems[index].prices!.last.maxValue!
                                    .toDouble()
                                : 0;
                        if (value.cartItems[index].priceType!) {
                          checkPriceType = true;
                        }

                        bool checkUnit;
                        TextEditingController kilogramController =
                            TextEditingController(
                                text: value.cartItems[index].measurement
                                    .toString());
                        //kilogramController = TextEditingController(
                        //    text: value.cartItems[index].measurement.toString());
                        // kilogramController.selection = TextSelection.fromPosition(
                        //    TextPosition(offset: kilogramController.text.length));
                        if ('Kg'.compareTo(unit) == 0) {
                          checkUnit = true;
                        } else {
                          checkUnit = false;
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Dismissible(
                            key: Key(id.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xffffe6e6),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: const [
                                  Spacer(),
                                  Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                            onDismissed: (direction) {
                              //provider.clear(id!);
                              value.removeItemFromCart(value.cartItems[index]);
                              baseController.printAllSharedPreferences();
                              value.removerCounter();
                              // setState(() {

                              // });
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 88,
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xfff5f6f9),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.network(image,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          value.cartItems[index].name as String,
                                          style: const TextStyle(
                                              fontSize: 19,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          checkUnit
                                              ? SizedBox(
                                                  width: 100,
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (measurement >
                                                                1) {
                                                              provider.removeFromCartWithKilogram(
                                                                  value.cartItems[
                                                                      index]!);
                                                            } else {
                                                              provider.removeItemFromCart(
                                                                  value.cartItems[
                                                                      index]);
                                                              // provider
                                                              //     .removerCounter();
                                                            }
                                                            // provider.removeTotalPrice(
                                                            //     productPrice);
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 25,
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey.shade300,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: const Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.white,
                                                              size: 15),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 60,
                                                          child: TextField(
                                                            controller:
                                                                kilogramController,
                                                            textAlign: TextAlign
                                                                .center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              MaxValueFormatter(
                                                                  _maxMeasurementValue)
                                                            ],
                                                            onChanged: (value) {
                                                              setState(() {
                                                                measurement = double
                                                                    .parse(value
                                                                        .toString());
                                                                //kilogramController.text = value.toString();
                                                              });
                                                            },
                                                            decoration:
                                                                const InputDecoration(
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                            ),
                                                            style:
                                                                const TextStyle(
                                                              height: 1.4,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (measurement <=
                                                                    (_maxMeasurementValue -
                                                                        1) &&
                                                                checkPriceType) {
                                                              // value.cartItems[index]
                                                              //     .measurement++;
                                                              provider.addToCartWithKilogram(
                                                                  value.cartItems[
                                                                      index]);
                                                              // provider
                                                              //     .removeTotalPrice(
                                                              //         productPrice);
                                                              kilogramController
                                                                      .text =
                                                                  measurement
                                                                      .toString();
                                                            } else if (measurement <=
                                                                    (_maxMeasurementValue) &&
                                                                checkPriceType) {
                                                              value
                                                                      .cartItems[
                                                                          index]
                                                                      .measurement =
                                                                  _maxMeasurementValue;
                                                              provider.addToCartWithKilogram(
                                                                  value.cartItems[
                                                                      index]);
                                                              // provider
                                                              //     .removeTotalPrice(
                                                              //         productPrice);
                                                              kilogramController
                                                                      .text =
                                                                  measurement
                                                                      .toString();
                                                            } else {
                                                              // value.cartItems[index]
                                                              //     .measurement++;
                                                              provider.addToCartWithKilogram(
                                                                  value.cartItems[
                                                                      index]);
                                                              // provider
                                                              //     .removeTotalPrice(
                                                              //         productPrice);
                                                              kilogramController
                                                                      .text =
                                                                  measurement
                                                                      .toString();
                                                            }
                                                          });
                                                          // provider
                                                          //     .addToCartWithQuantity(
                                                          //         value.cartItems[
                                                          //             index]!);
                                                          // print(provider
                                                          //     .cartItems[index].price);
                                                          // provider.removeTotalPrice(
                                                          //     productPrice);
                                                        },
                                                        child: Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: kPrimaryColor
                                                                .withOpacity(
                                                                    .8),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                              size: 15),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        'kg',
                                                        style: TextStyle(
                                                            fontSize: 17),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        print(
                                                            'MESUREMENT-${measurement}');
                                                        if (measurement > 1) {
                                                          provider
                                                              .removeFromCartWithQuantity(
                                                                  value.cartItems[
                                                                      index]!);
                                                        } else {
                                                          provider
                                                              .removeItemFromCart(
                                                                  value.cartItems[
                                                                      index]);
                                                          //provider.removerCounter();
                                                        }
                                                        // provider.removeTotalPrice(
                                                        //     productPrice);
                                                      },
                                                      child: Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade300,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: const Icon(
                                                            Icons.remove,
                                                            color: Colors.white,
                                                            size: 15),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                        '$measurement',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (measurement <=
                                                                (_maxMeasurementValue -
                                                                    1) &&
                                                            checkPriceType) {
                                                          // value.cartItems[index]
                                                          //     .measurement++;
                                                          provider
                                                              .addToCartWithQuantity(
                                                                  value.cartItems[
                                                                      index]);
                                                          // provider.removeTotalPrice(
                                                          //     productPrice);
                                                          // kilogramController.text =
                                                          //     measurement.toString();
                                                        } else if (measurement <=
                                                                (_maxMeasurementValue) &&
                                                            checkPriceType) {
                                                          value.cartItems[index]
                                                                  .measurement =
                                                              _maxMeasurementValue;
                                                          provider
                                                              .addToCartWithQuantity(
                                                                  value.cartItems[
                                                                      index]);
                                                          // provider.removeTotalPrice(
                                                          //     productPrice);
                                                          // kilogramController.text =
                                                          //     measurement.toString();
                                                        } else {
                                                          // value.cartItems[index]
                                                          //     .measurement++;
                                                          provider
                                                              .addToCartWithQuantity(
                                                                  value.cartItems[
                                                                      index]);
                                                          // provider.removeTotalPrice(
                                                          //     productPrice);
                                                          // kilogramController.text =
                                                          //     measurement.toString();
                                                        }
                                                        // provider
                                                        //     .addToCartWithQuantity(
                                                        //         value.cartItems[
                                                        //             index]!);
                                                        // print(provider
                                                        //     .cartItems[index].price);
                                                        // provider.removeTotalPrice(
                                                        //     productPrice);
                                                      },
                                                      child: Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: kPrimaryColor
                                                              .withOpacity(.8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: const Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: 15),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          const Spacer(),
                                          Text(
                                            '${PriceUtils().convertFormatPrice(price.round())} đ',
                                            //'${value.cartItems[index].price} đ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryColor,
                                                fontSize: 17),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              )
            : Text("Giỏ hàng trống");
      }),
    );
  }
}
