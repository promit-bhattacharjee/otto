
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:otto/screens/Admin/AdminDashboard.dart';
import 'package:otto/screens/Admin/AdminLogin.dart';
import 'package:otto/screens/User/PaidCart.dart';



import 'firebase_options.dart';
import 'screens/User/UserLogin.dart';
bool isAdmin=true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => AdminLogin(),
    },
    theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.white,centerTitle: true,iconTheme: IconThemeData(color: Colors.black)),
    )
  ));
}

// child: MaterialApp(
// home: Scaffold(
// appBar: AppBar(title:appBar()),
// body: SingleChildScrollView(
// child: Column(
// children: [
// Container(
// // width: 450,
// //height: 200,
// child: Column(
// children: [
//
//       Container(
// Container(
// child: foodCard(),
// ),
// Container(
// child: foodCard(),
// ),
// Container(
// child: TextButton(
// onPressed: () {
// // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> createMenu())) ;
// },
// child: Text("AdminPage"),
// ),
// )
// ],
// ),
// )
// ]
// ),
// ),
// ),
// ),
//
//
// Container(
// width: 400,
// height: 400,
// margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
// decoration: BoxDecoration(border: Border(bottom: BorderSide())
// ),
// child: TabBar(
// tabs:[
// Tab(
// child: Text('Starter',style: TextStyle(color: Colors.red,fontSize: 14)),
// ),
// Tab(
// child: Text('Main',style: TextStyle(color: Colors.red,fontSize: 14)),
// ),
// Tab(
// child: Text('Desert',style: TextStyle(color: Colors.red,fontSize: 14)),
// ),
// Tab(
// child: Text('DrinkSS',style: TextStyle(color: Colors.red,fontSize: 14)),
// ),
// Tab(
// child: Text('DrinkSS',style: TextStyle(color: Colors.red,fontSize: 14)),
// ),
// ]
// ),
// )
// ,
// Expanded(
// child: TabBarView(
// children: [
// Text('Starter'),
// Text('Starter2'),
// Text('Starter3'),
// Text('Starter4'),
// Text('Starter4'),
// ],
// )
// )
