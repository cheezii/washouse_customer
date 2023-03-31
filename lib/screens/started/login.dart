import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/size.dart';
import 'package:washouse_customer/resource/controller/account_controller.dart';
import 'package:washouse_customer/resource/models/current_user.dart';
import 'package:washouse_customer/resource/models/response_models/LoginResponseModel.dart';
import 'package:washouse_customer/resource/models/token.dart';
import 'package:washouse_customer/screens/home/base_screen.dart';
import 'package:washouse_customer/screens/started/signup.dart';

import '../../resource/controller/base_controller.dart';
import '../reset_password/widgets/forget_password_modal_bottom_sheet.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();
AccountController accountController = AccountController();
BaseController baseController = BaseController();

class _LoginState extends State<Login> {
  bool _isHidden = true;
  String? _errorMessage;
  String? _responseMessage;

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
                  keyboardType: TextInputType.number,
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
                    onPressed: () async {
                      // _errorMessage = null;
                      // _responseMessage = null;
                      // if (phoneController.text.isEmpty &&
                      //     passwordController.text.isEmpty) {
                      //   _errorMessage =
                      //       "Số điện thoại và mật khẩu không được để trống";
                      // } else if (phoneController.text.isEmpty &&
                      //     !passwordController.text.isEmpty) {
                      //   _errorMessage = "Số điện thoại không được để trống";
                      // }
                      // if (!phoneController.text.isEmpty &&
                      //     passwordController.text.isEmpty) {
                      //   _errorMessage = "Mật khẩu không được để trống";
                      // }

                      // LoginResponseModel? responseModel =
                      //     await accountController.login(
                      //         phoneController.text, passwordController.text);
                      // if (responseModel != null) {
                      //   if (responseModel.statusCode == 17) {
                      //     _responseMessage =
                      //         "Admin không thể đăng nhập trên mobile";
                      //   } else if (responseModel.statusCode == 10) {
                      //     _responseMessage = "Sai số điện thoại hoặc mật khẩu";
                      //     print(_responseMessage);
                      //   } else {
                      //     CurrentUser currentUserModel =
                      //         await accountController.getCurrentUser();
                      //     if (currentUserModel != null) {
                      //       baseController.saveStringtoSharedPreference(
                      //           "CURRENT_USER_NAME", currentUserModel.name);
                      //       baseController.saveStringtoSharedPreference(
                      //           "CURRENT_USER_EMAIL", currentUserModel.email);
                      //       baseController.saveStringtoSharedPreference(
                      //           "CURRENT_USER_AVATAR", currentUserModel.avatar);
                      //       baseController.saveStringtoSharedPreference(
                      //           "CURRENT_USER_ID", currentUserModel.accountId);
                      //     }
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const BaseScreen(),
                              type: PageTransitionType.fade));
                      //   }
                      // }
                      // if (_errorMessage == null) {
                      //   _errorMessage = "";
                      // }
                      // if (_responseMessage == null) {
                      //   _responseMessage = "";
                      // }
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Container(
                      //       padding: const EdgeInsets.all(16),
                      //       height: 90,
                      //       decoration: const BoxDecoration(
                      //         color: Color(0xffc72c41),
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(20)),
                      //       ),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           const Text(
                      //             'Oops',
                      //             style: TextStyle(
                      //                 fontSize: 18, color: Colors.white),
                      //           ),
                      //           Text(
                      //             "$_errorMessage",
                      //             style: const TextStyle(
                      //                 fontSize: 12, color: Colors.white),
                      //             maxLines: 2,
                      //             overflow: TextOverflow.clip,
                      //           ),
                      //           Text(
                      //             "$_responseMessage",
                      //             style: const TextStyle(
                      //                 fontSize: 12, color: Colors.white),
                      //             maxLines: 2,
                      //             overflow: TextOverflow.clip,
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     behavior: SnackBarBehavior.floating,
                      //     backgroundColor: Colors.transparent,
                      //     elevation: 0,
                      //   ),
                      // );
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

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
