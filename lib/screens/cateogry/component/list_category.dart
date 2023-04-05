// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';

class ListCategory extends StatelessWidget {
  final String image;
  final String name;
  final GestureTapCallback press;
  const ListCategory({
    Key? key,
    required this.image,
    required this.name,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(image),
                    maxRadius: 30,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                        color: Colors.transparent,
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 17,
                              color: textColor,
                              fontWeight: FontWeight.w600),
                        )),
                  )
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
