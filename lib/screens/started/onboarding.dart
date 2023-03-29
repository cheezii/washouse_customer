import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/size.dart';
import 'package:washouse_customer/screens/started/login.dart';

import '../../components/constants/text_constants.dart';
import '../../resource/controller/center_controller.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  CenterController centerController = CenterController();
  int currentIndex = 0;

  @override
  void initState() {
    //centerController.getCenterListSearch('Dr');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leading: const SizedBox(child: Icon(Icons.arrow_back_ios)),
        title: Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 150,
            width: 150,
            child: Image.asset('assets/images/logo/logo_nocontent.png'),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: kDefaultPadding, top: kDefaultPadding),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                ); //vào trang login
              },
              child: const Text(
                'Bỏ qua',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: const [
              CreatePage(
                image: 'assets/images/logo/laundry_center.png',
                title: titleOne,
                desscription: descriptionOne,
              ),
              CreatePage(
                image: 'assets/images/logo/washouse-banner.png',
                title: titleTwo,
                desscription: descriptionTwo,
              ),
              CreatePage(
                image: 'assets/images/logo/onboarding-banner.png',
                title: titleThree,
                desscription: descriptionThree,
              ),
            ],
          ),
          Positioned(
            bottom: kDefaultPadding * 4,
            left: kDefaultPadding * 1.5,
            child: Row(
              children: _buildIndicator(),
            ),
          ),
          Positioned(
            bottom: kDefaultPadding * 3,
            right: kDefaultPadding * 1.5,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor,
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (currentIndex < 2) {
                      currentIndex++;
                      if (currentIndex < 3) {
                        _pageController.nextPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.easeIn);
                      }
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Login(),
                        ),
                      );
                    }
                  });
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: kDefaultPadding / 2,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}

class CreatePage extends StatelessWidget {
  final String image;
  final String title;
  final String desscription;

  const CreatePage({
    super.key,
    required this.image,
    required this.title,
    required this.desscription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            child: Image.asset(image),
          ),
          const SizedBox(height: kDefaultPadding),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          Text(
            desscription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
