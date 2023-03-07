import 'package:flutter/material.dart';

import '../../components/constants/color_constants.dart';

class SearchTextField extends StatelessWidget {
  final String searchString;
  final IconData suffixIcon;
  const SearchTextField({
    super.key,
    required this.searchString,
    required this.suffixIcon,
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
                borderSide: const BorderSide(
                  color: kPrimaryColor,
                ),
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
          height: 45,
          width: 45,
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            suffixIcon,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
