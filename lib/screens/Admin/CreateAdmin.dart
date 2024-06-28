
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../User/CreateUser.dart';
import '../appBar.dart';

class CreateAdmin extends StatefulWidget {
  const CreateAdmin({Key? key}) : super(key: key);
  @override
  State<CreateAdmin> createState() => _CreateAdminState();
}

class _CreateAdminState extends State<CreateAdmin> {
  bool check =true;
  TextEditingController emailCnt = TextEditingController();
  TextEditingController passwordCnt = TextEditingController();
  TextEditingController passwordCnt2 = TextEditingController();
  DatabaseReference databaseReference= FirebaseDatabase.instance.ref();
  FirebaseAuth authReference = FirebaseAuth.instance;
  checkUserValidation() {
      try {
        authReference
            .createUserWithEmailAndPassword(
            email: emailCnt.text.trim(),
            password: passwordCnt.text.trim()).whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Succesful:'),duration: Duration(seconds: 2)));
          initState();
        });
      }catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Error: $e'),duration: Duration(seconds: 2)));
      }
        }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Container(height: 50,child:appBar()),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailCnt,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Email',
                        suffixIcon: Icon(Icons.login)),
                    onChanged: (String value) {
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                      controller: passwordCnt,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter PassWord',
                          suffixIcon: Icon(Icons.password)),
                      onChanged: (String value) {
                        setState(() {});
                      }),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                      controller: passwordCnt2,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter PassWord',
                          suffixIcon: Icon(Icons.password)),
                      onChanged: (String value) {
                        setState(() {});
                      }),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed:
                    (emailCnt.text.isNotEmpty && passwordCnt.text.isNotEmpty) && ( passwordCnt2.text.trim() == passwordCnt.text.trim()) && (passwordCnt.text.length>=6)
                        ? () {
                      setState(() {
                        checkUserValidation();
                      });
                    }
                        : null,
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

