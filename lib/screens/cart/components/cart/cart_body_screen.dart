// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';

import 'package:washouse_customer/resource/models/cart.dart';

import 'cart_item_card.dart';

class CartBodyScreen extends StatefulWidget {
  const CartBodyScreen({super.key});

  @override
  State<CartBodyScreen> createState() => _CartBodyScreenState();
}

class _CartBodyScreenState extends State<CartBodyScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(
                Icons.local_laundry_service_rounded,
                color: kPrimaryColor,
                size: 28,
              ),
              SizedBox(width: 6),
              Text(
                'The Clean House',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              )
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: demoCarts.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Dismissible(
                key: Key(demoCarts[index].service.id.toString()),
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
                  setState(() {
                    demoCarts.removeAt(index);
                  });
                },
                child: CartItemCard(cart: demoCarts[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
