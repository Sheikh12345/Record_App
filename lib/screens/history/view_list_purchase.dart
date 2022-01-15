import 'package:flutter/material.dart';
import 'package:record_app/model/purchase_data_model.dart';
import 'package:record_app/model/record_model.dart';
import 'package:record_app/screens/history/single_purchase_view.dart';

import '../../database_helper_payment.dart';

class ViewListPurchase extends StatefulWidget {
  List<PurchaseDataModel> list;
  ViewListPurchase({Key? key, required this.list}) : super(key: key);

  @override
  _ViewListPurchaseState createState() => _ViewListPurchaseState();
}

class _ViewListPurchaseState extends State<ViewListPurchase> {
  List<PurchaseDataModel> userFilers = [];

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
        title: const Text("Purchase history"),
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
                hintText: "item name, customer, date of purchase ",
                hintStyle: TextStyle(
                    fontSize: size.height * 0.022, color: Colors.grey),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (string) {
                setState(() {
                  userFilers = widget.list
                      .where((u) => (u.name!
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          u.description!
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          u.price.toString().contains(string.toLowerCase()) ||
                          u.dateofpurchase
                              .toString()
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          u.customerName
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
                    height: size.height * 0.25,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                                  "Item name: ",
                                  style: TextStyle(color: Colors.grey.shade600),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: Text(
                                    "${userFilers.elementAt(index).name}",
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
                                      builder: (context) =>
                                          SinglePurchaseRecordView(
                                        price: userFilers[index].price,
                                        itemName: userFilers[index].name ?? '',
                                        desc:
                                            userFilers[index].description ?? '',
                                        columnId: userFilers[index].id ?? 0,
                                        customerName:
                                            userFilers[index].customerName ??
                                                '',
                                        dateOfPurchase:
                                            userFilers[index].dateofpurchase,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.green,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Item Price: ",
                              style: TextStyle(color: Colors.grey.shade600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(
                              child: Text(
                                userFilers.elementAt(index).price.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Item Desc: ",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            Expanded(
                              child: Text(
                                "${userFilers.elementAt(index).description}",
                                style: const TextStyle(
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
                              "Customer name: ",
                              style: TextStyle(color: Colors.grey.shade600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(
                              child: Text(
                                "${userFilers.elementAt(index).customerName}",
                                style: const TextStyle(
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
                              "Item: ",
                              style: TextStyle(color: Colors.grey.shade600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(
                              child: Text(
                                "${userFilers.elementAt(index).name}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Date of purchase: ",
                                  style: TextStyle(color: Colors.grey.shade600),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: Text(
                                    "${userFilers.elementAt(index).dateofpurchase}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () async {
                                int value = await DatabaseHelperPayment.instance
                                    .delete(userFilers.elementAt(index).id!);
                                print("Deleted $value");
                                userFilers.removeAt(index);
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }
}
