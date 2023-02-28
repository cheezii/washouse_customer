import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/constants/size.dart';
import 'package:washouse_customer/screens/started/login.dart';

import '../../constants/color_constants.dart';
import '../widgets/custom_textfield.dart';

class ChangePwdScreen extends StatelessWidget {
  const ChangePwdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
              horizontal: kDefaultPadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/started/privacy.png'),
                  const SizedBox(height: kDefaultPadding),
                  const Text(
                    'Tạo mật khẩu mới',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  const Text(
                    'Mật khẩu mới của bạn phải khác với mật khẩu đã tạo trước đó.',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: kDefaultPadding),
                  const CustomTextfield(
                    icon: Icons.password,
                    obsecureText: true,
                    hintText: 'Mật khẩu',
                    inputType: TextInputType.none,
                  ),
                  const CustomTextfield(
                    icon: Icons.password,
                    obsecureText: true,
                    hintText: 'Xác nhận mật khẩu',
                    inputType: TextInputType.none,
                  ),
                  const SizedBox(height: kDefaultPadding),
                  SizedBox(
                    width: size.width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const Login(),
                                type: PageTransitionType.fade));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          backgroundColor: kPrimaryColor),
                      child: const Text(
                        'TẠO MẬT KHẨU',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const Login(),
                                type: PageTransitionType.fade));
                      },
                      child: const Text(
                        'Quay lại trang đăng nhập',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
