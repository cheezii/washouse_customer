// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/resource/controller/service_controller.dart';

import 'package:washouse_customer/resource/models/center.dart';
import 'package:washouse_customer/resource/models/service.dart';
import 'package:washouse_customer/screens/center/component/details/category_menu.dart';
import 'package:washouse_customer/screens/center/component/details/center_categories.dart';
import 'package:washouse_customer/utils/center_utils.dart';
import 'package:washouse_customer/utils/time_utils.dart';

import 'component/details/box_info.dart';
import 'component/details/menu_item_card.dart';

class CenterDetailScreen extends StatefulWidget {
  const CenterDetailScreen({super.key});

  @override
  State<CenterDetailScreen> createState() => _CenterDetailScreenState();
}

class _CenterDetailScreenState extends State<CenterDetailScreen> {
  late ScrollController _scrollController;
  ServiceController serviceController = ServiceController();

  CategoryMenu? menu;
  List<Service> serviceList = [];

  DateTime now = DateTime.now();

  void getServiceOfCenter() async {}

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as LaundryCenter;

    serviceController.getServiceListByCenterId(arguments.id!);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 250,
                stretch: true,
                elevation: 0,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    arguments.thumbnail!,
                    fit: BoxFit.cover,
                  ),
                ),
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.black),
                    ),
                  ),
                ),
                actions: const [
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.ios_share,
                        color: Colors.black,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 235),
              ),
              // SliverToBoxAdapter(
              //   child: CenterCategories(
              //     onChanged: (value) {},
              //     selectedIndex: 0,
              //   ),
              // ),
              // SliverPersistentHeader(
              //   delegate: CenterCategoriesSliver(
              //     onChanged: (value) {},
              //     selectedIndex: 0,
              //   ),
              //   pinned: true,
              // ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, categoryIndex) {
                    List<ServiceDemo> items = demoCateList[categoryIndex].item;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            demoCateList[categoryIndex].categoryName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Column(
                            children: List.generate(
                              items.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(5),
                                child: MenuItemCard(
                                  title: items[index].name,
                                  image: items[index].image,
                                  description: items[index].description,
                                  price: items[index].price,
                                  press: () => Navigator.pushNamed(
                                      context, '/serviceDetails',
                                      arguments: items[index]),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                    // return Column(
                    //   children: List.generate(
                    //     items.length,
                    //     (index) => Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 16, vertical: 5),
                    //       child: MenuItemCard(
                    //         title: items[index].name,
                    //         image: items[index].image,
                    //         description: items[index].description,
                    //         price: items[index].price,
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                  childCount: demoCateList.length,
                ),
              ),
            ],
          ),
          _buildCardInfo(),
          _buildCircleMoreInfo(),
          _buildInfoColumn(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        focusColor: sPrimaryColor,
        hoverElevation: 50,
        tooltip: 'Nhắn tin',
        child: const Icon(Icons.chat_rounded),
      ),
    );
  }

  Widget _buildInfoColumn() {
    Size size = MediaQuery.of(context).size;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as LaundryCenter;
    double defaultMargin = 377;
    double defaultStart = 100;
    double defaultEnd = defaultStart / 2;

    double top = defaultMargin;

    double scale = 1.0;

    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;

      if (offset < defaultMargin - defaultStart)
        scale = 1.0;
      else if (offset < defaultStart - defaultEnd)
        scale = (defaultMargin - defaultEnd - offset) / defaultEnd;
      else
        scale = 0;
    }

    bool isHasDelivery = CenterUtils().checkHasDelivery(arguments);
    bool isHasRating = CenterUtils().checkHasRating(arguments);

    return Positioned(
      top: top,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        child: Align(
          child: SizedBox(
            height: 150,
            child: Column(
              children: [
                isHasDelivery
                    ? BoxInfo(
                        size: size,
                        icon: 'assets/images/shipping/ship-di.png',
                        title: 'Có hỗ trợ dịch vụ vận chuyển',
                        pressText: '',
                        press: () {
                          //showDeliveryModalBottomSheet();
                        },
                      )
                    : BoxInfo(
                        size: size,
                        icon: 'assets/images/shipping/ship-di.png',
                        title: 'Không hỗ trợ dịch vụ vận chuyển',
                        pressText: '',
                        press: () {},
                      ),
                BoxInfo(
                  size: size,
                  icon: 'assets/images/service/coupon.png',
                  title: 'Thông tin khuyến mãi',
                  pressText: 'Xem thêm',
                  press: () {},
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(width: 1.0, color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 35,
                        child: Icon(
                          Icons.star_rounded,
                          color: kPrimaryColor,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      isHasRating
                          ? Row(
                              children: [
                                Text('${arguments.rating}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade800)),
                                const SizedBox(width: 5),
                                const Icon(Icons.circle_rounded, size: 3),
                                const SizedBox(width: 5),
                                Text(
                                  '${arguments.numOfRating} lượt đánh giá',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800),
                                )
                              ],
                            )
                          : Text(
                              'Chưa có đánh giá nào',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800),
                            ),
                      const Spacer(),
                      isHasRating
                          ? TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Xem đánh giá',
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                          : const SizedBox(width: 0, height: 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showDeliveryModalBottomSheet() {
    return showModalBottomSheet(
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        builder: ((context) {
          return Container(
            height: 500,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    const SizedBox(width: 70),
                    const Text(
                      'Dịch vụ vận chuyển',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Divider(thickness: 1, color: Colors.grey.shade300),
              ],
            ),
          );
        }));
  }

  Widget _buildCircleMoreInfo() {
    Size size = MediaQuery.of(context).size;
    double defaultMargin = 205;
    double defaultStart = 100;
    double defaultEnd = defaultStart / 2;

    double top = defaultMargin;

    double scale = 1.0;

    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;

      if (offset < defaultMargin - defaultStart)
        scale = 1.0;
      else if (offset < defaultStart - defaultEnd)
        scale = (defaultMargin - defaultEnd - offset) / defaultEnd;
      else
        scale = 0;
    }
    return Positioned(
        top: top,
        right: size.width * 0.13,
        child: Transform(
          transform: Matrix4.identity()..scale(scale),
          child: GestureDetector(
            onTap: () {
              showInfoModalBottomSheet(context);
            },
            child: const Material(
              shape: CircleBorder(side: BorderSide.none),
              elevation: 5,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: Icon(Icons.info_outline_rounded),
              ),
            ),
          ),
        ));
  }

  Future<dynamic> showInfoModalBottomSheet(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as LaundryCenter;
    Size size = MediaQuery.of(context).size;

    var centerOperatingHoursList =
        arguments.centerOperatingHours as List<CenterOperatingHours>;

    Map<int, String> weekdayName = {
      1: "Thứ hai",
      2: "Thứ ba",
      3: "Thứ tư",
      4: "Thứ năm",
      5: "Thứ sáu",
      6: "Thứ bảy",
      0: "Chủ nhật"
    };

    // print('hello from modal: ${weekdayName[centerOperatingHoursList[1].day]}');

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: ((context) => Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            height: 700,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    const SizedBox(width: 70),
                    const Text(
                      'Thông tin cửa hàng',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Divider(thickness: 1, color: Colors.grey.shade300),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Địa chỉ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          arguments.centerAddress!,
                          maxLines: 2,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Giờ mở cửa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                      itemCount: centerOperatingHoursList.length,
                      itemBuilder: ((context, index) {
                        CenterOperatingHours centerOperatingHours =
                            centerOperatingHoursList[index];
                        String? openTime = centerOperatingHours.openTime;
                        String? closedTime = centerOperatingHours.closeTime;
                        bool isBreakDay = TimeUtils()
                            .checkBreakDay(openTime ?? "", closedTime ?? "");
                        bool isNow = TimeUtils()
                            .checkNowWeekDay(centerOperatingHours.day ?? -1);

                        return Row(
                          children: [
                            Container(
                              width: 170,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 16),
                              child: Text(
                                weekdayName[centerOperatingHours.day]!,
                                style: TextStyle(
                                    color: isNow
                                        ? Colors.black
                                        : Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                            isBreakDay
                                ? Text(
                                    'Đóng cửa',
                                    style: TextStyle(
                                        color: closeColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: isNow ? 16 : 14),
                                  )
                                : displayTime(
                                    centerOperatingHours.openTime!,
                                    centerOperatingHours.closeTime!,
                                    isNow,
                                    true),
                          ],
                        );
                      })),
                )
              ],
            ),
          )),
    );
  }

  Widget _buildCardInfo() {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as LaundryCenter;
    Size size = MediaQuery.of(context).size;
    double defaultMargin = 220;
    double defaultStart = 100;
    double defaultEnd = defaultStart / 2;

    double top = defaultMargin;

    double scale = 1.0;

    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;

      if (offset < defaultMargin - defaultStart)
        scale = 1.0;
      else if (offset < defaultStart - defaultEnd)
        scale = (defaultMargin - defaultEnd - offset) / defaultEnd;
      else
        scale = 0;
    }

    bool isOpenTime = true;
    bool isAlmostClose = false;
    int weekdayNow;

    if (now.weekday == 7) {
      weekdayNow = 0;
    } else {
      weekdayNow = now.weekday;
    }

    CenterOperatingHours centerOperatingHours = CenterOperatingHours();
    centerOperatingHours = arguments.centerOperatingHours![weekdayNow];
    String? openTime = arguments.centerOperatingHours![weekdayNow].openTime;
    String? closedTime = arguments.centerOperatingHours![weekdayNow].closeTime;
    bool isBreakDay =
        TimeUtils().checkBreakDay(openTime ?? "", closedTime ?? "");

    if (!isBreakDay) {
      if (!TimeUtils().checkCenterStatus(openTime!, closedTime!)) {
        isOpenTime = false;
      }
      if (TimeUtils().checkCloseTime(openTime)) isAlmostClose = true;
    }
    return Positioned(
      top: top,
      left: size.width * 0.1,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        child: Container(
          height: 150,
          width: size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(3, 5),
                blurRadius: 10,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    arguments.title!,
                    style: const TextStyle(
                      fontSize: 24,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        '${arguments.distance!} km',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.circle_rounded, size: 3),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          arguments.centerAddress!,
                          style: TextStyle(color: Colors.grey.shade600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  isBreakDay
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.circle_rounded,
                                size: 5, color: closeColor),
                            SizedBox(width: 5),
                            Text(
                              'Đóng cửa',
                              style: TextStyle(
                                  color: closeColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      : isAlmostClose
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.circle_rounded,
                                    size: 5, color: almostCloseColor),
                                const SizedBox(width: 5),
                                const Text(
                                  'Sắp đóng cửa',
                                  style: TextStyle(
                                      color: almostCloseColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.circle_rounded, size: 3),
                                const SizedBox(width: 5),
                                Text(
                                  'Đóng cửa vào ${TimeUtils().getDisplayName(closedTime!)}',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ],
                            )
                          : isOpenTime
                              ? Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_rounded,
                                          size: 20,
                                          color: Colors.grey.shade500,
                                        ),
                                        const SizedBox(width: 5),
                                        displayTime(openTime!, closedTime!,
                                            false, false)
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.grey.shade500,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          arguments.phone!,
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 16),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.circle_rounded,
                                        size: 5, color: closeColor),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Đóng cửa',
                                      style: TextStyle(
                                          color: closeColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.circle_rounded, size: 3),
                                    const SizedBox(width: 5),
                                    Text(
                                        'Mở cửa vào ${TimeUtils().getDisplayName(openTime!)}'),
                                  ],
                                )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row displayTime(
      String openTime, String closeTime, bool isNow, bool isShowInfo) {
    return Row(children: [
      Text(
        TimeUtils().getDisplayName(openTime),
        style: TextStyle(
            color: isNow ? Colors.black : Colors.grey.shade600,
            fontWeight: isShowInfo ? FontWeight.w500 : FontWeight.normal,
            fontSize: 16),
      ),
      Text(
        ' - ',
        style: TextStyle(
            color: isNow ? Colors.black : Colors.grey.shade600,
            fontWeight: isShowInfo ? FontWeight.w500 : FontWeight.normal,
            fontSize: 16),
      ),
      Text(
        TimeUtils().getDisplayName(closeTime),
        style: TextStyle(
            color: isNow ? Colors.black : Colors.grey.shade600,
            fontWeight: isShowInfo ? FontWeight.w500 : FontWeight.normal,
            fontSize: 16),
      ),
    ]);
  }
}