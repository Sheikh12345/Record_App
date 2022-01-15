import 'package:flutter/material.dart';
import 'package:record_app/database_helper_purchase.dart';
import 'package:record_app/model/purchase_data_model.dart';
import 'package:record_app/screens/history/single_purchase_view.dart';

import '../database_helper_payment.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox({Key? key}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

List<String> selectedItems = [];

class _CustomDialogBoxState extends State<CustomDialogBox> {
  List<PurchaseDataModel> listOfPurchase = [];
  List<PurchaseDataModel> userFilers = [];

  fetchPurchaseFromDatabase() async {
    List<Map<String, dynamic>> map =
        await DatabaseHelperPurchase.instance.queryAll();
    print(map);
    for (int i = 0; i < map.length; i++) {
      listOfPurchase.add(PurchaseDataModel.fromJson(map.elementAt(i)));
    }
    setState(() {
      print("Fetching data ${listOfPurchase.length}");
    });
  }

  @override
  void initState() {
    fetchPurchaseFromDatabase();
    userFilers = listOfPurchase;
    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: size.width * 0.9,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: size.height,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
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
                  hintText: "Customer, item, date",
                  hintStyle: TextStyle(
                      fontSize: size.height * 0.022, color: Colors.grey),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (string) {
                  setState(() {
                    userFilers = listOfPurchase
                        .where((u) => (u.name!
                                .toLowerCase()
                                .contains(string.toLowerCase()) ||
                            u.description!
                                .toLowerCase()
                                .contains(string.toLowerCase()) ||
                            u.price.toString().contains(string.toLowerCase()) ||
                            u.customerName
                                .toString()
                                .toLowerCase()
                                .contains(string.toLowerCase()) ||
                            u.dateofpurchase
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 4),
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
                                      "Customer name: ",
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${userFilers.elementAt(index).customerName}",
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
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => SingleRecordView(
                                      //       columnId: userFilers[index].id!,
                                      //       desc: userFilers[index].description!,
                                      //       itemName: userFilers[index].name!,
                                      //       dateOfPayment:
                                      //       userFilers[index].dateOfPayment,
                                      //       dateOfPur:
                                      //       userFilers[index].dateOfPurchase,
                                      //       price: userFilers[index].price,
                                      //     ),
                                      //   ),
                                      // );
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
                                    "${userFilers.elementAt(index).price.toString()}",
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
                                  "Item Desc: ",
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                Expanded(
                                  child: Text(
                                    "${userFilers.elementAt(index).description}",
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
                                  "Date of Purchase: ",
                                  style: TextStyle(color: Colors.grey.shade600),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: Text(
                                    "${userFilers.elementAt(index).dateofpurchase}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Checkbox(
                                    value: selectedItems.any((element) =>
                                        element ==
                                        userFilers.elementAt(index).name),
                                    onChanged: (value) {
                                      if (selectedItems.any((element) =>
                                          element ==
                                          userFilers.elementAt(index).name)) {
                                        selectedItems.remove(
                                            userFilers.elementAt(index).name);
                                      } else {
                                        selectedItems.add(
                                            userFilers.elementAt(index).name ??
                                                '');
                                      }
                                      setState(() {});
                                    })
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     IconButton(
                            //       onPressed: () async {
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) => EditRecordScreen(
                            //               columnId: userFilers[index].id!,
                            //               desc: userFilers[index].description!,
                            //               itemName: userFilers[index].name!,
                            //               dateOfPayment:
                            //               userFilers[index].dateOfPayment,
                            //               dateOfPur:
                            //               userFilers[index].dateOfPurchase,
                            //               price: userFilers[index].price,
                            //             ),
                            //           ),
                            //         );
                            //
                            //         List<Map<String, dynamic>> map =
                            //         await DatabaseHelperPayment.instance
                            //             .queryAll();
                            //
                            //         widget.list = [];
                            //
                            //         for (int i = 0; i < map.length; i++) {
                            //           widget.list.add(
                            //               RecordModel.fromJson(map.elementAt(i)));
                            //         }
                            //
                            //         Future.delayed(
                            //             const Duration(milliseconds: 300), () {
                            //           setState(() {});
                            //         });
                            //       },
                            //       icon: const Icon(
                            //         Icons.edit,
                            //         color: Colors.blue,
                            //       ),
                            //     ),
                            //     IconButton(
                            //       onPressed: () async {
                            //         int value = await DatabaseHelperPayment
                            //             .instance
                            //             .delete(userFilers.elementAt(index).id!);
                            //         print("Deleted $value");
                            //         userFilers.removeAt(index);
                            //         setState(() {});
                            //       },
                            //       icon: Icon(
                            //         Icons.delete,
                            //         color: Colors.red,
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        ));
                  }),
            ),
            InkWell(
              onTap: () async {
                Navigator.pop(context);
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
                  'Done',
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
    ));
  }
}
