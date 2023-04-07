import 'package:flutter/material.dart';
import 'package:washouse_customer/resource/controller/account_controller.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/models/wallet.dart';
import 'components/transaction_widget.dart';
import '../../../../utils/price_util.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  AccountController accountController = AccountController();
  bool isHidden = true;
  bool isHaveTransaction = true;
  bool isHaveWallet = false;
  Wallet? _wallet;

  Future<void> _loadData() async {
    final name =
        await baseController.getStringtoSharedPreference("CURRENT_USER_NAME");
  }

  void getMyWallet() async {
    Wallet? wallet = await accountController.getMyWallet();
    if (wallet != null) {
      setState(() {
        _wallet = wallet;
        isHaveWallet = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMyWallet();
  }

  @override
  Widget build(BuildContext context) {
    if (_wallet != null) {
      isHaveWallet = true;

      TransactionWidget(isAdd: true, time: '20/03/2023 13:23:21', price: 20000);
    }
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
          title: const Text('Ví của tôi',
              style: TextStyle(color: textColor, fontSize: 25)),
        ),
        body: isHaveWallet
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Số dư tài khoản',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isHidden = !isHidden;
                                  });
                                },
                                icon: Icon(
                                  isHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            isHidden
                                ? '******'
                                : '${PriceUtils().convertFormatPrice(_wallet!.balance!.round())} đ',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 250,
                                height: 100,
                                padding: new EdgeInsets.all(10.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Color.fromARGB(255, 27, 122, 199),
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Image.asset(
                                              'assets/images/transaction/wallet.png'),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          'Nạp tiền vào ví',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 300,
                                height: 100,
                                padding: const EdgeInsets.all(10.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Color.fromARGB(255, 175, 45, 35),
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(
                                          Icons.add_box_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Liên kết tài khoản VNPAY',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Lịch sử giao dịch',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      isHaveTransaction
                          ? Column(
                              children: [
                                TransactionWidget(
                                    isAdd: true,
                                    time: '20/03/2023 13:23:21',
                                    price: 20000),
                                TransactionWidget(
                                    isAdd: false,
                                    centerName: 'The Clean House',
                                    time: '20/03/2023 13:23:21',
                                    price: 20000),
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 90, horizontal: 80),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset(
                                        'assets/images/transaction/transaction-history.png'),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Bạn chưa có giao dịch nào',
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              )
            : Text(
                'Bạn chưa kích hoạt ví',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ));
  }
}
