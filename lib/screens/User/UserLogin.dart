
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/Material.dart';
import '../appBar.dart';
import 'CreateUser.dart';
import 'HomePage.dart';
class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);
  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  bool check = false;
  bool forgetPassword =false;
  @override
  void initState() {
    super.initState();
  }

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
  bool finder =false;
  checkUserValidation() {
    setState(() {
      try {
        authReference
            .signInWithEmailAndPassword(
                email: emailCnt.text.trim(), password: passwordCnt.text.trim())
            .whenComplete(() {
              setState(() {
                passwordCnt.clear();
                emailCnt.clear();
              });
        }).catchError((error, stackTrace) =>
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$error'),duration: Duration(seconds: 2)))
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e'),duration: Duration(seconds: 2)));
      }
    });
  }

  // findUserRule() {
  //   // try{
  //   //   setState(() async {
  //   //     await databaseReference
  //   //         .child('User')
  //   //         .get()
  //   //         .then((value) => value.children.forEach((element) {
  //   //       element.children.forEach((element) {
  //   //         if ((element.value
  //   //             .toString()
  //   //             .compareTo(emailCnt.text.trim())) ==
  //   //             0 ||
  //   //             (element.value.toString().compareTo(
  //   //                 authReference.currentUser!.email.toString())) ==
  //   //                 0) {
  //   //           setState(() {
  //   //             checkUserValidation();
  //   //             finder=!finder;
  //   //           });
  //   //         }
  //   //       });
  //   //     })).whenComplete(() => erroFinder());
  //   //   });
  //   // }catch(e){
  //   // }
  //   checkUserValidation();
  // }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: authReference.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Container(child: HomePage());
            } else{
              return Scaffold(
                // appBar: AppBar(title: appBar(),),
                body: SingleChildScrollView(
                  child: Container(
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
                            child: forgetPassword==false? TextField(
                                controller: passwordCnt,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Password',
                                    suffixIcon: Icon(Icons.password)),
                                onChanged: (String value) {
                                  setState(() {});
                                }):null,
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: emailCnt.text.isNotEmpty &&
                                  passwordCnt.text.isNotEmpty && passwordCnt.text.length>=6
                                  ? () {
                                      setState(() {
                                        checkUserValidation();
                                      });
                                    }
                                  : null,
                              child: Text('Login'),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                margin: EdgeInsets.all(10),
                                child: forgetPassword ==false?Card(
                                  elevation: 8,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => CreateUser(
                                        ),
                                      ));
                                    },
                                    child: Text('Create Account'),
                                  ),
                                ):
                                Card(
                                    elevation: 8,
                                    child: TextButton(
                                      onPressed: () {
                                      setState(() {
                                        forgetPassword=!forgetPassword;
                                      });                                       },
                                      child: Icon(Icons.arrow_back,),
                                    ),
                              )),
                              Container(
                                width: 150,
                                margin: EdgeInsets.all(10),
                                child: Card(
                                  elevation: 8,
                                  child: TextButton(
                                    onPressed:forgetPassword==false? () {
                                      setState(() {
                                        forgetPassword=!forgetPassword;
                                      });
                                    }:(){
                                      passwordReset();
                                      setState(() {
                                        forgetPassword=!forgetPassword;
                                      });
                                    },
                                    child: Text('Forget Password'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
  passwordReset()
  {
    authReference.sendPasswordResetEmail(email: emailCnt.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email Send To :'+emailCnt.text.trim()),duration: Duration(seconds: 2),));
    setState(() {

    });
  }
  erroFinder(){
    if(finder==false)
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${emailCnt.text }: is  Not A User'),duration: Duration(seconds: 2)));

      }
  }
}
