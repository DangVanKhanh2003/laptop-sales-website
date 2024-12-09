class Stat {
  int? date;
  int? amount;
  double? money;

  Stat({this.date, this.amount, this.money});

  Stat.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
    money = json['money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['amount'] = amount;
    data['money'] = money;
    return data;
  }
}
