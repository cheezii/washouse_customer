import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/constants.dart';
import 'package:washouse_customer/screens/started/signup.dart';

import '../home/home_screen.dart';
import '../widgets/custom_textfield.dart';
import 'reset_password.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/washouse-banner.png'),
              const SizedBox(height: 10),
              const Text(
                'Đăng nhập',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              const CustomTextfield(
                  icon: Icons.alternate_email,
                  obsecureText: false,
                  hintText: 'Email/số điện thoại'),
              const CustomTextfield(
                  icon: Icons.password,
                  obsecureText: true,
                  hintText: 'Mật khẩu'),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Homescreen(), type: PageTransitionType.fade));
                },
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: const Center(
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: ResetPassword(),
                        type: PageTransitionType.bottomToTop),
                  );
                },
                child: const Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Quên mật khẩu? ',
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Lấy lại ngay',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('HOẶC'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Image.asset('assets/images/google.png'),
                    ),
                    const Text(
                      'Đăng nhập bằng Google',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: SignUp(),
                      type: PageTransitionType.rightToLeftWithFade,
                    ),
                  );
                },
                child: const Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Chưa có tài khoản? ',
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Đăng ký',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
