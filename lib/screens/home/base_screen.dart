import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/resource/controller/cart_provider.dart';
import 'package:washouse_customer/screens/home/home_screen.dart';
import 'package:badges/badges.dart' as badges;

import '../cart/cart_screen.dart';
import '../chat/chat_screen.dart';
import '../order/order_screen.dart';
import '../profile/profile_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  String _centerName = '';

  List<Widget> pages = const [
    Homescreen(),
    OrderScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  List<IconData> iconList = [
    Icons.home_rounded,
    Icons.assignment,
    Icons.chat,
    Icons.person,
  ];

  void _getNameCenter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _centerName = prefs.getString('center_name') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);
    return badges.Badge(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
        floatingActionButton: badges.Badge(
          badgeContent: Consumer<CartProvider>(
            builder: (context, value, child) {
              bool checkItem;
              //if (value.getCounter() > 0) {
              if (value.cartItems.isNotEmpty) {
                checkItem = true;
              } else {
                checkItem = false;
              }
              return Text(
                //checkItem ? value.getCounter().toString() : '0',
                checkItem ? value.cartItems.length.toString() : '0',
                style: TextStyle(color: Colors.white),
              );
            },
          ),
          badgeAnimation: badges.BadgeAnimation.slide(
            animationDuration: Duration(milliseconds: 300),
          ),
          badgeStyle: badges.BadgeStyle(
            shape: badges.BadgeShape.square,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            borderRadius: BorderRadius.circular(50),
            elevation: 0,
          ),
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              _getNameCenter;
              Navigator.pushNamed(
                context,
                '/cart',
                arguments: _centerName,
              );
              //provider.removerCounter();
              //provider.removerCounter();
            },
            backgroundColor: kPrimaryColor,
            child: const Icon(Icons.shopping_bag),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: kPrimaryColor,
          activeColor: kPrimaryColor,
          inactiveColor: Colors.black.withOpacity(.3),
          icons: iconList,
          activeIndex: _selectedIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          elevation: 0,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
