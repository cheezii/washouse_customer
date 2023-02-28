import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class SearchTextField extends StatelessWidget {
  final String searchString;
  const SearchTextField({
    super.key,
    required this.searchString,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          height: 50,
          width: size.width * 0.75,
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: kPrimaryColor,
                size: 26,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: searchString,
              labelStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              isDense: true,
            ),
          ),
        ),
        const Spacer(),
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.filter_alt_rounded,
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}
