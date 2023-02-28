import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/screens/profile/reset_password/send_otp.dart';

import '../../../constants/colors/color_constants.dart';
import '../../started/login.dart';
import '../../widgets/custom_textfield.dart';

class ResetWithEmail extends StatelessWidget {
  const ResetWithEmail({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/started/forgotpw.png'),
                  const SizedBox(height: 20),
                  const Text(
                    'Đặt lại mật khẩu',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Nhập email của bạn, chúng tôi sẽ gửi mã OTP đến để cài lại mật khẩu.',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const CustomTextfield(
                    icon: Icons.alternate_email,
                    obsecureText: false,
                    hintText: 'Email',
                    inputType: TextInputType.none,
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 10),
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
