class TransactionHistory {
  int? paymentId;
  String? type;
  String? status;
  String? plusOrMinus;
  int? amount;
  String? timeStamp;

  TransactionHistory(
      {this.paymentId,
      this.type,
      this.status,
      this.plusOrMinus,
      this.amount,
      this.timeStamp});

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    paymentId = json['paymentId'];
    type = json['type'];
    status = json['status'];
    plusOrMinus = json['plusOrMinus'];
    amount = json['amount'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentId'] = this.paymentId;
    data['type'] = this.type;
    data['status'] = this.status;
    data['plusOrMinus'] = this.plusOrMinus;
    data['amount'] = this.amount;
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}
