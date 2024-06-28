
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';

import '../../Colours.dart';
import '../appBar.dart';
class PaidCart extends StatefulWidget {
  bool isAdmin;
  PaidCart({Key? key, required this.isAdmin}) : super(key: key);

  @override
  State<PaidCart> createState() => _PaidCartState();
}

class _PaidCartState extends State<PaidCart> {
  late bool isAdmin;
  @override
  void initState() {
    isAdmin = widget.isAdmin;
    super.initState();
  }

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref('PaidOrder');
  FirebaseAuth authReference = FirebaseAuth.instance;
  String auth = FirebaseAuth.instance.currentUser!.uid.toLowerCase().toString();

  TextEditingController estimatedTimeCnt = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(int.parse(Colours.bodyColours)),
        appBar: AppBar(title: Container(child: appBar(),height: 50,),),
        body:  FirebaseAnimatedList(query: databaseReference,scrollDirection: Axis.vertical, itemBuilder: (BuildContext context, DataSnapshot snapshotNext, Animation<double> animation, int index) {
              return FirebaseAnimatedList(physics: ScrollPhysics(),shrinkWrap: true,scrollDirection: Axis.vertical,query: databaseReference.child(snapshotNext.key.toString()), itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                Map dataMap = snapshot.value as Map;
                dataMap['key'] = snapshot.key;
                print(dataMap);
                return Flex(direction:Axis.vertical,mainAxisSize: MainAxisSize.min,children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      //width: 400,
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                        EdgeInsets.all(20),
                                        child: Text(
                                          'TableNumber:' +
                                              dataMap[
                                              'TableNumber'],
                                          style: TextStyle(
                                              fontSize: 18),
                                        ),
                                      )),
                                ),
                                Container(
                                  child: Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Text('Status : ' +
                                            dataMap['OrderState']),
                                      )),
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1)),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                          'Food Name : ' +
                                              dataMap['Name']),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Text('Price : ' +
                                            dataMap['Price']),
                                      )),
                                  Expanded(
                                      child: Container(
                                        child: Text('Quntity : ' +
                                            dataMap['FoodIndex']),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1)),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: isAdmin == true
                                  ? Row(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .end,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 40,
                                    child: TextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                                      ],
                                      onTap: () {
                                        setState(() {});
                                      },
                                      decoration:
                                      InputDecoration(
                                          label: Text(
                                            'Estimated Time',
                                            style: TextStyle(
                                                fontSize: 8),
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          estimatedTimeCnt
                                              .text =
                                              value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                      width: 80,
                                      height: 40,
                                      child:
                                      ElevatedButton(
                                          onPressed:
                                              () {
                                            setState(
                                                    () {
                                                  if (estimatedTimeCnt
                                                      .text
                                                      .isEmpty) {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(SnackBar(content: Text('Please Enter a Estemated Delivary time')));
                                                  } else {
                                                    acceptOrder(dataMap);
                                                  }
                                                });
                                          },
                                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),
                                          child: Text(
                                              'Accept',))),
                                  Container(
                                      width: 120,
                                      height: 40,
                                      child:
                                      ElevatedButton
                                          .icon(
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                                        onPressed: () {
                                          setState(() {
                                            delete();});
                                        },
                                        label: Text(
                                            'Decline'),
                                        icon: Icon(
                                            Icons.delete),
                                      )),
                                  Container(
                                      width: 80,
                                      height: 40,
                                      child:
                                      ElevatedButton(
                                          onPressed:
                                              () {
                                                delivered(dataMap);
                                          },
                                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                                          child: Text(
                                            'Delivered',))),
                                  Container(
                                    height: 1,
                                    decoration:
                                    BoxDecoration(
                                        border: Border
                                            .all(
                                            width:
                                            1)),
                                  ),
                                ],
                              )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],)
                ;
            },)    ;
            },
  )
      )
    ) ;
  }
  delete(){
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('This Method is Not yet Ready to User')));
  }
  delivered(Map dataMap)
  async {
   await FirebaseDatabase.instance.ref().child('Delivered').child(auth).child(dataMap['Name']).update({
      '${dataMap['key']}':dataMap.values
    }).whenComplete(() =>
        databaseReference.child(auth).child(dataMap['Name'].toString()).remove().whenComplete(() {setState(() {

        });})
    );

  }
  acceptOrder(Map dataMap){
    //print('Promit'+dataMap.values.toString());
    databaseReference.child(auth).child(dataMap['Name'].toString()).update({
      'OrderState':
      'Arrival Time : ${estimatedTimeCnt.text.trim()}'
    }).whenComplete(() {setState(() {

    });});
  }
}
