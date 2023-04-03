import 'package:flutter/material.dart';

import '../../../components/constants/color_constants.dart';

class ChangePassWordAlertDialog extends StatefulWidget {
  const ChangePassWordAlertDialog({super.key});

  @override
  State<ChangePassWordAlertDialog> createState() =>
      _ChangePassWordAlertDialogState();
}

class _ChangePassWordAlertDialogState extends State<ChangePassWordAlertDialog> {
  final _formPwdKey = GlobalKey<FormState>();
  final _formConfirmKey = GlobalKey<FormState>();

  late String newPassword;
  late String confirmNewPassword;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Align(
        alignment: Alignment.center,
        child: Text('Đổi mật khẩu'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formPwdKey,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Mật khẩu không được để trống';
                }
              },
              obscureText: true,
              style: const TextStyle(
                color: textColor,
              ),
              decoration: InputDecoration(
                labelText: 'Mật khẩu mới',
                labelStyle: const TextStyle(
                    color: textBoldColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: 'Nhập mật khẩu mới',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              cursorColor: textColor.withOpacity(.8),
              onSaved: (newValue) {
                newPassword = newValue!;
              },
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formConfirmKey,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Xác nhận mật khẩu không được để trống';
                }
                return null;
              },
              obscureText: true,
              style: const TextStyle(
                color: textColor,
              ),
              decoration: InputDecoration(
                labelText: 'Xác nhận mật khẩu',
                labelStyle: const TextStyle(
                    color: textBoldColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: 'Xác nhận mật khẩu mới',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              cursorColor: textColor.withOpacity(.8),
              onSaved: (newValue) {
                newPassword = newValue!;
              },
            ),
          ),
        ],
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              if (_formPwdKey.currentState!.validate() &&
                  _formConfirmKey.currentState!.validate()) {
                _formPwdKey.currentState!.save();
                _formConfirmKey.currentState!.save();
                //call api change pwd
              }
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 19, vertical: 10),
                foregroundColor: kPrimaryColor.withOpacity(.7),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                      color: kPrimaryColor.withOpacity(.5), width: 1),
                ),
                backgroundColor: kPrimaryColor),
            child: const Text(
              'Lưu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
