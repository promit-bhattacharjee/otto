// import 'package:bott/screens/CreateUser.dart';
// import 'package:bott/screens/Payment.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/Material.dart';
// import 'appBar.dart';
//
// class AdminDashBoard extends StatefulWidget {
//   AdminDashBoard({Key? key}) : super(key: key);
//   @override
//   State<AdminDashBoard> createState() => _AdminDashBoardState();
// }
// class _AdminDashBoardState extends State<AdminDashBoard> {
//   bool check=false;
//   FirebaseAuth authReference=FirebaseAuth.instance;
//   DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//     automaticallyImplyLeading: false,
//     title: appBar(),
//       ),
//       body: SingleChildScrollView(
//     child: Container(
//       height: 700,
//       margin: EdgeInsets.only(top: 20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Card(
//                   child: Container(
//                     height: 102,
//                     width: 112,
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pushNamed('/CreateMenu');
//                       },
//                       child: Container(
//                         margin: EdgeInsets.all(5),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Icon(Icons.add_box),
//                             Text('Add Menu'),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   child: Container(
//                     height: 102,
//                     width: 112,
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pushNamed('/MenuOption');
//                       },
//                       child: Container(
//                         margin: EdgeInsets.all(5),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Icon(Icons.add_box),
//                             Text('Menu Option'),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Card(
//                   child: Container(
//                     height: 102,
//                     width: 112,
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pushNamed('/OutOfStock');
//                       },
//                       child: Container(
//                         margin: EdgeInsets.all(5),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Icon(Icons.storage),
//                             Text('Out of Stock'),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   child: Container(
//                     height: 102,
//                     width: 112,
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateUser(check: check)));
//                       },
//                       child: Container(
//                         margin: EdgeInsets.all(5),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Icon(Icons.add_box),
//                             Text('Create Admin'),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Card(
//                   child: Container(
//                     height: 102,
//                     width: 112,
//                     child: TextButton(
//                       onPressed: singOut,
//                       child: Container(
//                         margin: EdgeInsets.all(5),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Icon(Icons.logout_outlined),
//                             Text("log Out"),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   child: Container(
//                     height: 82,
//                     width: 92,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         },
//                       child: Container(
//                         margin: EdgeInsets.all(5),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children:
//                           [
//                             Icon(Icons.add_box),
//                             Text(" Add to Menu"),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//       ),
//       bottomNavigationBar: Container(
//         height: 50,
//         child: Center(child: Text(authReference.currentUser!.email.toString()),),
//       ),
//     );
//   }
//
//   void singOut() {
//     authReference.signOut().whenComplete(() =>
//     Navigator.of(context).pop());
//   }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/Material.dart';
import '../../Colours.dart';
import '../User/PaidCart.dart';
import '../appBar.dart';
import 'CreateAdmin.dart';
import 'MenuOption.dart';
import 'OutOfStock.dart';
import 'CreateMenu.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}
class _AdminDashBoardState extends State<AdminDashBoard> {
  bool isAdmin=true;
  final  iconColor=Colors.orangeAccent;
  final String colorButton= '#303031';
  FirebaseAuth authReference = FirebaseAuth.instance;
  TextEditingController emailCnt = TextEditingController();
  TextEditingController passwordCnt = TextEditingController();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  late String userId =
  FirebaseAuth.instance.currentUser!.uid.toLowerCase().toString();
  TextEditingController searchCnt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Container(height: 50,child: appBar(),),),
        body: Container(
    // height: MediaQuery.of(context).size.height,
    color: Color(int.parse(Colours.bodyColours)),
    // margin: EdgeInsets.only(top: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: [
              Card(
                child: Container(
                  height: 102,
                  width: 112,
                  color: Colors.white,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (builder) =>
                                  CreateMenu()));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.add_box,color:iconColor),
                          Text('Add Menu'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                child: Card(
                  child: Container(
                    height: 102,
                    width: 112,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (builder) =>
                                    MenuOption()));
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.add_box,color:iconColor),
                            Text('Menu Option',style: TextStyle(fontStyle: FontStyle.italic),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: [
              Card(
                child: Container(
                  height: 102,
                  width: 112,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (builder) =>
                                  OutOfStock()));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.shopping_cart,color: Colors.orangeAccent,),
                          Text('Out of Stock'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Container(
                  height: 102,
                  width: 112,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (builder) =>
                                  CreateAdmin()));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.admin_panel_settings,color: Colors.orangeAccent),
                          Text('Create Admin'),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: [
              Card(
                child: Container(
                  height: 102,
                  width: 112,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        authReference.signOut();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.logout_rounded,color: iconColor,),
                          Text("log Out"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Container(
                  height: 102,
                  width: 112,
                  child: TextButton(
                    onPressed: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>PaidCart(isAdmin: isAdmin)));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.add_alert_sharp,color: Colors.orangeAccent,),
                          Text('Orders'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
        ),
      );
  }
}
