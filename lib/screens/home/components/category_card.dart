// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String icon;
  final String text;
  final GestureTapCallback press;
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 50,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipOval(
                  child: Image.network(icon, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              // wrap the Text widget in an Expanded widget
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
            // Text(
            //   text,
            //   textAlign: TextAlign.center,
            //   style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            // )
          ],
        ),
      ),
    );
  }
}
