// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../utils/price_util.dart';
import 'category_menu.dart';

class MenuItemCard extends StatelessWidget {
  final String title;
  final String description;
  final String? unit;
  final bool priceType;
  final num? rating;
  final String image;
  final String price;
  final GestureTapCallback press;
  const MenuItemCard({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.unit,
    required this.rating,
    required this.priceType,
    required this.price,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    num minPrice = 0;
    num maxPrice = 0;
    bool multiplePrice = price.contains('-');
    if (multiplePrice) {
      List<String> priceArr = price.split('-');
      minPrice = double.parse(priceArr.first);
      maxPrice = double.parse(priceArr.last);
    }

    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            // Container(
            //   height: 110,
            //   width: 110,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(50),
            //   ),
            //   child: Image.network(image, fit: BoxFit.cover),
            //   //),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image, // replace with your own image URL
                width: 110, // set your desired width here
                height: 110, // set your desired height here
                fit: BoxFit.cover, // set the image fit to cover the entire container
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded.toDouble() / loadingProgress.expectedTotalBytes!.toDouble()
                            : null),
                  );
                }, // replace with your own loading widget
                // ignore: prefer_const_constructors
                errorBuilder: (context, error, stackTrace) => SizedBox(
                  width: 110,
                  height: 110,
                  // ignore: prefer_const_constructors
                  child: Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              height: 100,
              //width: size.width * 0.58,
              width: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        (rating != null && rating != 0)
                            ? Row(
                                children: [
                                  const Icon(Icons.circle_rounded, size: 6),
                                  const SizedBox(width: 5),
                                  Text(rating.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor)),
                                  const SizedBox(
                                      width: 35,
                                      child: Icon(
                                        Icons.star_rounded,
                                        color: kPrimaryColor,
                                        size: 20,
                                      )),
                                ],
                              )
                            : const SizedBox(width: 0),
                      ],
                    ),
                  ),
                  SizedBox(height: 1),
                  Expanded(
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      Text(
                        'Đơn vị tính: ${unit!}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      Text(
                        priceType ? 'Giá theo bảng giá' : 'Giá cố định',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Text(
                    multiplePrice
                        ? '${PriceUtils().convertFormatPrice(minPrice.toInt())} đ - ${PriceUtils().convertFormatPrice(maxPrice.toInt())} đ'
                        : '${PriceUtils().convertFormatPrice(double.parse(price).toInt())} đ',
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
