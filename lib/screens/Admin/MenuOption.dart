import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:otto/Colours.dart';

import '../appBar.dart';

class MenuOption extends StatefulWidget {
  const MenuOption({Key? key}) : super(key: key);
  @override
  State<MenuOption> createState() => _MenuOptionState();
}

class _MenuOptionState extends State<MenuOption> {
  final  iconColor=Colors.orangeAccent;
  Reference storageReference = FirebaseStorage.instance.ref();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  @override
  void outOfStock(DataSnapshot snapshot, String foodName) async {
    await databaseReference.child('OutOfStock/$foodName').set({
      'Name': snapshot.children.elementAt(3).value.toString(),
      'Price': snapshot.children.elementAt(4).value.toString(),
      'Discription': snapshot.children.elementAt(1).value.toString(),
      'ImageUrl': snapshot.children.elementAt(2).value.toString(),
      'Cetogory': snapshot.children.elementAt(0).value.toString(),
    }).whenComplete(
        () => databaseReference.child('foodCardData/$foodName').remove());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(int.parse(Colours.bodyColours)),
        appBar: AppBar(
          title: Container(child: appBar(),height: 50,),
        ),
        body: OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
          if(orientation==Orientation.portrait)
            {
              return FirebaseAnimatedList(
                query: databaseReference.child('foodCardData'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.height*.7,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                      clipBehavior: Clip.hardEdge,
                      child: Card(
                        borderOnForeground: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.values[1],
                          children: [
                            Container(
                              decoration: BoxDecoration(border: Border.all(width: 2)),
                              height: 200,
                              child: Image.network(snapshot.children.elementAt(2).value.toString()),
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
                                    color: Colors.white,
                                    width: 60,
                                    child: IconButton(
                                      color: Colors.red,
                                      onPressed: () {
                                        databaseReference
                                            .child(
                                            'foodCardData/${snapshot.key.toString()}')
                                            .remove();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                      ),
                                    ),
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
                                        onPressed: () {
                                          outOfStock(snapshot, snapshot.key.toString());
                                        },
                                        //icon: Icon(Icons.remove_red_eye), label:
                                        icon: Icon(Icons.remove_red_eye,color: Colors.grey,),
                                        label: Text('Out Of Stock'),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          else{
            return Container(
              child: FirebaseAnimatedList(
                query: databaseReference.child('foodCardData'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return Container(
                    width: MediaQuery.of(context).size.height*.3,
                    child: Container(
                      width: MediaQuery.of(context).size.height*.7,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                      clipBehavior: Clip.hardEdge,
                      child: Card(
                        borderOnForeground: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.values[1],
                          children: [
                            Container(
                              height: 200,
                              child: Image.network(
                                snapshot.children.elementAt(2).value.toString(),
                                fit: BoxFit.fill,
                              ),
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
                                    color: Colors.white,
                                    width: 60,
                                    child: IconButton(
                                      color: Colors.grey,
                                      onPressed: () {
                                        databaseReference
                                            .child(
                                            'foodCardData/${snapshot.key.toString()}')
                                            .remove();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                      ),
                                    ),
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
                                        onPressed: () {
                                          outOfStock(snapshot, snapshot.key.toString());
                                        },
                                        //icon: Icon(Icons.remove_red_eye), label:
                                        icon: Icon(Icons.remove_red_eye,color: Colors.grey,),
                                        label: Text('Out Of Stock'),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    )
                  );
                },
              ),
            );
          }
        },)
      ),
    );
  }
}
