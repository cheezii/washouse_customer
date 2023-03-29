import 'package:flutter/material.dart';

import '../../../resource/controller/center_controller.dart';
import '../../../resource/models/center.dart';
import '../../center/component/list_center_skeleton.dart';
import '../../center/component/screen_list.dart';

class CustomSearch extends SearchDelegate {
  CenterController centerController = CenterController();
  List<LaundryCenter> centers = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: Icon(Icons.clear_rounded, color: Colors.grey.shade800))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Colors.grey.shade800,
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // List<LaundryCenter> centerList =
    //     centerController.getCenterList() as List<LaundryCenter>;
    // List<LaundryCenter> match = [];
    // for (var item in centerList) {
    //   if (item.title!.toLowerCase().contains(query.toLowerCase())) {
    //     match.add(item);
    //   }
    // }
    // return ListView.builder(
    //   itemCount: match.length,
    //   itemBuilder: (context, index) {
    //     var result = match[index];
    //     return ListTile(
    //       title: Text(result.title!),
    //     );
    //   },
    // );
    return Text('Suggess');
  }

  Future getList() async {
    centers = await centerController.getCenterList();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
    // return Column(
    //   children: [
    //     FutureBuilder<List<LaundryCenter>>(
    //       future: centerController.getCenterListSearch(query),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return const ListCentersSkeleton();
    //         } else if (snapshot.hasData) {
    //           List<LaundryCenter> centerList = snapshot.data!;
    //           return ListView.builder(
    //             shrinkWrap: true,
    //             itemCount: centerList.length,
    //             itemBuilder: ((context, index) {
    //               bool hasRating =
    //                   centerList[index].rating != null ? true : false;

    //               // return Padding(
    //               //   padding: const EdgeInsets.symmetric(vertical: 10),
    //               //   child: ListCenter(
    //               //       thumbnail: centerList[index].thumbnail!,
    //               //       name: centerList[index].title!,
    //               //       distance: centerList[index].distance!,
    //               //       rating: hasRating ? centerList[index].rating! : null,
    //               //       hasRating: hasRating,
    //               //       press: () {}),
    //               // );
    //             }),
    //           );
    //         } else if (snapshot.hasError) {
    //           //return Container();
    //           return Column(
    //             children: const [
    //               SizedBox(height: 20),
    //               Text(
    //                 'Oops',
    //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //               ),
    //               SizedBox(height: 7),
    //               Text(
    //                 'Có lỗi xảy ra rồi!',
    //                 style: TextStyle(fontSize: 16),
    //               ),
    //             ],
    //           );
    //         }
    //         return Text('Search');
    //       },
    //     ),
    //   ],
    // );
  }
}
