// import 'package:bott/Colours.dart';
// import 'package:bott/screens/User/PaidCart.dart';
// import 'package:bott/screens/User/UserCart.dart';
// import 'package:bott/screens/appBar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/Material.dart';
//
// class CartRouter extends StatefulWidget {
//   const CartRouter({Key? key}) : super(key: key);
//
//   @override
//   State<CartRouter> createState() => _CartRouterState();
// }
//
// class _CartRouterState extends State<CartRouter> {
//   bool isAdmin = false;
//   FirebaseAuth authReference = FirebaseAuth.instance;
//   DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height/2,
//           child: FirebaseAnimatedList(shrinkWrap: true,
//             query: databaseReference.child('PaidOrder'),
//             itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                 Animation<double> animation, int index) {
//               print('auth:'+authReference.currentUser!.uid.toLowerCase().toString());
//               print('snap'+snapshot.key.toString());
//               if ((authReference.currentUser!.uid.toLowerCase().toString().contains(snapshot.key.toString()))==true
//                   ) {
//                 return  Container(child: use,width: 400,height: 800,);
//               } else {
//                 return Container(width: 400,height: 1000,child: UserCart());
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
