
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/Material.dart';
import '../../Colours.dart';
import '../appBar.dart';
import 'PaidCart.dart';
import 'UserCart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }
bool isAdmin =false;
  FirebaseAuth authReference = FirebaseAuth.instance;
  TextEditingController emailCnt = TextEditingController();
  TextEditingController passwordCnt = TextEditingController();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  late String userId =
      FirebaseAuth.instance.currentUser!.uid.toLowerCase().toString();
  TextEditingController searchCnt = TextEditingController();
  bool searchBarOnClicked = true;
  late String? foodPrice;
  late String? foodName;
  bool clicker = true;
  Future uploadUserCart() async {
    clicker = false;
    return await databaseReference
        .child('UserCart')
        .child(userId)
        .child('$foodName')
        .set({
          'Name': foodName,
          'FoodIndex': '1',
          'PaymentID': '',
          'TotalFoodPrice': foodPrice,
          'OrderState': 'Cart',
          'TableNumber': '',
          'Price': foodPrice,
        })
        .catchError(
            (onError) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$onError"),
                  duration: Duration(seconds: 2),
                )))
        .whenComplete(() => setState(() {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Container(
                    width: 50,
                    height: 50,
                    child:
                        Center(child: Text('${foodName} : Succesfully Added'))),
                duration: Duration(seconds: 1),
              ));
              foodName = null;
              foodPrice = null;
              clicker = true;
            }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(int.parse(Colours.bodyColours)),
      appBar: AppBar(
        title: searchBarOnClicked == true
            ? Container(child: Container(height: 50,child: appBar()))
            : Container(
          height: 50,

          // width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(0,10,0,10),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: TextField(
                    controller: searchCnt,
                    decoration: InputDecoration(hintText: 'Search',border: OutlineInputBorder(borderSide: BorderSide(width: 1)),)
                   , onChanged: (String value) {
                      setState(() {});
                    },
                  ),
                ),
              ),

        actions: [
          searchBarOnClicked == true
              ? Container(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        // paidOrder();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserCart()));
                        print(userId);
                      });
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                )
              : Container(width: 1,)
        ],
        leading: Container(
          child: IconButton(
            onPressed: () {
              setState(() {
                searchBarOnClicked = !searchBarOnClicked;
                searchCnt.clear();
              });
            },
            icon: searchBarOnClicked == true
                ? Icon(
                    Icons.search,
                    color: Colors.black,
                  )
                : Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
          ),
        ),
        centerTitle: true,
      ),
      body: OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
        if(orientation==Orientation.portrait){
          return Container(
            child: FirebaseAnimatedList(
              query: databaseReference.child('foodCardData'),
              itemBuilder: (context, snapshort, animation, index) {
                Map datamap = snapshort.value as Map;
                datamap['key'] = snapshort.key;
                if (searchCnt.text.isEmpty) {
                  return Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomLeft: Radius.circular(50))),
                        width: 320,
                        height: 422,
                        margin: EdgeInsets.all(20),
                        clipBehavior: Clip.hardEdge,
                        // .decoration:
                        // BoxDecoration(borderRadius: BorderRadius.circular(50)),
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                child: Image.network(datamap['ImageUrl'],
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: 220),
                              ),
                              Divider(
                                height: 2,
                                color: Colors.black,
                              ),
                              Row(
                                //direction: Axis.vertical,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      height: 30,
                                      child: Text(datamap['Name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900))),
                                  Container(
                                      height: 30,
                                      child: Text('Price : ' + datamap['Price'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900))),
                                ],
                              ),
                              Divider(
                                height: 2,
                                color: Colors.black,
                              ),
                              Container(
                                  height: 50,
                                  child: Text(datamap['Discription'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900))),
                              Container(
                                  height: 50,
                                  child: Align(
                                    alignment: FractionalOffset.bottomRight,
                                    child: ElevatedButton(
                                      onPressed: clicker == true
                                          ? () {
                                        setState(() {
                                          foodPrice = datamap['Price'];
                                          foodName = datamap['Name'];
                                          uploadUserCart();
                                        });
                                      }
                                          : null,
                                      child: Icon(Icons.add, size: 20,color: Colors.black,),
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(int.parse(Colours.bodyColours)))),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ));
                } else if (snapshort.children
                    .elementAt(3)
                    .value
                    .toString()
                    .toLowerCase()
                    .contains(searchCnt.text.toLowerCase())) {
                  return   Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomLeft: Radius.circular(50))),

                        width: 300,
                        height: 422,
                        margin: EdgeInsets.all(20),
                        clipBehavior: Clip.hardEdge,
                        //
                        // .decoration:
                        // BoxDecoration(borderRadius: BorderRadius.circular(50)),
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                child: Image.network(datamap['ImageUrl'],
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: 280),
                              ),
                              Divider(
                                height: 2,
                                color: Colors.black,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      height: 30,
                                      child: Text(datamap['Name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900))),
                                  Container(
                                      height: 30,
                                      child: Text('Price : ' + datamap['Price'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900))),
                                ],
                              ),
                              Divider(
                                height: 2,
                                color: Colors.black,
                              ),
                              Container(
                                  height: 50,
                                  child: Text(datamap['Discription'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900))),
                              Container(
                                  height: 50,
                                  child: Align(
                                    alignment: FractionalOffset.bottomRight,
                                    child: ElevatedButton(
                                      onPressed: clicker == true
                                          ? () {
                                        setState(() {
                                          foodPrice = datamap['Price'];
                                          foodName = datamap['Name'];
                                          uploadUserCart();
                                        });
                                      }
                                          : null,
                                      child: Icon(Icons.add, size: 20,color: Colors.black,),
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(int.parse(Colours.bodyColours)))),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ));
                } else {
                  return Container();
                }
              },
            ),
          );
        }
        else{
          return FirebaseAnimatedList(
            query: databaseReference.child('foodCardData'),
            itemBuilder: (context, snapshort, animation, index) {
              Map datamap = snapshort.value as Map;
              datamap['key'] = snapshort.key;
              if (searchCnt.text.isEmpty) {
                return Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50))),

                      width: MediaQuery.of(context).size.width*.6,
                      height: 422,
                      margin: EdgeInsets.all(20),
                      clipBehavior: Clip.hardEdge,
                      //
                      // .decoration:
                      // BoxDecoration(borderRadius: BorderRadius.circular(50)),
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              child: Image.network(datamap['ImageUrl'],
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: 280),
                            ),
                            Divider(
                              height: 2,
                              color: Colors.black,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    height: 30,
                                    child: Text(datamap['Name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900))),
                                Container(
                                    height: 30,
                                    child: Text('Price : ' + datamap['Price'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900))),
                              ],
                            ),
                            Divider(
                              height: 2,
                              color: Colors.black,
                            ),
                            Container(
                                height: 50,
                                child: Text(datamap['Discription'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900))),
                            Container(
                                height: 50,
                                child: Align(
                                  alignment: FractionalOffset.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: clicker == true
                                        ? () {
                                      setState(() {
                                        foodPrice = datamap['Price'];
                                        foodName = datamap['Name'];
                                        uploadUserCart();
                                      });
                                    }
                                        : null,
                                    child: Icon(Icons.add, size: 20,color: Colors.black,),
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(int.parse(Colours.bodyColours)))),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ));
              } else if (snapshort.children
                  .elementAt(3)
                  .value
                  .toString()
                  .toLowerCase()
                  .contains(searchCnt.text.toLowerCase())) {
                return    Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50))),

                      width:MediaQuery.of(context).size.width*.6,
                      height: 422,
                      margin: EdgeInsets.all(20),
                      clipBehavior: Clip.hardEdge,
                      //
                      // .decoration:
                      // BoxDecoration(borderRadius: BorderRadius.circular(50)),
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              child: Image.network(datamap['ImageUrl'],
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: 280),
                            ),
                            Divider(
                              height: 2,
                              color: Colors.black,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    height: 30,
                                    child: Text(datamap['Name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900))),
                                Container(
                                    height: 30,
                                    child: Text('Price : ' + datamap['Price'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900))),
                              ],
                            ),
                            Divider(
                              height: 2,
                              color: Colors.black,
                            ),
                            Container(
                                height: 50,
                                child: Text(datamap['Discription'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900))),
                            Container(
                                height: 50,
                                child: Align(
                                  alignment: FractionalOffset.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: clicker == true
                                        ? () {
                                      setState(() {
                                        foodPrice = datamap['Price'];
                                        foodName = datamap['Name'];
                                        uploadUserCart();
                                      });
                                    }
                                        : null,
                                    child: Icon(Icons.add, size: 20,color: Colors.black,),
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(int.parse(Colours.bodyColours)))),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ));;
              } else {
                return Container();
              }
            },
          );
        }
      },),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            color: Colors.white,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    authReference.signOut();
                  });
                },
                icon: Icon(Icons.logout)),
            Text('Email : ' +
                FirebaseAuth.instance.currentUser!.email.toString()),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>PaidCart(isAdmin: isAdmin)));
                },
                icon: Icon(Icons.doorbell)),
          ],
        ),
      ),
    );
  }
}
