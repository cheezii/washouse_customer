import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/size.dart';
import 'package:washouse_customer/resource/controller/account_controller.dart';
import 'package:washouse_customer/resource/models/current_user.dart';
import 'package:washouse_customer/resource/models/customer.dart';
import 'package:washouse_customer/resource/models/response_models/LoginResponseModel.dart';
import 'package:washouse_customer/resource/models/token.dart';
import 'package:washouse_customer/screens/home/base_screen.dart';
import 'package:washouse_customer/screens/home/home_screen.dart';
import 'package:washouse_customer/screens/started/signup.dart';

import '../../resource/controller/base_controller.dart';
import '../reset_password/widgets/forget_password_modal_bottom_sheet.dart';
import 'login_with_SMS_screen.dart';

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
  final typePhoneNum = RegExp(r'(((\+|)84)|0)(3|5|7|8|9)+([0-9]{8})\b');
  final _formPhoneNumberKey = GlobalKey<FormState>();
  final _formPwdKey = GlobalKey<FormState>();
  bool _isHidden = true;
  String _errorMessage = '';
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
                Form(
                  key: _formPhoneNumberKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Số điện thoại không được để trống';
                      }
                      if (!typePhoneNum.hasMatch(value)) {
                        return 'Số điện thoại phải có mười số';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      phoneController.text = newValue!;
                    },
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
                ),
                Form(
                  key: _formPwdKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Mật khẩu không được để trống';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      passwordController.text = newValue!;
                    },
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
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: size.width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      //_errorMessage = null;
                      _responseMessage = '';
                      if (phoneController.text.isEmpty &&
                          passwordController.text.isEmpty) {
                        _errorMessage =
                            "Số điện thoại và mật khẩu không được để trống";
                      } else if (phoneController.text.isEmpty &&
                          !passwordController.text.isEmpty) {
                        _errorMessage = "Số điện thoại không được để trống";
                      }
                      if (!phoneController.text.isEmpty &&
                          passwordController.text.isEmpty) {
                        _errorMessage = "Mật khẩu không được để trống";
                      }

                      if (_formPhoneNumberKey.currentState!.validate() &&
                          _formPwdKey.currentState!.validate()) {
                        _formPwdKey.currentState!.save();
                        _formPhoneNumberKey.currentState!.save();
                        //call api change pwd
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        LoginResponseModel? responseModel =
                            await accountController.login(
                                phoneController.text, passwordController.text);
                        if (responseModel != null) {
                          if (responseModel.statusCode == 17) {
                            _responseMessage =
                                "Admin không thể đăng nhập trên mobile";
                          } else if (responseModel.statusCode == 10) {
                            _responseMessage =
                                "Sai số điện thoại hoặc mật khẩu";
                          } else {
                            CurrentUser currentUserModel =
                                await accountController.getCurrentUser();
                            if (currentUserModel != null) {
                              baseController.saveStringtoSharedPreference(
                                  "CURRENT_USER_NAME", currentUserModel.name);
                              baseController.saveStringtoSharedPreference(
                                  "CURRENT_USER_EMAIL", currentUserModel.email);
                              baseController.saveStringtoSharedPreference(
                                  "CURRENT_USER_AVATAR",
                                  currentUserModel.avatar);
                              baseController.saveStringtoSharedPreference(
                                  "CURRENT_USER_PHONE", currentUserModel.phone);
                              baseController.saveInttoSharedPreference(
                                  "CURRENT_USER_ID",
                                  currentUserModel.accountId!);
                              if (currentUserModel.locationId != null) {
                                baseController.saveInttoSharedPreference(
                                    "CURRENT_USER_LOCATION_ID",
                                    currentUserModel.locationId!);
                              }
                              baseController.saveStringtoSharedPreference(
                                  "CURRENT_USER_PASSWORD",
                                  passwordController.text);
                            }
                            Customer? currentCustomer =
                                await accountController.getCustomerInfomation(
                                    currentUserModel.accountId!);
                            if (currentCustomer != null) {
                              baseController.saveInttoSharedPreference(
                                  "CURRENT_CUSTOMER_ID", currentCustomer.id!);
                              baseController.saveInttoSharedPreference(
                                  "CURRENT_WALLET_ID",
                                  currentCustomer.walletId);
                            }
                            Navigator.of(context).pop();
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: const BaseScreen(),
                                    type: PageTransitionType.fade));

                            print(_responseMessage);
                          }
                        }
                        //Navigator.of(context).pop();
                      }

                      if (_responseMessage == null) {
                        _responseMessage = "";
                      }
                      if (_responseMessage != null && _responseMessage != "") {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Align(
                                  alignment: Alignment.center,
                                  child: Text('Lỗi!!')),
                              content: Text('$_responseMessage'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text(
                                    'Đã hiểu',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: kPrimaryColor),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      backgroundColor: kBackgroundColor),
                                  onPressed: () {
                                    // Perform some action
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }

                      if (_errorMessage == null) {
                        _errorMessage = "";
                      }
                      if (_responseMessage == null) {
                        _responseMessage = "";
                      }
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
                      //           // Text(
                      //           //   "$_errorMessage",
                      //           //   style: const TextStyle(
                      //           //       fontSize: 12, color: Colors.white),
                      //           //   maxLines: 2,
                      //           //   overflow: TextOverflow.clip,
                      //           // ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const LoginWithSMSScreen(),
                                type: PageTransitionType.fade));
                      },
                      child: const Text(
                        'Đăng nhập bằng SMS',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
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
                  ],
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {
                //       ForgetPasswordScreen.buildShowModalBottomSheet(context);
                //     },
                //     child: const Text(
                //       'Quên mật khẩu?',
                //       style: TextStyle(
                //         color: kPrimaryColor,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: kDefaultPadding / 4),
                // Row(
                //   children: const [
                //     Expanded(child: Divider()),
                //     Padding(
                //       padding:
                //           EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                //       child: Text('HOẶC'),
                //     ),
                //     Expanded(child: Divider()),
                //   ],
                // ),
                const SizedBox(height: 16),
                // SizedBox(
                //   width: size.width,
                //   height: 45,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10.0)),
                //         backgroundColor: kPrimaryColor),
                //     child: const Text(
                //       'Đăng nhập bằng SMS',
                //       style: TextStyle(fontSize: 18.0),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 60),
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
