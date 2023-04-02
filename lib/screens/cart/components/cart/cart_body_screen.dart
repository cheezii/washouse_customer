// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';

import 'package:washouse_customer/resource/models/cart_item.dart';
import 'package:washouse_customer/screens/center/component/details/category_menu.dart';

import '../../../../resource/controller/cart_provider.dart';
import '../../../../utils/price_util.dart';
import 'temp_delete/cart_item_card.dart';

class CartBodyScreen extends StatefulWidget {
  final String centerName;
  const CartBodyScreen({super.key, required this.centerName});

  @override
  State<CartBodyScreen> createState() => _CartBodyScreenState();
}

class _CartBodyScreenState extends State<CartBodyScreen> {
  TextEditingController kilogramController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvidder>(context);
    var cart = provider.cart;
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Consumer<CartProvidder>(builder: (context, value, child) {
        //var cart = value.getCart(); //lấy cart để hiện thị ở đây
        return Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.local_laundry_service_rounded,
                  color: kPrimaryColor,
                  size: 28,
                ),
                SizedBox(width: 6),
                Text(
                  'The Clean House', //lấy name của center, mà chưa nghĩ ra :)
                  //widget.centerName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                )
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
                shrinkWrap: true,
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  int? id = cart[index]!.service.id;
                  num? measurement = cart[index]?.measurement ?? 0;
                  ServiceDemo? service = cart[index]?.service;
                  String? unit = service?.unit ?? '';
                  String image = service?.image ?? '';
                  double? price = service?.price! ?? 0;
                  double? productPrice = price * measurement;

                  bool checkUnit;

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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        provider.clear(id!);
                        setState(() {
                          demoCarts.removeAt(index);
                        });
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
                                child: Image.asset(image),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    service?.name as String,
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
                                                Flexible(
                                                  child: SizedBox(
                                                    height: 40,
                                                    width: 60,
                                                    child: TextField(
                                                      controller:
                                                          kilogramController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          const InputDecoration(
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  kPrimaryColor,
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(10),
                                                        hintText: 'Số ký',
                                                        hintStyle: TextStyle(
                                                          fontSize: 17,
                                                          height: 1.4,
                                                        ),
                                                      ),
                                                      style: const TextStyle(
                                                        height: 1.4,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  'kg',
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (measurement > 0) {
                                                    provider
                                                        .removeFromCartWithQuantity(
                                                            cart[index]!);
                                                  } else {
                                                    provider.clear(
                                                        service?.id as int);
                                                  }
                                                  provider.removeTotalPrice(
                                                      productPrice);
                                                },
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                      size: 15),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  '$measurement',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  provider
                                                      .addToCartWithQuantity(
                                                          cart[index]!);
                                                  provider.removeTotalPrice(
                                                      productPrice);
                                                },
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: kPrimaryColor
                                                        .withOpacity(.8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: const Icon(Icons.add,
                                                      color: Colors.white,
                                                      size: 15),
                                                ),
                                              ),
                                            ],
                                          ),
                                    const Spacer(),
                                    Text(
                                      '${PriceUtils().convertFormatPrice(price.round())} đ',
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
        );
      }),
    );
  }
}
