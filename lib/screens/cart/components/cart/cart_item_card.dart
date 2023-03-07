import 'package:flutter/material.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../models/cart.dart';

class CartItemCard extends StatefulWidget {
  final Cart cart;
  const CartItemCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
              child: Image.asset(widget.cart.service.image[0]),
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
                  widget.cart.service.title,
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
                  ValueListenableBuilder<int>(
                    valueListenable: widget.cart.numOfItems,
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.cart.numOfItems.value--;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.remove,
                              color: Colors.white, size: 15),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${widget.cart.numOfItems.value}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: widget.cart.numOfItems,
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.cart.numOfItems.value++;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(.8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.add,
                              color: Colors.white, size: 15),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  Text(
                    '${widget.cart.service.price} đ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                        fontSize: 17),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
