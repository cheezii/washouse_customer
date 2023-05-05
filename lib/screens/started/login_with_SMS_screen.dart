import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/screens/started/login.dart';
import 'package:washouse_customer/screens/started/send_OTP_login_screen.dart';

import '../../components/constants/color_constants.dart';
import '../../components/constants/size.dart';

class LoginWithSMSScreen extends StatefulWidget {
  const LoginWithSMSScreen({super.key});

  @override
  State<LoginWithSMSScreen> createState() => _LoginWithSMSScreenState();
}

class _LoginWithSMSScreenState extends State<LoginWithSMSScreen> {
  final typePhoneNum = RegExp(r'(((\+|)84)|0)(3|5|7|8|9)+([0-9]{8})\b');
  final _formPhoneNumberKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SizedBox(height: 60),
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
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formPhoneNumberKey.currentState!.validate()) {
                      _formPhoneNumberKey.currentState!.save();
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const SendOTPLoginScreen(),
                              type: PageTransitionType.fade));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: kPrimaryColor),
                  child: const Text(
                    'Tiếp tục',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding / 4),
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
                    'Đăng nhập bằng mật khẩu',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
