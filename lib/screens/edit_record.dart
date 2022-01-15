import 'package:flutter/material.dart';
import 'package:record_app/custom_text_field.dart';

class EditRecordScreen extends StatefulWidget {
  final String itemName;
  final String desc;
  final dynamic price;
  final dynamic dateOfPur;
  final dynamic dateOfPayment;
  final int columnId;
  const EditRecordScreen(
      {Key? key,
      required this.itemName,
      required this.desc,
      required this.columnId,
      this.price,
      this.dateOfPur,
      this.dateOfPayment})
      : super(key: key);

  @override
  _EditRecordScreenState createState() => _EditRecordScreenState();
}

class _EditRecordScreenState extends State<EditRecordScreen> {
  final TextEditingController _controllerItem = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerDateOfPur = TextEditingController();
  final TextEditingController _controllerDateOfPayment =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerPrice.text = widget.price ?? "";
    _controllerDateOfPayment.text = widget.dateOfPayment ?? "";
    _controllerDateOfPur.text = widget.dateOfPur ?? "";
    _controllerDesc.text = widget.desc;
    _controllerItem.text = widget.itemName;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff35858B),
          title: const Text("Update record"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                controller: _controllerItem,
                labelText: "Item name",
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
              CustomTextField(
                controller: _controllerDateOfPayment,
                labelText: "Date of payment",
                textInputType: TextInputType.datetime,
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () async {
                  // int value = await DatabaseHelperPayment.instance.update({
                  //   DatabaseHelperPayment.columnName: _controllerItem.text,
                  //   DatabaseHelperPayment.columnPrice: _controllerPrice.text,
                  //   DatabaseHelperPayment.columnDesc: _controllerDesc.text,
                  //   DatabaseHelperPayment.columnDOPu: _controllerDateOfPur.text,
                  // }, widget.columnId);
                  //
                  // Future.delayed(Duration(milliseconds: 300), () async {
                  //   Navigator.pop(context);
                  //   Navigator.pop(context);
                  //   List<Map<String, dynamic>> map =
                  //       await DatabaseHelperPayment.instance.queryAll();
                  //
                  //   List<RecordModel> list = [];
                  //
                  //   for (int i = 0; i < map.length; i++) {
                  //     list.add(RecordModel.fromJson(map.elementAt(i)));
                  //   }
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>
                  //               ViewRecordScreen(list: list)));
                  //
                  //   ScaffoldMessenger.of(context)
                  //       .showSnackBar(SnackBar(content: const Text("Updated")));
                  // });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height * 0.065,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Color(0xff165055),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.05),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
