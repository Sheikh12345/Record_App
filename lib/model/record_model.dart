class RecordModel {
  RecordModel({
    int? id,
    String? name,
    dynamic price,
    String? description,
    dynamic dateOfPayment,
    dynamic dateOfPurchase,
  }) {
    _id = id;
    _name = name;
    _price = price;
    _description = description;
    _dateofPayment = dateOfPayment;
    _dateofpurchase = dateOfPurchase;
  }

  RecordModel.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _price = json['price'];
    _description = json['description'];
    _dateofPayment = json['dateofPayment'];
    _dateofpurchase = json['dateofpurchase'];
  }
  int? _id;
  String? _name;
  dynamic _price;
  String? _description;
  dynamic _dateofPayment;
  dynamic _dateofpurchase;

  int? get id => _id;
  String? get name => _name;
  dynamic get price => _price;
  String? get description => _description;
  dynamic get dateOfPayment => _dateofPayment;
  dynamic get dateOfPurchase => _dateofpurchase;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['description'] = _description;
    map['dateofPayment'] = _dateofPayment;
    map['dateofpurchase'] = _dateofpurchase;
    return map;
  }
}
