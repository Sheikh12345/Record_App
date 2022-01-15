import 'package:flutter/material.dart';
import 'package:record_app/model/payment_data_model.dart';
import 'package:record_app/model/record_model.dart';
import 'package:record_app/screens/history/single_payment_view.dart';
import 'package:record_app/screens/history/single_purchase_view.dart';

import '../../database_helper_payment.dart';
import '../edit_record.dart';

class ViewListPayment extends StatefulWidget {
  List<PaymentDataModel> list;
  ViewListPayment({Key? key, required this.list}) : super(key: key);

  @override
  _ViewListPaymentState createState() => _ViewListPaymentState();
}

class _ViewListPaymentState extends State<ViewListPayment> {
  List<PaymentDataModel> userFilers = [];

  @override
  void initState() {
    super.initState();
    print("length ${widget.list.length}");
    setState(() {
      userFilers = widget.list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff35858B),
        title: const Text("Payment history"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              top: size.height * 0.001,
            ),
            margin: EdgeInsets.only(
                top: size.height * 0.01, bottom: size.height * 0.01),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(2, 2),
                      blurRadius: 3),
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(-1, -1),
                      blurRadius: 3),
                ],
                borderRadius: BorderRadius.circular(size.width * 0.04)),
            width: size.width * 0.85,
            height: size.height * 0.049,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: size.height * 0.005),
                border: InputBorder.none,
                hintText: "Name, email, week score, phone #.",
                hintStyle: TextStyle(
                    fontSize: size.height * 0.022, color: Colors.grey),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (string) {
                setState(() {
                  userFilers = widget.list
                      .where((u) => (u.items!
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          u.type!
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          u.amount.toString().contains(string.toLowerCase()) ||
                          u.dateofPayment
                              .toString()
                              .toLowerCase()
                              .contains(string.toLowerCase())))
                      .toList();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: userFilers.length,
                itemBuilder: (context, index) {
                  return Container(
                      width: size.width,
                      height: size.height * 0.23,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(color: Colors.grey.shade900, blurRadius: 1)
                      ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Payment type: ",
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${userFilers.elementAt(index).type}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SinglePaymentView(
                                          columnId:  userFilers[index].id??0,
                                          dateOfPayment:  userFilers[index].dateofPayment,
                                          amount:  userFilers[index].amount??'',
                                          items:  userFilers[index].items??'',
                                          notes:  userFilers[index].notes??'',
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.green,
                                  ))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Amount: ",
                                style: TextStyle(color: Colors.grey.shade600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Expanded(
                                child: Text(
                                  "${userFilers.elementAt(index).amount}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Notes: ",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              Expanded(
                                child: Text(
                                  "${userFilers.elementAt(index).notes}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Date of Payment: ",
                                style: TextStyle(color: Colors.grey.shade600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Expanded(
                                child: Text(
                                  "${userFilers.elementAt(index).dateofPayment}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Items: ",
                                style: TextStyle(color: Colors.grey.shade600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Expanded(
                                child: Text(
                                  "${userFilers.elementAt(index).items}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  int value = await DatabaseHelperPayment
                                      .instance
                                      .delete(userFilers.elementAt(index).id!);
                                  print("Deleted $value");
                                  userFilers.removeAt(index);
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      ));
                }),
          ),
        ],
      ),
    ));
  }
}
