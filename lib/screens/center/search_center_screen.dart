import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:washouse_customer/screens/center/list_center_screen.dart';

import '../../components/constants/color_constants.dart';
import '../../components/constants/text_constants.dart';
import '../../resource/controller/center_controller.dart';
import '../../resource/models/center.dart';
import 'component/list_center_skeleton.dart';
import 'component/screen_list.dart';

class SearchCenterScreen extends StatefulWidget {
  const SearchCenterScreen({super.key});

  @override
  State<SearchCenterScreen> createState() => _SearchCenterScreenState();
}

class _SearchCenterScreenState extends State<SearchCenterScreen> {
  CenterController centerController = CenterController();
  final TextEditingController _filter = TextEditingController();
  String _searchText = '';
  List<LaundryCenter> centerList = [];
  List<LaundryCenter> suggetsList = [];

  void getListCenter() async {
    centerList = await centerController.getCenterList('', '', '', '', '');
  }

  void getSuggest(String value) {
    setState(() {
      suggetsList = centerList
          .where((element) =>
              element.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    getListCenter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.7,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: textColor,
            size: 24,
          ),
        ),
        title: TextField(
          onChanged: (value) => getSuggest(_filter.text),
          controller: _filter,
          textInputAction: TextInputAction.search,
          textAlign: TextAlign.left,
          decoration: const InputDecoration(
            hintText: 'Tìm tiệm giặt',
            enabledBorder: InputBorder.none,
          ),
          onSubmitted: (value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListCenterScreen(
                        pageName: value, isNearby: false, isSearch: true)));
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_filter.text.isEmpty) {
                Navigator.pop(context);
              } else {
                _filter.text = '';
              }
            },
            icon: const Icon(
              Icons.close_rounded,
              color: textColor,
              size: 24,
            ),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: suggetsList == null ? 0 : suggetsList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.search_rounded),
              title: Text(suggetsList[index].title!),
              onTap: () {
                //Navigator.push(context, Ma)
              },
            );
          }),
    );
  }
}
