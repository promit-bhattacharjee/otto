import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../../Colours.dart';
import '../appBar.dart';

class UserCart extends StatefulWidget {
  UserCart({Key? key}) : super(key: key);
  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  bool clicker = true;
  TextEditingController totalPrice = TextEditingController();
  TextEditingController foodTag = TextEditingController();
  bool ifTableSelected = false;
  late String tableNumber = 'Not Selected';
  //late int? indexOflabels;
  late String UserId = authReference.currentUser!.uid.toLowerCase().toString();
  bool table1 = false, table2 = false, table3 = false;
  @override
  // void dispose() {
  //   totalPrice.dispose();
  //   super.dispose();
  // }

  @override
  initState() {
    foodTag.clear();
    super.initState();
    totalPriceAdder();
  }

  Future addQuntity(DataSnapshot snapshort) async {
    clicker = false;
    int b = int.parse(await snapshort.children.elementAt(0).value.toString());
    b++;
    await databaseReference
        .child('UserCart')
        .child(UserId)
        .child('${snapshort.key.toString()}')
        .child(snapshort.children.elementAt(0).key.toString())
        .set(b)
        .whenComplete(() async => await databaseReference
                .child('UserCart')
                .child(UserId)
                .child('${snapshort.key.toString()}')
                .update({
              'TotalFoodPrice': int.parse(
                      snapshort.children.elementAt(6).value.toString()) +
                  int.parse(snapshort.children.elementAt(4).value.toString()),
            }))
        .whenComplete(() => totalPriceAdder());
  }

  Future subQuntity(DataSnapshot snapshort) async {
    clicker = false;
    int b = int.parse(snapshort.children.elementAt(0).value.toString());
    b--;
    if (b <= 0) {
      await databaseReference
          .child('UserCart')
          .child(UserId)
          .child('${snapshort.key.toString()}')
          .remove()
          .whenComplete(() {
        setState(() {
          totalPriceAdder();
        });
      });
    } else {
      print(snapshort.key);
      await databaseReference
          .child('UserCart')
          .child(UserId)
          .child('${snapshort.key.toString()}')
          .child(snapshort.children.elementAt(0).key.toString())
          .set(b)
          .whenComplete(() => databaseReference
                  .child('UserCart')
                  .child(UserId)
                  .child('${snapshort.key.toString()}')
                  .update({
                'TotalFoodPrice': int.parse(
                        snapshort.children.elementAt(6).value.toString()) -
                    int.parse(snapshort.children.elementAt(4).value.toString()),
              }))
          .whenComplete(() => totalPriceAdder());
    }
  }

  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(int.parse(Colours.bodyColours)),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Container(
            height: 50,
            child: appBar(),
          ),
        ),
        body: Container(
          child: FirebaseAnimatedList(
              query: databaseReference.child('UserCart').child(this.UserId),
              itemBuilder: (context, snapshort, animation, index) {
                String foodName =
                    snapshort.children.elementAt(1).value.toString();
                int foodPrice = int.parse(
                    snapshort.children.elementAt(4).value.toString());
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Text(foodName),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Row(children: [
                              IconButton(
                                onPressed: clicker == true
                                    ? () {
                                        setState(() {
                                          subQuntity(snapshort);
                                        });
                                      }
                                    : null,
                                icon: Icon(Icons.remove),
                              ),
                              Text(snapshort.children
                                  .elementAt(0)
                                  .value
                                  .toString()),
                              IconButton(
                                onPressed: clicker == true
                                    ? () {
                                        setState(() {
                                          addQuntity(snapshort);
                                        });
                                      }
                                    : null,
                                icon: Icon(Icons.add),
                              ),
                            ]),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Text('$foodPrice'),
                          ))
                    ],
                  ),
                );
              }),
        ),
        bottomNavigationBar: Builder(
            builder: (context) => Container(
                  height: 180,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                          style: BorderStyle.solid,
                        )),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(' Select Table'),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        table1 == false
                                            ? Container(
                                          margin: EdgeInsets.all(5),
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(10)),
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .white)),
                                                    onPressed:
                                                        ifTableSelected ==
                                                                false
                                                            ? () {
                                                                setState(
                                                                    () {
                                                                  tableNumber =
                                                                      '1';
                                                                  table2 =
                                                                      !table2;
                                                                  table3 =
                                                                      !table3;
                                                                });
                                                              }
                                                            : () {
                                                                setState(
                                                                    () {
                                                                  tableNumber =
                                                                      'Not Selected';
                                                                  table2 =
                                                                      !table2;
                                                                  table3 =
                                                                      !table3;
                                                                });
                                                              },
                                                    child: Text('Table 1',style: TextStyle(color: Colors.black),)),
                                              )
                                            : Container(),
                                        table2 == false
                                            ? Container(
                                            margin: EdgeInsets.all(5),

                                            clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(10)),
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .white)),
                                                    onPressed:
                                                        ifTableSelected ==
                                                                false
                                                            ? () {
                                                                setState(
                                                                    () {
                                                                  tableNumber =
                                                                      '2';
                                                                  table1 =
                                                                      !table1;
                                                                  table3 =
                                                                      !table3;
                                                                });
                                                              }
                                                            : () {
                                                                setState(
                                                                    () {
                                                                  tableNumber =
                                                                      'Not Selected';
                                                                  table1 =
                                                                      !table1;
                                                                  table3 =
                                                                      !table3;
                                                                });
                                                              },
                                                    child: Text('Table 2',style: TextStyle(color: Colors.black),
                                              )))
                                            : Container(),
                                        table3 == false
                                            ? Container(
                                          margin: EdgeInsets.all(5),

                                          clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(10)),
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .white)),
                                                    onPressed:
                                                        ifTableSelected ==
                                                                false
                                                            ? () {
                                                                setState(
                                                                    () {
                                                                  tableNumber =
                                                                      '3';
                                                                  table2 =
                                                                      !table2;
                                                                  table1 =
                                                                      !table1;
                                                                });
                                                              }
                                                            : () {
                                                                setState(
                                                                    () {
                                                                  tableNumber =
                                                                      'Not Selected';
                                                                  table2 =
                                                                      !table2;
                                                                  table1 =
                                                                      !table1;
                                                                });
                                                              },
                                                    child: Text('Table 3',style: TextStyle(color: Colors.black))),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    child: Text(
                                      'Total Price',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: 70,
                                      height: 50,
                                      child: TextField(
                                        decoration: null,
                                        enabled: false,
                                        controller: totalPrice,
                                      ))
                                ],
                              ),
                            ]),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*.5,
                        height: 40,
                        child: ElevatedButton(
                          style: table1 == true ||
                              table2 == true ||
                              table3 == true?ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)):ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey)),
                          onPressed: table1 == true ||
                                  table2 == true ||
                                  table3 == true
                              ? () {
                                  setState(() {
                                    ifTableSelected = !ifTableSelected;
                                    ConfirmOrder();
                                  });
                                }
                              : null,
                          child: Text('Place Order',style: TextStyle(color: Colors.black),),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text('Email : ' +
                            authReference.currentUser!.email.toString()),
                      )
                    ],
                  ),
                )));
  }
  bool isPaymentDone = false;
  bool isSnackbarActive = false;
  FirebaseAuth authReference = FirebaseAuth.instance;
  totalPriceAdder() {
    int price = 0;
    setState(() {
      databaseReference
          .child('UserCart')
          .child(authReference.currentUser!.uid.toLowerCase().toString())
          .get()
          .then((snapshot) {
        snapshot.children.forEach((element) {
          element.children.forEach((element2) {
            print(element2.key.toString());
            if (element2.key.toString().contains('TotalFoodPrice') == true) {
              if (price == 0 || totalPrice == null) {
                price = int.parse(element2.value.toString());
              } else if (price != null) {
                price = price + int.parse(element2.value.toString());
              }
            }
          });
        });
      }).whenComplete(() {
        setState(() {
          totalPrice.clear();
          clicker = true;
          totalPrice.text = price.toString();
        });
      });
    });
  }

  ConfirmOrder() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        width: 400,
        height: 400,
        child: Column(
          children: [
            Container(
                width: 250,
                height: 250,
                child: Image.asset('Images/Bkash.jpeg')),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: paymentIdCnt,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Payment ID',
                    labelStyle: TextStyle(color: Colors.white)),
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty == true) {
                      isConfirm = !isConfirm;
                    }
                    // paymentIdCnt.text=value;
                  });
                },
              ),
            ),
            Container(
                alignment: FractionalOffset.bottomCenter,
                width: 160,
                height: 40,
                child: ElevatedButton.icon(
                    onPressed: isConfirm == false
                        ? () {
                            setState(() {
                              payOrder();
                            });
                            ScaffoldMessenger.of(context)
                                .hideCurrentSnackBar();
                          }
                        : null,
                    icon: Icon(Icons.send),
                    label: Text('Confirm')))
          ],
        ),
      ),
      duration: Duration(minutes: 5),
    ));
  }

  bool isConfirm = false;
  TextEditingController paymentIdCnt = TextEditingController();
  payOrder() {
    databaseReference
        .child('UserCart')
        .child(UserId)
        .get()
        .then((value) => value.children.forEach((element) {
              element.children.forEach((element2) {
                if ((element2.key.toString().compareTo('OrderState') == 0)) {
                  databaseReference
                      .child('UserCart')
                      .child(UserId)
                      .child(element.key.toString())
                      .update({
                    'OrderState': 'Paid',
                    'TableNumber': tableNumber,
                    'PaymentID': paymentIdCnt.text.trim(),
                  });
                }
              });
            }))
        .whenComplete(() {
      databaseReference.child('UserCart').child(UserId).get().then((value) {
        value.children.forEach((element) {
          // Names.add(element.children.elementAt(1).value.toString());
          // Map dataMap = element.value as Map;
          // dataMap['key']=element.key;
          // print(element.key);
          databaseReference
              .child('PaidOrder')
              .child(value.key.toString())
              .update({
            element.key.toString():element.value
          }).whenComplete(
                  () => databaseReference
                      .child('UserCart')
                      .child(UserId)
                      .remove());
        });
      });
    });
  }
}
