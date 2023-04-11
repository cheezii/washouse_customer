class Transactions {
  String? type;
  String? status;
  String? plusOrMinus;
  double? amount;
  String? timeStamp;

  Transactions({this.type, this.status, this.plusOrMinus, this.amount, this.timeStamp});

  Transactions.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    status = json['status'];
    plusOrMinus = json['plusOrMinus'];
    amount = json['amount'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['status'] = this.status;
    data['plusOrMinus'] = this.plusOrMinus;
    data['amount'] = this.amount;
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}
