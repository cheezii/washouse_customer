// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:washouse_customer/utils/price_util.dart';

import '../../../../../components/constants/color_constants.dart';
import '../../../../../resource/models/cart_item.dart';

class CartItemCard extends StatefulWidget {
  final num? kilogram;
  final CartItem? cart;
  const CartItemCard({
    Key? key,
    this.kilogram,
    this.cart,
  }) : super(key: key);

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  TextEditingController kilogramController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // kilogramController.text = widget.kilogram.toString();
    // bool checkUnit;

    // if ('Kg'.compareTo(unit!) == 0) {
    //   checkUnit = true;
    // } else {
    //   checkUnit = false;
    // }

    return Row(
      children: [
        // SizedBox(
        //   width: 88,
        //   child: AspectRatio(
        //     aspectRatio: 0.88,
        //     child: Container(
        //       padding: const EdgeInsets.all(10),
        //       decoration: BoxDecoration(
        //         color: const Color(0xfff5f6f9),
        //         borderRadius: BorderRadius.circular(15),
        //       ),
        //       child: Image.asset(widget.cart.service.image!),
        //     ),
        //   ),
        // ),
        // const SizedBox(width: 20),
        // Expanded(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       SizedBox(
        //         width: 200,
        //         child: Text(
        //           widget.cart.service.name!,
        //           style: const TextStyle(
        //               fontSize: 19,
        //               color: Colors.black,
        //               fontWeight: FontWeight.bold),
        //           maxLines: 2,
        //         ),
        //       ),
        //       const SizedBox(height: 12),
        //       Row(
        //         children: [
        //           checkUnit
        //               ? SizedBox(
        //                   width: 100,
        //                   child: Row(
        //                     children: [
        //                       Flexible(
        //                         child: SizedBox(
        //                           height: 40,
        //                           width: 60,
        //                           child: TextField(
        //                             controller: kilogramController,
        //                             keyboardType: TextInputType.number,
        //                             decoration: const InputDecoration(
        //                               enabledBorder: OutlineInputBorder(
        //                                 borderSide: BorderSide(
        //                                     color: Colors.black, width: 1),
        //                                 borderRadius: BorderRadius.all(
        //                                     Radius.circular(10)),
        //                               ),
        //                               focusedBorder: OutlineInputBorder(
        //                                 borderSide: BorderSide(
        //                                     color: kPrimaryColor, width: 1),
        //                                 borderRadius: BorderRadius.all(
        //                                     Radius.circular(10)),
        //                               ),
        //                               contentPadding: EdgeInsets.all(10),
        //                               hintText: 'Số ký',
        //                               hintStyle: TextStyle(
        //                                 fontSize: 17,
        //                                 height: 1.4,
        //                               ),
        //                             ),
        //                             style: const TextStyle(
        //                               height: 1.4,
        //                               fontSize: 17,
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                       const SizedBox(width: 5),
        //                       Text(
        //                         'kg',
        //                         style: TextStyle(fontSize: 17),
        //                       ),
        //                     ],
        //                   ),
        //                 )
        //               : Row(
        //                   children: [
        //                     GestureDetector(
        //                       onTap: () {
        //                         setState(() {
        //                           widget.cart.measurement--;
        //                         });
        //                       },
        //                       child: Container(
        //                         width: 20,
        //                         height: 20,
        //                         decoration: BoxDecoration(
        //                           color: Colors.grey.shade300,
        //                           borderRadius: BorderRadius.circular(4),
        //                         ),
        //                         child: const Icon(Icons.remove,
        //                             color: Colors.white, size: 15),
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding:
        //                           const EdgeInsets.symmetric(horizontal: 8.0),
        //                       child: Text(
        //                         '${widget.cart.measurement}',
        //                         style: const TextStyle(
        //                             fontWeight: FontWeight.bold),
        //                       ),
        //                     ),
        //                     GestureDetector(
        //                       onTap: () {
        //                         setState(() {
        //                           widget.cart.measurement++;
        //                         });
        //                       },
        //                       child: Container(
        //                         width: 20,
        //                         height: 20,
        //                         decoration: BoxDecoration(
        //                           color: kPrimaryColor.withOpacity(.8),
        //                           borderRadius: BorderRadius.circular(4),
        //                         ),
        //                         child: const Icon(Icons.add,
        //                             color: Colors.white, size: 15),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //           const Spacer(),
        //           Text(
        //             '${PriceUtils().convertFormatPrice(widget.cart.service.price!.round())} đ',
        //             style: const TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 color: kPrimaryColor,
        //                 fontSize: 17),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
