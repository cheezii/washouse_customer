import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:washouse_customer/screens/profile/components/change_name_alertdialog.dart';
import 'package:washouse_customer/screens/profile/components/information_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../components/constants/color_constants.dart';

class InfomationScreen extends StatefulWidget {
  const InfomationScreen({super.key});

  @override
  State<InfomationScreen> createState() => _InfomationScreenState();
}

class _InfomationScreenState extends State<InfomationScreen> {
  TextEditingController dateController = TextEditingController();
  DateTime date = DateTime.now();
  String? gender;
  String genderDisplay = '- Chọn -';
  String? birthday;
  String birthdayDisplay = 'dd/MM/yyyy';

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dateController.text = '${date.day}/${date.month}/${date.year}';
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
            size: 24,
          ),
        ),
        centerTitle: true,
        title: const Text('Hồ sơ',
            style: TextStyle(color: textColor, fontSize: 25)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/profile/4.jpg'),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Đổi ảnh đại diện',
                          style: TextStyle(fontSize: 17))),
                ],
              ),
              Column(
                children: [
                  InformationWidget(
                      title: 'Họ và tên',
                      subTitle: 'Tên khách hàng',
                      canChange: true,
                      press: () {
                        showDialog(
                            context: context,
                            builder: ((context) =>
                                const ChangeNameAlertDialog()));
                      }),
                  InformationWidget(
                      title: 'Số điện thoại',
                      subTitle: '0328104356',
                      canChange: false,
                      press: () {}),
                  InformationWidget(
                      title: 'Email',
                      subTitle: 'tester01@gmail.com',
                      canChange: false,
                      press: () {}),
                  InformationWidget(
                      title: 'Giới tính',
                      subTitle: genderDisplay,
                      canChange: true,
                      press: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            builder: ((context) => StatefulBuilder(
                                  builder: (context, setState) => Container(
                                    height: 380,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: StatefulBuilder(
                                      builder: (context, setState) => Column(
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                  icon: const Icon(
                                                      Icons.close_rounded),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }),
                                              const SizedBox(width: 90),
                                              const Text(
                                                'Chọn giới tính',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                              thickness: 1,
                                              color: Colors.grey.shade300),
                                          const SizedBox(height: 10),
                                          ListTile(
                                            title: const Text('Nữ'),
                                            trailing: Radio<String>(
                                              value: 'Nữ',
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value;
                                                });
                                                this.setState(() {
                                                  genderDisplay =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: const Text('Nam'),
                                            trailing: Radio<String>(
                                              value: 'Nam',
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value;
                                                  genderDisplay =
                                                      value.toString();
                                                });
                                                this.setState(() {
                                                  genderDisplay =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: const Text('Khác'),
                                            trailing: Radio<String>(
                                              value: 'Khác',
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value;
                                                  genderDisplay =
                                                      value.toString();
                                                });
                                                this.setState(() {
                                                  genderDisplay =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 60),
                                          SizedBox(
                                            width: size.width,
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                //lưu gender sang
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  backgroundColor:
                                                      kPrimaryColor),
                                              child: const Text('Lưu',
                                                  style:
                                                      TextStyle(fontSize: 17)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )));
                      }),
                  InformationWidget(
                      title: 'Ngày sinh',
                      subTitle: birthdayDisplay,
                      canChange: true,
                      press: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          builder: ((context) => StatefulBuilder(
                                builder: (context, setState) => Container(
                                  height: 530,
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                              icon: const Icon(
                                                  Icons.close_rounded),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                          const SizedBox(width: 90),
                                          const Text(
                                            'Chọn ngày sinh',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                          thickness: 1,
                                          color: Colors.grey.shade300),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: dateController,
                                        readOnly: true,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 4),
                                        ),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: textColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 50),
                                      SizedBox(
                                        height: 250,
                                        child: CupertinoDatePicker(
                                            initialDateTime: date,
                                            use24hFormat: true,
                                            maximumDate: date,
                                            dateOrder: DatePickerDateOrder.dmy,
                                            mode: CupertinoDatePickerMode.date,
                                            backgroundColor: Colors.white,
                                            onDateTimeChanged:
                                                (DateTime newDate) {
                                              setState(() {
                                                dateController.text =
                                                    '${newDate.day}/${newDate.month}/${newDate.year}';
                                              });
                                            }),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: size.width,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            this.setState(() {
                                              birthdayDisplay =
                                                  dateController.text;
                                            });
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              backgroundColor: kPrimaryColor),
                                          child: const Text('Lưu',
                                              style: TextStyle(fontSize: 17)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
