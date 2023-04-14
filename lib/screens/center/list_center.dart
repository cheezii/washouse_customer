// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skeletons/skeletons.dart';
import 'package:washouse_customer/resource/controller/category_controller.dart';

import 'package:washouse_customer/resource/controller/center_controller.dart';
import 'package:washouse_customer/resource/controller/map_controller.dart';
import 'package:washouse_customer/resource/models/category.dart';
import 'package:washouse_customer/screens/center/component/list_category_checkbox_skeleton.dart';
import 'package:washouse_customer/screens/home/base_screen.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/models/center.dart';
import 'component/center_container.dart';
import '../../resource/models/request_models/filter_center_model.dart';
import 'search_center_screen.dart';
import 'component/list_center_skeleton.dart';

class ListCenterScreen extends StatefulWidget {
  final String? pageName;
  final String? CategoryServices;
  final bool isNearby;
  final bool isSearch;
  const ListCenterScreen({
    Key? key,
    this.CategoryServices,
    this.pageName,
    required this.isNearby,
    required this.isSearch,
  }) : super(key: key);

  @override
  State<ListCenterScreen> createState() => _ListCenterScreenState();
}

class _ListCenterScreenState extends State<ListCenterScreen> {
  CenterController centerController = CenterController();
  CategoryController categoryController = CategoryController();
  MapUserController mapUserController = MapUserController();

  TextEditingController searchController = TextEditingController();
  TextEditingController minBudgetController = TextEditingController();
  TextEditingController maxBudgetController = TextEditingController();

  Future<List<LaundryCenter>>? listAction;
  FilterCenterRequest _filter = FilterCenterRequest();

  List<LaundryCenter> allCenter = [];
  List<LaundryCenter> suggesCenter = [];
  List<ServiceCategory> cateList = [];
  List<ServiceCategory> cateListChoose = [];

  String? sortedBy;
  String filterCate = 'Loại dịch vụ';
  String sortChoosen = 'Sắp xếp theo';
  String budgetRange = 'Khoảng giá';

  Color boxSortColor = Colors.white;
  Color boxCateColor = Colors.white;
  Color boxRangeColor = Colors.white;
  Color boxDeliveryColor = Colors.white;
  Color selectedColor = Colors.grey.shade300;

  bool isLoadingCate = true;
  bool isLoadingLocation = true;
  bool isAcceptLocation = false;

  int countCateChoosen = 0;
  // late List<LaundryCenter> _centers;
  // bool _isLoading = true;

  void getPermissionLocation() async {
    isAcceptLocation = await mapUserController.handleLocationPermission();
    if (isAcceptLocation) {
      setState(() {
        isLoadingLocation = false;
      });
    }
  }

  void suggestionList(String value) {
    setState(() {
      suggesCenter = allCenter.where((element) => element.title!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  void getCategory() async {
    cateList = await categoryController.getCategoriesList();
    if (cateList.isNotEmpty) {
      setState(() {
        isLoadingCate = false;
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    minBudgetController.dispose();
    maxBudgetController.dispose();
    super.dispose();
  }

  // Future<void> _fetchLaundryCenters(FilterCenterRequest filter) async {
  //   try {
  //     final centers = await centerController.getCenterList(filter);
  //     setState(() {
  //       _centers = centers;
  //     });
  //   } catch (e) {
  //     // Handle errors
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    getCategory();
    getPermissionLocation();
    super.initState();

    // // Fetch the laundry centers on screen load
    // final filter = FilterCenterRequest(
    //   page: 1,
    //   pageSize: 1000,
    //   sort: 'location',
    // );
    // _fetchLaundryCenters(filter);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    searchController.text = widget.pageName!;
    _filter.searchString = widget.pageName!;
    _filter.categoryServices = widget.CategoryServices;
    if (widget.pageName! == "Tiệm giặt gần đây") {
      _filter.searchString = null;
      _filter.sort = "location";
    }
    listAction = centerController.getCenterList(_filter);
    // if (widget.isNearby) {
    //   listAction = centerController.getCenterNearby();
    // } else if (searchController.text.isNotEmpty) {
    //   listAction =
    //       centerController.getCenterList(1, 1000, null, null, null,searchController.text, '', '', '', '');
    // } else {
    //   listAction = centerController.getCenterList('', '', '', '', '');
    // }
    //if (isAcceptLocation) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            widget.isNearby
                ? Navigator.pop(context)
                : Navigator.push(context, PageTransition(child: const BaseScreen(), type: PageTransitionType.leftToRightWithFade));
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: textColor,
            size: 24,
          ),
        ),
        centerTitle: widget.isSearch ? false : true,
        title: widget.isSearch
            ? TextField(
                textInputAction: TextInputAction.search,
                controller: searchController,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                ),
                onSubmitted: (value) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ListCenterScreen(pageName: value, isNearby: false, isSearch: true)));
                },
              )
            : Text(widget.pageName!, style: const TextStyle(color: textColor, fontSize: 23)),
        actions: [
          widget.isSearch
              ? IconButton(
                  onPressed: () {
                    if (searchController.text.isEmpty) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const BaseScreen()));
                    } else {
                      searchController.text = '';
                    }
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: textColor,
                    size: 24,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchCenterScreen()));
                  },
                  icon: const Icon(Icons.search_rounded, color: textColor, size: 30),
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            SizedBox(
              height: 40,
              width: size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showSortModalBottomSheet(context);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 124,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(20),
                            color: boxSortColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  sortChoosen,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.keyboard_arrow_down_rounded)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Lọc theo:',
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          showFilterCateModalBottomSheet(context, size);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 140,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(20),
                            color: boxCateColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  filterCate,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.keyboard_arrow_down_rounded)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          showBudgetRangeModalBottomSheet(context);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(20),
                            color: boxRangeColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  budgetRange,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.keyboard_arrow_down_rounded)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          if (boxDeliveryColor.value == selectedColor.value) {
                            setState(() {
                              boxDeliveryColor = Colors.white;
                            });
                          } else {
                            setState(() {
                              boxDeliveryColor = selectedColor;
                            });
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(20),
                            color: boxDeliveryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Vận chuyển',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                //SizedBox(width: 4),
                                //Icon(Icons.keyboard_arrow_down_rounded)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Skeleton(
              isLoading: isLoadingLocation,
              skeleton: const ListCentersSkeleton(),
              child: FutureBuilder<List<LaundryCenter>>(
                future: listAction,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListCentersSkeleton();
                  } else if (snapshot.data != null) {
                    List<LaundryCenter> centerList = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: centerList.length,
                      itemBuilder: ((context, index) {
                        bool hasRating = centerList[index].rating != null ? true : false;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CenterContainer(
                            thumbnail: centerList[index].thumbnail!,
                            name: centerList[index].title!,
                            distance: centerList[index].distance!,
                            rating: hasRating ? centerList[index].rating! : null,
                            hasRating: hasRating,
                            press: () => Navigator.pushNamed(
                              context,
                              '/centerDetails',
                              arguments: centerList[index],
                            ),
                          ),
                        );
                      }),
                    );
                  } else if (snapshot.hasError) {
                    //return Container();
                    return Column(
                      children: const [
                        SizedBox(height: 20),
                        Text(
                          'Oops',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Có lỗi xảy ra rồi!',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showBudgetRangeModalBottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        height: 350,
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                const SizedBox(width: 90),
                const Text(
                  'Chọn khoảng giá',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Divider(thickness: 1, color: Colors.grey.shade300),
            const SizedBox(height: 34),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tối thiểu'),
                    const SizedBox(height: 6),
                    Container(
                      height: 50,
                      width: size.width / 4,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: minBudgetController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 23),
                Column(
                  children: const [
                    SizedBox(height: 17),
                    Text(
                      ' - ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(width: 23),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tối đa'),
                    const SizedBox(height: 6),
                    Container(
                      height: 50,
                      width: size.width / 4,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: maxBudgetController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // const SizedBox(height: 5),
            // errorMsg.isNotEmpty
            //     ? Text(
            //         errorMsg,
            //         style: TextStyle(color: Colors.red),
            //       )
            //     : const SizedBox(height: 1),
            // const SizedBox(height: 5),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 170,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (minBudgetController.text.isNotEmpty || maxBudgetController.text.isNotEmpty) {
                        minBudgetController.clear();
                        maxBudgetController.clear();
                      } else {
                        Navigator.pop(context);
                        setState(() {
                          boxRangeColor = Colors.white;
                          budgetRange = 'Khoảng giá';
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: kPrimaryColor),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.white),
                    child: const Text('Hủy', style: TextStyle(fontSize: 17, color: kPrimaryColor)),
                  ),
                ),
                SizedBox(
                  width: 170,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      String errorMsg = '';
                      int min = int.parse(minBudgetController.text);
                      int max = int.parse(maxBudgetController.text);
                      _filter.budgetRange = "$min-$max";
                      print(_filter.budgetRange);
                      if (min > max) {
                        errorMsg = 'Giá tối thiểu phải nhỏ hơn giá tối đa';
                      }
                      if (min < 0 || max < 0) {
                        errorMsg = 'Giá cả không thể bé hơn 0!';
                      }
                      print(errorMsg);
                      if (errorMsg.isNotEmpty) {
                        AlertDialog(
                          title: const Text('Oops'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(errorMsg),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Tôi hiểu rồi'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      } else {
                        setState(() {
                          budgetRange = '${minBudgetController.text} - ${maxBudgetController.text}';
                          boxRangeColor = selectedColor;
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: kPrimaryColor),
                    child: const Text('Đồng ý', style: TextStyle(fontSize: 17)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> showFilterCateModalBottomSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: 700,
        child: StatefulBuilder(
          builder: (context, setState) => Stack(children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  snap: false,
                  elevation: 1,
                  leading: IconButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                    ),
                  ),
                  backgroundColor: kBackgroundColor,
                  flexibleSpace: const FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      'Loại dịch vụ',
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return isLoadingCate
                        ? ListCategoriesCheckboxSkeleton()
                        : CheckboxListTile(
                            value: cateListChoose.contains(cateList[index]),
                            onChanged: (value) {
                              if (value! == true) {
                                setState(() {
                                  Navigator.pop(context);
                                  cateListChoose.add(cateList[index]);
                                  filterCate = 'Loại dịch vụ (${cateListChoose.length})';
                                  _filter.categoryServices = cateListChoose.map((cate) => cate.id.toString()).join(',');
                                });
                                this.setState(() {
                                  boxCateColor = selectedColor;
                                });
                              } else {
                                setState(() {
                                  Navigator.pop(context);
                                  cateListChoose.remove(cateList[index]);
                                  this.setState(() {
                                    filterCate = 'Loại dịch vụ (${cateListChoose.length})';
                                    _filter.categoryServices = cateListChoose.map((cate) => cate.id.toString()).join(',');

                                    print(_filter.categoryServices);
                                    if (cateListChoose.length == 0) {
                                      this.setState(() {
                                        _filter.categoryServices = null;
                                        boxCateColor = Colors.white;
                                        filterCate = 'Loại dịch vụ';
                                      });
                                    }
                                  });
                                });
                              }
                            },
                            title: Text(cateList[index].categoryName!),
                          );
                    // Skeleton(
                    //   isLoading: true,
                    //   skeleton: SkeletonLine(
                    //       style: SkeletonLineStyle(
                    //     height: 10,
                    //     width: 150,
                    //     borderRadius: BorderRadius.circular(8),
                    //   )),
                    //   child:
                    //   CheckboxListTile(
                    //     value: cateListChoose.contains(cateList[index]),
                    //     onChanged: (value) {
                    //       if (value! == true) {
                    //         setState(() {
                    //           Navigator.pop(context);
                    //           cateListChoose.add(cateList[index]);
                    //           filterCate =
                    //               'Loại dịch vụ (${cateListChoose.length})';
                    //           print(cateListChoose.length);
                    //         });
                    //         this.setState(() {
                    //           boxCateColor = selectedColor;
                    //         });
                    //       } else {
                    //         setState(() {
                    //           Navigator.pop(context);
                    //           cateListChoose.remove(cateList[index]);
                    //           this.setState(() {
                    //             filterCate =
                    //                 'Loại dịch vụ (${cateListChoose.length})';
                    //             if (cateListChoose.length == 0) {
                    //               this.setState(() {
                    //                 boxCateColor = Colors.white;
                    //                 filterCate = 'Loại dịch vụ';
                    //               });
                    //             }
                    //           });
                    //         });
                    //       }
                    //     },
                    //     title: Text(cateList[index].categoryName!),
                    //   ),
                    // );
                  }, childCount: cateList.length),
                ),
              ],
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: size.width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        filterCate = 'Loại dịch vụ';
                        boxCateColor = Colors.white;
                        cateListChoose = [];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: kPrimaryColor),
                    child: const Text('Làm mới', style: TextStyle(fontSize: 17)),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<dynamic> showSortModalBottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: ((context) => Container(
            height: 350,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: StatefulBuilder(
              builder: (context, setState) => Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      const SizedBox(width: 90),
                      const Text(
                        'Sắp xếp theo',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.grey.shade300),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const Text('Gần đây'),
                    trailing: Radio<String>(
                      value: 'Gần đây',
                      groupValue: sortedBy,
                      onChanged: (value) {
                        Navigator.pop(context);
                        setState(() {
                          sortedBy = value;
                          _filter.sort = "location";
                        });
                        this.setState(() {
                          sortChoosen = value.toString();
                          boxSortColor = selectedColor;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Đánh giá tốt'),
                    trailing: Radio<String>(
                      value: 'Đánh giá tốt',
                      groupValue: sortedBy,
                      onChanged: (value) {
                        Navigator.pop(context);
                        setState(() {
                          sortedBy = value;
                          _filter.sort = "rating";
                        });
                        this.setState(() {
                          sortChoosen = value.toString();
                          boxSortColor = Colors.grey.shade300;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: size.width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          sortedBy = null;
                          _filter.sort = null;
                        });
                        this.setState(() {
                          sortChoosen = 'Sắp xếp theo';
                          boxSortColor = Colors.white;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: kPrimaryColor),
                      child: const Text('Làm mới', style: TextStyle(fontSize: 17)),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
