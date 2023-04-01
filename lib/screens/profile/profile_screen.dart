import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/size.dart';
import 'package:washouse_customer/screens/started/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../../resource/controller/base_controller.dart';
import 'components/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

BaseController baseController = BaseController();

class _ProfileScreenState extends State<ProfileScreen> {
  late String _currentUserName;
  late String _currentUserEmail;
  String? _currentUserAvartar;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final name =
        await baseController.getStringtoSharedPreference("CURRENT_USER_NAME");
    final email =
        await baseController.getStringtoSharedPreference("CURRENT_USER_EMAIL");
    final avatar =
        await baseController.getStringtoSharedPreference("CURRENT_USER_AVATAR");
    setState(() {
      _currentUserName = name != "" ? name : "Undentified Name";
      _currentUserEmail = email != "" ? email : "Undentified Email";
      _currentUserAvartar = avatar != ""
          ? avatar
          : "https://storage.googleapis.com/washousebucket/anonymous-20230330210147.jpg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=washouse-sa%40washouse-381309.iam.gserviceaccount.com%2F20230330%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20230330T210148Z&X-Goog-Expires=1800&X-Goog-SignedHeaders=host&X-Goog-Signature=7c813f26489c9ba06cdfff27db9faa2ca4d7c046766aeb3874fdf86ec7c91ae904951f7b2617b6e78598d46f8b91d842d2f4c2a10696539bcf09c839d51d9565831f6c503b3e37f899ab8920f69c3aaa30e0ff2d9c598d1a4c523c1e8038520a32fe49a92c4448c49e602b77312444fe3505afa30da1c4bfbdf0f7a5ab9f2783005c1f3624b3417e17c0067f65f4c02fd03bbe9a0eed8390b56aa2b78a34ca88b52bbce7e1d364dc24e6650a68954e36439102f19a3b332fcb1562260d5223db1e09748eee5d7e6b0cba62dc7cfda9e1e00690f334b9e4b85c710ed77dee42759b48f98df0f05e1adf686351f6232a7d157c9f988248af0c69ec64af0cdbe247";
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 18, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Tài khoản',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      color: textColor,
                      size: 30.0,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: kPrimaryColor.withOpacity(.5),
                          width: 5.0,
                        ),
                      ),
                      // child: CircleAvatar(
                      //   radius: 60,
                      //   backgroundColor: Colors.grey,
                      //   //backgroundImage: ExactAssetImage('assets/images/profile/anonymous.jpg'),
                      //   backgroundImage: NetworkImage(_currentUserAvartar),
                      // ),
                      //   child: FutureBuilder<ImageProvider<Object>>(
                      //     future: _loadImage(),
                      //     builder: (BuildContext context,
                      //         AsyncSnapshot<ImageProvider<Object>> snapshot) {
                      //       if (snapshot.connectionState == ConnectionState.done &&
                      //           snapshot.hasData) {
                      //         return CircleAvatar(
                      //           radius: 60,
                      //           backgroundColor: Colors.grey,
                      //           backgroundImage: snapshot.data,
                      //         );
                      //       } else {
                      //         return CircleAvatar(
                      //           radius: 60,
                      //           backgroundColor: Colors.grey,
                      //           backgroundImage: ExactAssetImage(
                      //               'assets/images/profile/anonymous.jpg'),
                      //         );
                      //       }
                      //     },
                      //   ),
                      // ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey,
                        //backgroundImage: ExactAssetImage('assets/images/profile/anonymous.jpg'),
                        backgroundImage:
                            NetworkImage(_currentUserAvartar ?? ""),
                      )),
                  const SizedBox(height: 10),
                  Text(
                    '$_currentUserName',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '$_currentUserEmail',
                    style: TextStyle(
                      color: textColor.withOpacity(.5),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: size.height * .7,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileWidget(
                          icon: Icons.person,
                          title: 'Hồ sơ của tôi',
                          txtColor: textColor,
                          iconColor: textColor,
                          press: () {},
                        ),
                        ProfileWidget(
                          icon: Icons.feedback_rounded,
                          title: 'Đánh giá',
                          txtColor: textColor,
                          iconColor: textColor,
                          press: () {},
                        ),
                        ProfileWidget(
                          icon: Icons.help_rounded,
                          title: 'Trung tâm hỗ trợ',
                          txtColor: textColor,
                          iconColor: textColor,
                          press: () {},
                        ),
                        ProfileWidget(
                          icon: Icons.info_outline_rounded,
                          title: 'Về chúng tôi',
                          txtColor: textColor,
                          iconColor: textColor,
                          press: () {},
                        ),
                        ProfileWidget(
                          icon: Icons.logout_rounded,
                          title: 'Đăng xuất',
                          txtColor: Colors.red,
                          iconColor: Colors.red,
                          press: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: const Login(),
                                    type: PageTransitionType.fade));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
