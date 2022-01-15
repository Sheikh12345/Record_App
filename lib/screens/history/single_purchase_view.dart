import 'package:flutter/material.dart';

class SinglePurchaseRecordView extends StatefulWidget {
  final String itemName;
  final String customerName;
  final String desc;
  final dynamic price;
  final dynamic dateOfPurchase;
  final int columnId;
  const SinglePurchaseRecordView(
      {Key? key,
      required this.itemName,
      required this.desc,
      required this.price,
      required this.customerName,
      required this.columnId, required this.dateOfPurchase})
      : super(key: key);

  @override
  _SinglePurchaseRecordViewState createState() => _SinglePurchaseRecordViewState();
}

class _SinglePurchaseRecordViewState extends State<SinglePurchaseRecordView> {
  final TextEditingController _controllerItem = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerDateOfPur = TextEditingController();
  final TextEditingController _controllerCustomerName = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerPrice.text = widget.price ?? "";
    _controllerDesc.text = widget.desc;
    _controllerItem.text = widget.itemName;
    _controllerCustomerName.text = widget.customerName;
    _controllerDateOfPur.text = widget.dateOfPurchase;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff35858B),
        title: const Text("Single Record"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            TextField(
              controller: _controllerItem,
              decoration: InputDecoration(labelText: "Item:"),
              minLines: 1,
              maxLines: 2,
            ),
            TextField(
              controller: _controllerCustomerName,
              decoration: InputDecoration(labelText: "Customer name:"),
              minLines: 1,
              maxLines: 2,
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controllerPrice,
              decoration: InputDecoration(labelText: "Price:"),
              minLines: 1,
              maxLines: 1,
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controllerDesc,
              decoration: InputDecoration(labelText: "Description:"),
              minLines: 1,
              maxLines: 5,
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controllerDateOfPur,
              decoration: InputDecoration(labelText: "Date of Purchase:"),
              maxLines: 1,
            ),
            SizedBox(
              height: 5,
            ),

          ],
        ),
      ),
    ));
  }
}
