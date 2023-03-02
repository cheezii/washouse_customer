import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/constants/size.dart';

import '../../constants/color_constants.dart';
import '../started/login.dart';
import '../widgets/custom_textfield.dart';
import 'send_otp.dart';

class ResetWithPhone extends StatelessWidget {
  const ResetWithPhone({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding,
            horizontal: kDefaultPadding,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/started/forgotpw.png'),
                const SizedBox(height: kDefaultPadding),
                const Text(
                  'Đặt lại mật khẩu',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: kDefaultPadding),
                const Text(
                  'Nhập số điện thoại của bạn, chúng tôi sẽ gửi mã OTP đến để cài lại mật khẩu.',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: kDefaultPadding),
                const CustomTextfield(
                  icon: Icons.mobile_friendly_rounded,
                  obsecureText: false,
                  hintText: 'Số điện thoại',
                  inputType: TextInputType.number,
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
                              child: const OTPScreen(),
                              type: PageTransitionType.fade));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: kPrimaryColor),
                    child: const Text(
                      'TIẾP TỤC',
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
    );
  }
}
