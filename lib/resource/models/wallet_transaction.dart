class WalletTransactions {
  int? paymentId;
  String? type;
  String? status;
  String? plusOrMinus;
  double? amount;
  String? timeStamp;
  Null? updateTimeStamp;

  WalletTransactions(
      {this.paymentId,
      this.type,
      this.status,
      this.plusOrMinus,
      this.amount,
      this.timeStamp,
      this.updateTimeStamp});

  WalletTransactions.fromJson(Map<String, dynamic> json) {
    paymentId = json['paymentId'];
    type = json['type'];
    status = json['status'];
    plusOrMinus = json['plusOrMinus'];
    amount = json['amount'];
    timeStamp = json['timeStamp'];
    updateTimeStamp = json['updateTimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentId'] = this.paymentId;
    data['type'] = this.type;
    data['status'] = this.status;
    data['plusOrMinus'] = this.plusOrMinus;
    data['amount'] = this.amount;
    data['timeStamp'] = this.timeStamp;
    data['updateTimeStamp'] = this.updateTimeStamp;
    return data;
  }
}
