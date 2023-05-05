import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:washouse_customer/screens/profile/components/change_password_alertdialog.dart';

import '../../components/constants/color_constants.dart';
import '../started/login.dart';
import 'components/manage_account_widget.dart';
import 'components/profile_widget.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({super.key});

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
            size: 24,
          ),
        ),
        centerTitle: true,
        title: const Text('Quản lý tài khoản',
            style: TextStyle(color: textColor, fontSize: 25)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: Column(
          children: [
            ManageAccountWidget(
              icon: Icons.change_circle_outlined,
              title: 'Đổi mật khẩu',
              txtColor: textColor,
              iconColor: textColor,
              press: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const ChangePassWordAlertDialog();
                    });
              },
            ),
            const SizedBox(height: 10),
            ManageAccountWidget(
              icon: Icons.logout_rounded,
              title: 'Đăng xuất',
              txtColor: Colors.red,
              iconColor: Colors.red,
              press: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Align(
                          alignment: Alignment.center,
                          child: Text('Đăng xuất')),
                      content:
                          const Text('Bạn có chắc là muốn đăng xuất không?'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: const BorderSide(
                                        color: kPrimaryColor, width: 1),
                                  ),
                                  backgroundColor: kBackgroundColor),
                              onPressed: () {
                                // Perform some action
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Không, ở lại',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: kPrimaryColor),
                              ),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                          color: cancelledColor, width: 1),
                                    ),
                                    backgroundColor: kBackgroundColor),
                                onPressed: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  // Perform some action
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: const Login(),
                                          type: PageTransitionType.fade));
                                  await preferences.clear();
                                },
                                child: const Text(
                                  'Đúng thế',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700),
                                )),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
