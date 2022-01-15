import 'package:flutter/material.dart';
import 'package:record_app/custom_text_field.dart';
import 'package:record_app/database_helper_payment.dart';
import 'package:record_app/model/payment_data_model.dart';
import 'package:record_app/model/purchase_data_model.dart';
import 'package:record_app/screens/history/view_list_payment.dart';
import 'package:record_app/screens/history/view_list_purchase.dart';
import '../database_helper_purchase.dart';
import 'custom_dialog_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controllerItem = TextEditingController();
  final TextEditingController _contCustomerName = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerDateOfPur = TextEditingController();

  final TextEditingController _controllerAmount = TextEditingController();
  final TextEditingController _controllerNote = TextEditingController();
  final TextEditingController _contDateOfPayment = TextEditingController();

  String? type;
  String? paymentType;

  addData(BuildContext context) async {
    if (type == 'Purchase') {
      int value = await DatabaseHelperPurchase.instance.insert({
        DatabaseHelperPurchase.columnName: _controllerItem.text,
        DatabaseHelperPurchase.columnCustomerName: _contCustomerName.text,
        DatabaseHelperPurchase.columnPrice: _controllerPrice.text,
        DatabaseHelperPurchase.columnDesc: _controllerDesc.text,
        DatabaseHelperPurchase.columnDOPu: _controllerDateOfPur.text,
      });

      print("Result => $value");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Added")));
      _controllerItem.clear();
      _contCustomerName.clear();
      _controllerDesc.clear();
      _controllerPrice.clear();
      _controllerDateOfPur.clear();
      List<Map<String, dynamic>> map =
          await DatabaseHelperPurchase.instance.queryAll();
      print("Saving purchase => $map");
    } else if (type == 'Payment') {
      if (paymentType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please select payment type")));
        return;
      } else if (selectedItems.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Select some items")));
        return;
      }
      String items = '';
      for (int i = 0; i < selectedItems.length; i++) {
        items = items + selectedItems[i] + ", ";
      }

      int value = await DatabaseHelperPayment.instance.insert({
        DatabaseHelperPayment.columnType: paymentType,
        DatabaseHelperPayment.columnAmount: _controllerAmount.text,
        DatabaseHelperPayment.columnNotes: _controllerNote.text,
        DatabaseHelperPayment.columnDOPa: _contDateOfPayment.text,
        DatabaseHelperPayment.columnItems: items,
      });

      print("Result => $value");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Added")));
      paymentType = null;
      selectedItems = [];
      _controllerAmount.clear();
      _controllerNote.clear();
      _controllerPrice.clear();
      _contDateOfPayment.clear();
      setState(() {});
      List<Map<String, dynamic>> map =
          await DatabaseHelperPayment.instance.queryAll();
      print("Saving payment => $map");
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please select type")));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff35858B),
          title: const Text("Ledger App"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: DropdownButton<String>(
                  value: type,
                  isExpanded: true,
                  hint: const Text(
                    "Select type",
                  ),
                  items: <String>["Purchase", "Payment"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                ),
              ),
              if (type == 'Purchase') itemOptions(context, size),
              if (type == 'Payment') itemPayment(context, size),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  addData(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height * 0.065,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xff165055),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'Add',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.05),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  List<Map<String, dynamic>> map =
                      await DatabaseHelperPayment.instance.queryAll();

                  List<PaymentDataModel> listOfPurchase = [];

                  print(map);
                  for (int i = 0; i < map.length; i++) {
                    listOfPurchase
                        .add(PaymentDataModel.fromJson(map.elementAt(i)));
                  }

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewListPayment(list: listOfPurchase)));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height * 0.065,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xff165055),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'View Payments history',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.05),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  List<Map<String, dynamic>> map =
                      await DatabaseHelperPurchase.instance.queryAll();

                  List<PurchaseDataModel> listOfPurchase = [];

                  print(map);
                  for (int i = 0; i < map.length; i++) {
                    listOfPurchase
                        .add(PurchaseDataModel.fromJson(map.elementAt(i)));
                  }

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewListPurchase(list: listOfPurchase)));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height * 0.065,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xff165055),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'View Purchases history',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.05),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  itemOptions(BuildContext context, Size size) {
    return Column(
      children: [
        Text(
          'Item options',
          style: TextStyle(
              fontSize: size.width * 0.05, fontWeight: FontWeight.w700),
        ),
        CustomTextField(
          controller: _controllerItem,
          labelText: "Item name",
          textInputType: TextInputType.text,
        ),
        CustomTextField(
          controller: _contCustomerName,
          labelText: "Customer name",
          textInputType: TextInputType.text,
        ),
        CustomTextField(
          controller: _controllerPrice,
          labelText: "Price",
          textInputType: TextInputType.number,
        ),
        CustomTextField(
          controller: _controllerDesc,
          labelText: "Description",
          textInputType: TextInputType.text,
        ),
        CustomTextField(
          controller: _controllerDateOfPur,
          labelText: "Date of purchase",
          textInputType: TextInputType.datetime,
        ),
      ],
    );
  }

  itemPayment(BuildContext context, Size size) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Payment options",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: size.width * 0.05),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: DropdownButton<String>(
            value: paymentType,
            isExpanded: true,
            hint: const Text(
              "Select payment type",
            ),
            items: <String>["Credit card", "Cash"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                paymentType = value;
              });
            },
          ),
        ),
        CustomTextField(
          controller: _controllerAmount,
          labelText: "Amount",
          textInputType: TextInputType.datetime,
        ),
        SizedBox(
          height: size.height * 0.002,
        ),
        CustomTextField(
          controller: _controllerNote,
          labelText: "Notes",
          textInputType: TextInputType.datetime,
        ),
        SizedBox(
          height: size.height * 0.002,
        ),
        CustomTextField(
          controller: _contDateOfPayment,
          labelText: "Date of payment",
          textInputType: TextInputType.datetime,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        InkWell(
          onTap: () async {
            showCustomDialog(context);
          },
          child: Container(
            alignment: Alignment.center,
            width: size.width,
            height: size.height * 0.065,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: const Color(0xff165055),
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              'Select items',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.05),
            ),
          ),
        ),
      ],
    );
  }

  showCustomDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => CustomDialogBox());
  }
}
