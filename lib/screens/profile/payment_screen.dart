import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/resource/controller/account_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import 'package:washouse_customer/resource/models/transaction_history.dart';
import 'package:washouse_customer/resource/models/wallet_transaction.dart';
import '../../components/constants/color_constants.dart';
import '../../resource/controller/payment_controller.dart';
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
  BaseController baseController = BaseController();
  PaymentController paymentController = PaymentController();
  bool isHidden = true;
  bool isHaveTransaction = true;
  bool isHaveWallet = false;
  Wallet? _wallet;
  List<WalletTransactions> listTransaction = [];
  List<WalletTransactions> listWalletTransaction = [];
  List<WalletTransactions> newTransList = [];
  bool isLoading = false;

  Future<void> _loadData() async {
    final name = await baseController.getStringtoSharedPreference("CURRENT_USER_NAME");
  }

  void getMyWallet() async {
    setState(() {
      isLoading = true;
    });

    try {
      Wallet? wallet = await accountController.getMyWallet();
      if (wallet != null) {
        setState(() {
          _wallet = wallet;
          listTransaction = wallet.transactions!;
          listWalletTransaction = wallet.walletTransactions!;
          newTransList = listTransaction + listWalletTransaction;
          isHaveWallet = true;
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
      print('Error loading wwallet: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getMyWallet();
  }

  final _formKey = GlobalKey<FormState>();
  late int _value;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    } else {
      if (_wallet != null) {
        isHaveWallet = true;
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
            title: const Text('Ví của tôi', style: TextStyle(color: textColor, fontSize: 25)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              isHidden ? Icons.visibility : Icons.visibility_off,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        isHidden ? '******' : '${PriceUtils().convertFormatPrice(_wallet!.balance!.round())} đ',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  isHaveWallet
                      ? GestureDetector(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Số tiền'),
                                    content: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        autofocus: true,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Hãy nhập số tiền cần nạp vào tài khoản';
                                          }
                                          final numberValue = double.tryParse(value);
                                          if (numberValue == null || numberValue < 10000) {
                                            return 'Số tiền nạp vào tài khoản tối thiểu 10.000 đồng';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _value = int.parse(value!);
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Nhập số tiền nạp vào ví',
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Hủy bỏ'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text('Tiếp tục'),
                                        onPressed: () async {
                                          if (_formKey.currentState!.validate()) {
                                            _formKey.currentState!.save();
                                            String url = await paymentController.lauchVnpayLink(_value);

                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                            Navigator.of(context).pop(_value);
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
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
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset('assets/images/transaction/wallet.png'),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Nạp tiền vào ví',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {},
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
                                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ),
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
                  isHaveWallet
                      ? isHaveTransaction
                          ? ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 16),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: newTransList.length,
                              itemBuilder: (context, index) {
                                newTransList.sort((a, b) {
                                  DateTime aDate = DateFormat('dd-MM-yyyy HH:mm:ss').parse(a.timeStamp!);
                                  DateTime bDate = DateFormat('dd-MM-yyyy HH:mm:ss').parse(b.timeStamp!);
                                  return bDate.compareTo(aDate);
                                });
                                return TransactionWidget(
                                  isAdd: newTransList[index].plusOrMinus!.toLowerCase(),
                                  time: newTransList[index].timeStamp!,
                                  price: newTransList[index].amount!,
                                );
                              })
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 80),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset('assets/images/transaction/transaction-history.png'),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Bạn chưa có giao dịch nào',
                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 18, fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 80),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset('assets/images/transaction/transaction-history.png'),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Bạn chưa có giao dịch nào',
                                style: TextStyle(color: Colors.grey.shade500, fontSize: 18, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          )
          // Column(
          //     children: [
          //       Center(
          //         child: Text(
          //           'Bạn chưa kích hoạt ví',
          //           style: TextStyle(
          //               color: Colors.grey.shade600,
          //               fontSize: 18,
          //               fontWeight: FontWeight.w500),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () async {},
          //         child: Container(
          //           width: 300,
          //           height: 100,
          //           padding: const EdgeInsets.all(10.0),
          //           child: Card(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15.0),
          //             ),
          //             color: Color.fromARGB(255, 175, 45, 35),
          //             elevation: 10,
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 10),
          //               child: Row(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: const [
          //                   Icon(
          //                     Icons.add_box_rounded,
          //                     color: Colors.white,
          //                     size: 30,
          //                   ),
          //                   SizedBox(width: 10),
          //                   Text(
          //                     'Liên kết tài khoản VNPAY',
          //                     style: TextStyle(
          //                         color: Colors.white,
          //                         fontWeight: FontWeight.w600),
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          );
    }
  }
}
