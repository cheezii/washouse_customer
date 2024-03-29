import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/size.dart';
import 'package:washouse_customer/screens/home/base_screen.dart';
import 'package:washouse_customer/screens/started/login.dart';

import '../../components/constants/text_constants.dart';
import '../../resource/controller/account_controller.dart';
import '../reset_password/send_otp.dart';
import '../widgets/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController conpasswordController = TextEditingController();

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formPwdKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formConPwdKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formPhoneNumKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formEmailKey = GlobalKey<FormState>();
  final typePhoneNum = RegExp(r'(((\+|)84)|0)(3|5|7|8|9)+([0-9]{8})\b');
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  String? _errorMessage;
  bool _isPassHidden = true;
  bool _isConPassHidden = true;
  AccountController accountController = AccountController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBackgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
              horizontal: kDefaultPadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/started/phone-security.png'),
                  const SizedBox(height: kDefaultPadding),
                  const Text(
                    'Đăng ký',
                    style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Form(
                    key: _formPhoneNumKey,
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
                    key: _formEmailKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email không được để trống';
                        }
                        if (!emailRegex.hasMatch(value)) {
                          return 'Vui lòng nhập đúng định dạng email';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        emailController.text = newValue!;
                      },
                      obscureText: false,
                      style: const TextStyle(
                        color: textColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          color: textColor.withOpacity(.5),
                        ),
                        labelText: 'Email',
                      ),
                      cursorColor: textColor.withOpacity(.8),
                      controller: emailController,
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
                      obscureText: _isPassHidden,
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
                              _isPassHidden ? Icons.visibility : Icons.visibility_off,
                            ),
                          )),
                      cursorColor: textColor.withOpacity(.8),
                      controller: passwordController,
                    ),
                  ),
                  Form(
                    key: _formConPwdKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Xác nhận mật khẩu không được để trống';
                        }
                        if (value.compareTo(passwordController.text) != 0) {
                          return 'Xác nhận mật khẩu không khớp!';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        conpasswordController.text = newValue!;
                      },
                      obscureText: _isConPassHidden,
                      style: const TextStyle(
                        color: textColor,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.password_rounded,
                            color: textColor.withOpacity(.5),
                          ),
                          labelText: 'Xác nhận mật khẩu',
                          suffix: InkWell(
                            onTap: _toggleConPasswordView,
                            child: Icon(
                              _isConPassHidden ? Icons.visibility : Icons.visibility_off,
                            ),
                          )),
                      cursorColor: textColor.withOpacity(.8),
                      controller: conpasswordController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formPhoneNumKey.currentState!.validate() &&
                            _formEmailKey.currentState!.validate() &&
                            _formPwdKey.currentState!.validate() &&
                            _formConPwdKey.currentState!.validate()) {
                          _formPhoneNumKey.currentState!.save();
                          _formEmailKey.currentState!.save();
                          _formPwdKey.currentState!.save();
                          _formConPwdKey.currentState!.save();
                          //check pass và email có trong hệ thống chưa

                          // _errorMessage = await accountController.register(
                          //     phoneController.text, emailController.text, passwordController.text, conpasswordController.text);
                          _errorMessage = await accountController.sendPhoneOTP(phoneController.text);
                          //_errorMessage = "success";
                          print(_errorMessage);
                          if (_errorMessage?.compareTo("success") == 0) {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: OTPScreen(
                                      isSignUp: true,
                                      phoneNumber: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      confirmPassword: conpasswordController.text,
                                    ),
                                    type: PageTransitionType.fade));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), backgroundColor: kPrimaryColor),
                      child: const Text(
                        'Đăng ký',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                        child: Text('HOẶC'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // ElevatedButton.icon(
                  //   onPressed: signUp,
                  //   style: ElevatedButton.styleFrom(
                  //     minimumSize: Size(size.width, 50),
                  //   ),
                  //   icon: Image.asset('assets/images/google.png'),
                  //   label: const Text(
                  //     'Đăng ký bằng Google',
                  //     style: TextStyle(
                  //       color: textColor,
                  //       fontSize: 18.0,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     width: size.width,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: kPrimaryColor),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: [
                  //         SizedBox(
                  //           height: 30,
                  //           child: Image.asset('assets/images/google.png'),
                  //         ),
                  //         const Text(
                  //           'Đăng ký bằng Google',
                  //           style: TextStyle(
                  //             color: textColor,
                  //             fontSize: 18.0,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const Login(),
                          type: PageTransitionType.leftToRightWithFade,
                        ),
                      );
                    },
                    child: const Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Đã có tài khoản? ',
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                            TextSpan(
                              text: 'Đăng nhập',
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
      ),
    );
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
      _isPassHidden = !_isPassHidden;
    });
  }

  void _toggleConPasswordView() {
    setState(() {
      _isConPassHidden = !_isConPassHidden;
    });
  }
}
