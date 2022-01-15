class PurchaseDataModel {
  PurchaseDataModel({
    int? id,
    String? name,
    String? customerName,
    String? price,
    String? description,
    String? dateOfPurchase,
  }) {
    _id = id;
    _name = name;
    _price = price;
    _description = description;
    _dateofpurchase = dateOfPurchase;
  }

  PurchaseDataModel.fromJson(dynamic json) {
    _id = json['_id'];
    _customerName = json['customerName'];
    _name = json['name'];
    _price = json['price'];
    _description = json['description'];
    _dateofpurchase = json['dateofpurchase'];
  }
  int? _id;
  String? _name;
  String? _customerName;
  String? _price;
  String? _description;
  String? _dateofpurchase;

  int? get id => _id;
  String? get name => _name;
  String? get customerName => _customerName;
  String? get price => _price;
  String? get description => _description;
  String? get dateofpurchase => _dateofpurchase;
}
