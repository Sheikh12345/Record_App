class PaymentDataModel {
  PaymentDataModel({
      int? id, 
      String? type,
    String? amount,
      String? notes, 
      String? dateofPayment, 
      String? items,}){
    _id = id;
    _type = type;
    _amount = amount;
    _notes = notes;
    _dateofPayment = dateofPayment;
    _items = items;
}

  PaymentDataModel.fromJson(dynamic json) {
    _id = json['_id'];
    _type = json['type'];
    _amount = json['amount'];
    _notes = json['notes'];
    _dateofPayment = json['dateofPayment'];
    _items = json['items'];
  }
  int? _id;
  String? _type;
  String? _amount;
  String? _notes;
  String? _dateofPayment;
  String? _items;

  int? get id => _id;
  String? get type => _type;
  String? get amount => _amount;
  String? get notes => _notes;
  String? get dateofPayment => _dateofPayment;
  String? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['type'] = _type;
    map['amount'] = _amount;
    map['notes'] = _notes;
    map['dateofPayment'] = _dateofPayment;
    map['items'] = _items;
    return map;
  }

}