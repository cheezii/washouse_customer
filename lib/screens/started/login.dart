import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/size.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';
import 'package:washouse_customer/screens/home/base_screen.dart';
import 'package:washouse_customer/screens/started/signup.dart';

import '../home/home_screen.dart';
import '../reset_password/widgets/forget_password_modal_bottom_sheet.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginState extends State<Login> {
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding,
            horizontal: kDefaultPadding,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/started/phone-verify.png'),
                const SizedBox(height: 16),
                const Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: false,
                  style: const TextStyle(
                    color: textColor,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.phone_android_rounded,
                      color: textColor.withOpacity(.5),
                    ),
                    labelText: 'Số điện thoại',
                  ),
                  cursorColor: textColor.withOpacity(.8),
                  controller: phoneController,
                ),
                TextFormField(
                  obscureText: _isHidden,
                  style: const TextStyle(
                    color: textColor,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.password_rounded,
                        color: textColor.withOpacity(.5),
                      ),
                      labelText: 'Mật khẩu',
                      suffix: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          _isHidden ? Icons.visibility : Icons.visibility_off,
                        ),
                      )),
                  cursorColor: textColor.withOpacity(.8),
                  controller: passwordController,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: size.width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      // var phone = phoneController.text;
                      // var pwd = passwordController.text;

                      // var jwt = await login(phone, pwd);
                      // if (jwt != null) {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const BaseScreen(),
                              type: PageTransitionType.fade));
                      // } else {
                      //   displayDialog(context, "An error occured",
                      //       "No account was found");
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: kPrimaryColor),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      ForgetPasswordScreen.buildShowModalBottomSheet(context);
                    },
                    child: const Text(
                      'Quên mật khẩu?',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 4),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                      child: Text('HOẶC'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2,
                    vertical: kDefaultPadding / 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: kDefaultPadding * 1.5,
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
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const SignUp(),
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
      ),
    );
  }

  Future login(String phone, String password) async {
    try {
      Response response = await post(
          //Uri.parse('https://localhost:44360/api/account/login'),
          Uri.parse('$baseUrl/accounts/login'),
          body: {'phone': phone, 'password': password});
      if (response.statusCode == 200) return response.body;
      return null;
      // if (response.statusCode == 200) {
      //   var data = json.decode(response.body);
      //   print(data);
      // } else {
      //   print(response.body);
      // }
    } catch (e) {
      print(e.toString());
    }
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(text),
        ),
      );

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
