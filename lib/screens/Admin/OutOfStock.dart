import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:otto/Colours.dart';

import '../appBar.dart';
class OutOfStock extends StatefulWidget
{
  const OutOfStock({Key? key}) : super(key: key);
  @override
  State<OutOfStock> createState() => _OutOfStockState();
}
class _OutOfStockState extends State<OutOfStock> {
  Reference storageReference = FirebaseStorage.instance.ref();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  @override
  void inStock(DataSnapshot snapshot,String foodName) async {
    await databaseReference.child('foodCardData/$foodName').set({
      'Name': snapshot.children.elementAt(3).value.toString(),
      'Price':snapshot.children.elementAt(4).value.toString(),
      'Discription':snapshot.children.elementAt(1).value.toString(),
      'ImageUrl':snapshot.children.elementAt(2).value.toString(),
      'Cetogory': snapshot.children.elementAt(0).value.toString(),
    }).whenComplete(() => databaseReference.child('OutOfStock/$foodName').remove().whenComplete((){setState(() {

    });}));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(int.parse(Colours.bodyColours)),
        appBar: AppBar(
          title: Container(height: 50,child: appBar(),),
        ),
        body: FirebaseAnimatedList(
          query: databaseReference.child('OutOfStock'),
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            if(snapshot.children.isBlank==false){
              print(snapshot.children.isNotEmpty.toString());
              return Center(
                child: Container(
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  clipBehavior: Clip.hardEdge,
                  child: Card(
                    borderOnForeground: true,
                    child: Column(
                      children: [
                        Container(
                          child: Image.network(
                              snapshot.children.elementAt(2).value.toString(),width: MediaQuery.of(context).size.width*.6,height: 400,fit: BoxFit.cover,),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Text('Name : ' +
                                    snapshot.children
                                        .elementAt(3)
                                        .value
                                        .toString()),
                              ),
                              Container(
                                child: Text('Price : ' +
                                    snapshot.children
                                        .elementAt(4)
                                        .value
                                        .toString()),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text('DiscripTion : ' +
                              snapshot.children.elementAt(1).value.toString()),
                        ),
                        Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 200,
                                  child: ElevatedButton.icon(
                                    onPressed:()
                                    {
                                      inStock(snapshot,snapshot.key.toString());
                                    },
                                    //icon: Icon(Icons.remove_red_eye), label:
                                    icon: Icon(Icons.remove_red_eye),
                                    label: Text('In Stock'),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }

            else{
              return Container(
                child: Center(child:Column(
                    children: [
                      CircularProgressIndicator(strokeWidth: 5,),
                      Text('Loading',style: TextStyle(fontSize: 20),),
                    ],
                  )),
              );
            }
          },
        ),
      ),
    );
  }
}
