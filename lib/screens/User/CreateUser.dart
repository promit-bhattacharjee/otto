
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/Material.dart';
import '../appBar.dart';
import 'UserCart.dart';
class CreateUser extends StatefulWidget {
  CreateUser({Key? key}) : super(key: key);
  @override
  State<CreateUser> createState() => _CreateUserState();
}
class _CreateUserState extends State<CreateUser> {
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
  TextEditingController passwordCnt2 = TextEditingController();
  checkUserValidation() {
    try {
      authReference
          .createUserWithEmailAndPassword(
          email: emailCnt.text.trim(), password: passwordCnt.text.trim()).whenComplete(() => addUser());
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('weak-password'),duration:Duration(seconds: 1),));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('email-already-in-use'),duration:Duration(seconds: 1),));
        initState();
      }
    } catch (e) {
      print(e);
    }

  }
  addUser() async {
      await databaseReference.child('User').child(authReference.currentUser!.uid.toLowerCase().toLowerCase()).set({
        'email': emailCnt.text.trim().toLowerCase(),
      }).whenComplete((){
        setState(() {
          passwordCnt.clear();
          passwordCnt2.clear();
          emailCnt.clear();
          Navigator.pop(context);
        });
      });
    }
  @override
  Widget build(BuildContext context) {
   return SafeArea(
       child:Scaffold(
         appBar: AppBar(title: Container(height: 50,child: appBar(),),),
         body:SingleChildScrollView(
           child: Container(
                   child: Column(
                     children: [
                       Container(
                         margin: EdgeInsets.all(20),
                         height: 100,
                         child: Text('Password Must Contain 6 Character or More , Try to Avoid Weak Password',style: TextStyle(fontSize: 24),),
                       ),
                       Container(
                         margin: EdgeInsets.all(10),
                         child: TextField(
                           keyboardType: TextInputType.emailAddress,
                           controller: emailCnt,
                           decoration: InputDecoration(
                               border: OutlineInputBorder(),
                               label: Text('Enter Your Email')),
                           onChanged: (String value) {
                             setState(() {});
                           },
                         ),
                       ),
                       Container(
                         margin: EdgeInsets.all(10),
                         child: TextField(
                           controller: passwordCnt,
                           keyboardType: TextInputType.visiblePassword,
                           decoration: InputDecoration(
                               border: OutlineInputBorder(),
                               label: Text('Enter Your Password')),
                           onChanged: (String value) {
                             setState(() {});
                           },
                         ),
                       ),
                       Container(
                         margin: EdgeInsets.all(10),
                         child: TextField(
                           controller: passwordCnt2,
                           keyboardType: TextInputType.visiblePassword,
                           decoration: InputDecoration(
                               border: OutlineInputBorder(),
                               label: Text('Enter Your Password')),
                           onChanged: (String value) {
                             setState(() {});
                           },
                         ),
                       ),
                       Container(
                         child: ElevatedButton.icon(
                           onPressed: emailCnt.text.trim().toString().isNotEmpty && passwordCnt2.text.trim() ==passwordCnt.text.trim() &&passwordCnt.text.trim().isNotEmpty==true ?
                               (){setState(() {
                             checkUserValidation();
                           });}:null,
                           label: Text('SignUp'),
                           icon: Icon(Icons.login),
                         ),
                       ),
                     ],
                   ),

                 ),
         )



         ,),

   );
}}


