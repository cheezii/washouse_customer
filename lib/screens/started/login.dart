import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/constants/color_constants.dart';
import 'package:washouse_customer/constants/size.dart';
import 'package:washouse_customer/screens/home/base_screen.dart';
import 'package:washouse_customer/screens/started/signup.dart';

import '../reset_password/widgets/forget_password_modal_bottom_sheet.dart';
import '../widgets/custom_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                const SizedBox(height: kDefaultPadding),
                const Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: kDefaultPadding),
                const CustomTextfield(
                  icon: Icons.alternate_email,
                  obsecureText: false,
                  hintText: 'Email/số điện thoại',
                  inputType: TextInputType.text,
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
                  keyboardType: TextInputType.text,
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
                              child: const BaseScreen(),
                              type: PageTransitionType.fade));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: kPrimaryColor),
                    child: const Text(
                      'ĐĂNG NHẬP',
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
                const SizedBox(height: kDefaultPadding),
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
                const SizedBox(height: kDefaultPadding),
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

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
