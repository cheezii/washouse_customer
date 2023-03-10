import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/screens/home/home_screen.dart';

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

  List<Widget> pages = const [
    Homescreen(),
    OrderScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  List<IconData> iconList = [
    Icons.other_houses_rounded,
    Icons.assignment,
    Icons.chat_rounded,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartScreen()),
          );
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.shopping_bag),
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
    );
  }
}
