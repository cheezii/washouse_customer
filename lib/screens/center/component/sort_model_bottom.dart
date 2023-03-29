import 'package:flutter/material.dart';

class SortModalBottomSheet {
  static Future<dynamic> buildShowSortModalBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: ((context) => Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.close_rounded),
                    SizedBox(width: 110),
                    Text(
                      'Sắp xếp theo',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Divider(thickness: 1, color: Colors.grey.shade300),
                const SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
}
