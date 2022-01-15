import 'package:flutter/material.dart';

class SinglePaymentView extends StatefulWidget {
  final String items;
  final String amount;
  final String notes;
  final dynamic dateOfPayment;
  final int columnId;
  const SinglePaymentView(
      {Key? key,
      required this.items,
      required this.notes,
      required this.amount,
      required this.columnId,
      required this.dateOfPayment})
      : super(key: key);

  @override
  _SinglePaymentViewState createState() => _SinglePaymentViewState();
}

class _SinglePaymentViewState extends State<SinglePaymentView> {
  final TextEditingController _controllerItem = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerDateOfPur = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerPrice.text = widget.amount;
    _controllerDesc.text = widget.notes;
    _controllerItem.text = widget.items;
    _controllerDateOfPur.text = widget.dateOfPayment;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff35858B),
          title: const Text("Payment"),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              TextField(
                controller: _controllerItem,
                decoration: InputDecoration(labelText: "Items: "),
                minLines: 1,
                maxLines: 3,
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controllerPrice,
                decoration: InputDecoration(labelText: "Amount: "),
                minLines: 1,
                maxLines: 1,
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controllerDesc,
                decoration: InputDecoration(labelText: "Notes: "),
                minLines: 1,
                maxLines: 5,
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controllerDateOfPur,
                decoration: InputDecoration(labelText: "Date of payment: "),
                maxLines: 1,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
