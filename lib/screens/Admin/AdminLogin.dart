import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/Material.dart';
import '../../Colours.dart';
import '../appBar.dart';
import 'AdminDashboard.dart';
import 'CreateAdmin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  FirebaseAuth authReference = FirebaseAuth.instance;
  TextEditingController emailCnt = TextEditingController();
  TextEditingController passwordCnt = TextEditingController();
  TextEditingController passwordCnt2 = TextEditingController();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  bool forgetPassword = false;
  bool createAdmin = false;

  checkUserValidation() {
    setState(() {
      try {
        authReference.signInWithEmailAndPassword(
            email: emailCnt.text.trim(), password: passwordCnt.text.trim());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$e'), duration: Duration(seconds: 2)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: authReference.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return AdminDashBoard();
            }
            else {
              return Scaffold(
                backgroundColor: Color(int.parse(Colours.bodyColours)),
                appBar: AppBar(title: Container(height: 50,child: appBar(),),),
                body: SingleChildScrollView(
                  child: Container(
                   // color: Colors.white,
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height:MediaQuery.of(context).size.height*.4,width: MediaQuery.of(context).size.width,child: Image.asset('Images/LoginImage.png',fit: BoxFit.fill,),),
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
                            child: forgetPassword == false
                                ? TextField(
                                controller: passwordCnt,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Password',
                                    suffixIcon: Icon(Icons.password)),
                                onChanged: (String value) {
                                  setState(() {});
                                })
                                : null,
                          ),
                          forgetPassword == false
                              ? Container(
                            child: ElevatedButton(
                              onPressed:
                              emailCnt.text.isNotEmpty &&
                                  passwordCnt.text.isNotEmpty &&
                                  passwordCnt.text.length >= 6
                                  ? () {
                                setState(() {
                                  checkUserValidation();
                                });
                              }
                                  : null,
                              child: Text('Login'),
                            ),
                          )
                              : Container(
                            child: ElevatedButton(
                              onPressed:
                              emailCnt.text
                                  .trim()
                                  .isNotEmpty
                                  ? () {
                                setState(() {
                                  checkUserValidation();
                                  createAdmin = !createAdmin;
                                });
                              }
                                  : null,
                              child: Text('Get Email'),
                            ),
                          ),
                          forgetPassword == false
                              ? Container(
                            width: 150,
                            margin: EdgeInsets.all(10),
                            child: Card(
                              elevation: 8,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    forgetPassword = !forgetPassword;
                                  });
                                },
                                child: Text('Forget Password'),
                              ),
                            ),
                          )
                              : Container(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  forgetPassword = !forgetPassword;
                                });
                              },
                              child: Icon(Icons.arrow_back),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },),
      ),

      //   ),
      //   bottomNavigationBar: Container(
      //     height: 50,
      //     child: Center(
      //       child:
      //       Text(authReference.currentUser!.email.toString()),
      //     ),
      //   ),
      // ),
      //  ));
    );
  }

  sendEmail() {
    {
      authReference.sendPasswordResetEmail(email: emailCnt.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email Send To :' + emailCnt.text.trim()),
        duration: Duration(seconds: 2),
      ));
      setState(() {
        createAdmin = !createAdmin;
        passwordCnt.clear();
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextField(
        //   decoration: InputDecoration(border: OutlineInputBorder()),
        // ),duration: Duration(minutes: 3),));
      });
    }
  }
}
