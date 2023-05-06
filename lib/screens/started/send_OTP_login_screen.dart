import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/screens/profile/information_screen.dart';

import '../../components/constants/color_constants.dart';
import '../../components/constants/size.dart';
import '../../resource/models/current_user.dart';
import '../../resource/models/customer.dart';
import '../home/base_screen.dart';

class SendOTPLoginScreen extends StatefulWidget {
  final String phoneNumber;
  const SendOTPLoginScreen({super.key, required this.phoneNumber});
  @override
  State<SendOTPLoginScreen> createState() => _SendOTPLoginScreenState();
}

class _SendOTPLoginScreenState extends State<SendOTPLoginScreen> {
  OtpFieldController otpController = OtpFieldController();
  bool isOpenKeyboard = false;
  bool isCountdowning = true;
  bool isOneDigits = false;
  Timer? _timer;
  int _start = 300;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            isCountdowning = false;
          });
        } else {
          setState(() {
            _start--;
            if (_start < 10) {
              isOneDigits = true;
            }
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
    if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
      isOpenKeyboard = true;
    } else {
      isOpenKeyboard = false;
    }
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 26,
            ),
          ),
        ),
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
                  isOpenKeyboard
                      ? SizedBox(height: 0, width: 0)
                      : SizedBox(
                          height: 300,
                          width: 300,
                          child: Image.asset(
                              'assets/images/started/authenticate.png'),
                        ),
                  const SizedBox(height: 40),
                  const Text(
                    'Nhập mã xác minh',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nhập mã OTP được gửi đến số điện thoại của bạn.',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  OTPTextField(
                    controller: otpController,
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 60,
                    style: const TextStyle(fontSize: 28),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      var message = await accountController.loginOTP(
                          widget.phoneNumber, pin);
                      //bool isTrue = await verifyController.checkOTPByEmail(pin);
                      if (message.trim().toLowerCase().compareTo("success") ==
                          0) {
                        CurrentUser currentUserModel =
                            await accountController.getCurrentUser();
                        if (currentUserModel != null) {
                          print(currentUserModel.toJson());
                          baseController.saveStringtoSharedPreference(
                              "CURRENT_USER_NAME", currentUserModel.name);
                          baseController.saveStringtoSharedPreference(
                              "CURRENT_USER_EMAIL", currentUserModel.email);
                          baseController.saveStringtoSharedPreference(
                              "CURRENT_USER_PHONE", currentUserModel.phone);
                          baseController.saveInttoSharedPreference(
                              "CURRENT_USER_ID", currentUserModel.accountId);
                          //baseController.saveStringtoSharedPreference("CURRENT_USER_PASSWORD", widget.password!);
                        }
                        Customer? currentCustomer = await accountController
                            .getCustomerInfomation(currentUserModel.accountId!);
                        if (currentCustomer != null) {
                          baseController.saveInttoSharedPreference(
                              "CURRENT_CUSTOMER_ID", currentCustomer.id!);
                        }
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const BaseScreen(),
                                type: PageTransitionType.fade));
                      } else {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: ((context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                title: const Align(
                                  alignment: Alignment.center,
                                  child: Text('Lỗi!!'),
                                ),
                                content: Text('Sai mã OTP'),
                              )),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  isCountdowning
                      ? Text(
                          '${(_start ~/ 60).toString().padLeft(2, '0')}:${(_start % 60).toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Chưa nhận được mã xác nhận?',
                              style: TextStyle(fontSize: 16),
                            ),
                            TextButton(
                              onPressed: () async {},
                              child: const Text(
                                'Gửi lại OTP',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
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
