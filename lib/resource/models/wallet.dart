import 'package:washouse_customer/resource/models/transaction.dart';
import 'package:washouse_customer/resource/models/wallet_transaction.dart';

class Wallet {
  int? walletId;
  double? balance;
  String? status;
  List<WalletTransactions>? transactions;
  List<WalletTransactions>? walletTransactions;

  Wallet(
      {this.walletId,
      this.balance,
      this.status,
      this.transactions,
      this.walletTransactions});

  Wallet.fromJson(Map<String, dynamic> json) {
    walletId = json['walletId'];
    balance = json['balance'];
    status = json['status'];
    if (json['transactions'] != null) {
      transactions = <WalletTransactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new WalletTransactions.fromJson(v));
      });
    }
    if (json['walletTransactions'] != null) {
      walletTransactions = <WalletTransactions>[];
      json['walletTransactions'].forEach((v) {
        walletTransactions!.add(new WalletTransactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['walletId'] = this.walletId;
    data['balance'] = this.balance;
    data['status'] = this.status;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    if (this.walletTransactions != null) {
      data['walletTransactions'] =
          this.walletTransactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
