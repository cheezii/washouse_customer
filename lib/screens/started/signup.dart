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
import '../../resource/controller/google_controller.dart';
import '../widgets/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? _errorMessage;
  bool _isHidden = true;
  AccountController accountController = AccountController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding,
            horizontal: kDefaultPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/started/phone-security.png'),
                const SizedBox(height: kDefaultPadding),
                const Text(
                  'Đăng ký',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: kDefaultPadding),
                TextFormField(
                  obscureText: false,
                  style: const TextStyle(
                    color: textColor,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      //Icons.account_circle_outlined,
                      Icons.alternate_email_rounded,
                      color: textColor.withOpacity(.5),
                    ),
                    labelText: 'Email',
                  ),
                  cursorColor: textColor.withOpacity(.8),
                  controller: emailController,
                ),
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
                  keyboardType: TextInputType.text,
                  controller: passwordController,
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
                      labelText: 'Xác nhận mật khẩu',
                      suffix: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          _isHidden ? Icons.visibility : Icons.visibility_off,
                        ),
                      )),
                  cursorColor: textColor.withOpacity(.8),
                  keyboardType: TextInputType.text,
                  controller: conpasswordController,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: size.width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      register(
                          //emailController.text,
                          phoneController.text,
                          passwordController.text,
                          conpasswordController.text);
                      // if (message.compareTo("success") == 0) {
                      //   Navigator.push(
                      //       context,
                      //       PageTransition(
                      //           child: const Login(),
                      //           type: PageTransitionType.fade));
                      // } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            padding: const EdgeInsets.all(16),
                            height: 90,
                            decoration: const BoxDecoration(
                              color: Color(0xffc72c41),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Oops',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  "$_errorMessage",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white),
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                )
                              ],
                            ),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      );
                      //}
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: kPrimaryColor),
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
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
                GestureDetector(
                  onTap: signUp,
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Image.asset('assets/images/google.png'),
                        ),
                        const Text(
                          'Đăng ký bằng Google',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
    );
  }

  Future signUp() async {
    final user = await GoogleControler.login();
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.all(16),
            height: 90,
            decoration: const BoxDecoration(
              color: Color(0xffc72c41),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Oops',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    "Đăng ký không thành công",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                  )
                ],
              ),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      //}
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (Context) => BaseScreen()));
    }
  }

  Future<String?> register(String phone, pass, conpass) async {
    Map data = {
      "phone": phone,
      "email": "",
      "password": pass,
      "confirmPass": conpass
    };
    print(data);

    String body = json.encode(data);
    var url = '$baseUrl/accounts/registerAsCustomer';
    var response = await post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );
    print(response.body);

    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('success');
      setState(() {
        _errorMessage = 'success';
      });
    } else {
      setState(() {
        _errorMessage = jsonResponse(data['message']);
      });
      print("Message 2: " + _errorMessage!);
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
