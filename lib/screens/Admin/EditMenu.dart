// // import 'dart:io';
// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:firebase_database/ui/firebase_animated_list.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'appBar.dart';
// // import 'package:toggle_switch/toggle_switch.dart';
// //   class EditMenu extends StatefulWidget {
// //   const EditMenu({Key? key}) : super(key: key);
// //   @override
// //   State< > createState() => _EditMenuState();
// // }
// // class _EditMenuState extends State<EditMenu> {
// //   late String name = nameController.text;
// //   late String price= priceController.text;
// //   late String discription= discriptionController.text;
// //   late String foodTag;
// //   TextEditingController nameController=TextEditingController();
// //   TextEditingController priceController=TextEditingController();
// //   TextEditingController discriptionController=TextEditingController();
// //   late File foodImage;
// //   String? imageURL;
// //   Reference storageReference= FirebaseStorage.instance.ref();
// //   DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
// //   Future _uploadCartData()
// //   {return databaseReference.child('foodCardData/$name')
// //       .set({
// //     'Name': name,
// //     'Price':price,
// //     'Discription':discription,
// //     'ImageUrl':imageURL,
// //     'Cetogory': foodTag,
// //   }).then((value) => print('added')).catchError((error) =>
// //       print('faild  $error')).whenComplete(() => SnackBar(content: Text('Updated'),));
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //         home: Scaffold(
// //           appBar: AppBar(actions: [Text('AppBar')]),
// //           body: FirebaseAnimatedList(query: databaseReference.child('foodCardData'),
// //             itemBuilder:(context, snapshort, animation, index){
// //               imageURL=snapshort.children.elementAt(2).value.toString();
// //               return Center(
// //                 child: Card(
// //                   child: Container(
// //                     margin: EdgeInsets.all(10),
// //                     decoration: BoxDecoration(border: Border.all(width: 3)),
// //                     child: Column(
// //                       children: [
// //                         Container(
// //                           child: Image.network(imageURL!),
// //                         ),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                         children: [
// //                           Container(
// //                             width: 180,
// //                             child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Container(margin: EdgeInsets.all(10),child: Text('Name'),),
// //                                 TextField(
// //                                   controller: nameController,
// //                                   decoration: InputDecoration(enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder(),labelText:snapshort.children.elementAt(3).value.toString()),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           Container(
// //                             width: 180,
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Container(margin: EdgeInsets.all(10),child: Text('Price'),),
// //                                 TextField(
// //                                   controller: priceController,
// //                                   decoration: InputDecoration(enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder(),labelText:snapshort.children.elementAt(4).value.toString()),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                         Container(
// //                           width: 400,
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Container(margin: EdgeInsets.all(10),child: Text('Discription'),),
// //                               TextField(
// //                                 controller: discriptionController,
// //                                 decoration: InputDecoration(enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder(),labelText:snapshort.children.elementAt(1).value.toString()),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                         ToggleSwitch(
// //                           customWidths: [80.0,80.0,80.0,80.0,80.0],
// //                           initialLabelIndex: 0,
// //                           doubleTapDisable: true,
// //                           dividerMargin: 20,
// //                           borderWidth: 1.0,
// //                           totalSwitches: 4,
// //                           cornerRadius: 5,
// //                           activeBgColor: [Colors.black],
// //                           borderColor: [Colors.white],
// //                           labels: ['Main', 'Staters', 'Deserts','Drinks'],
// //                           onToggle: (indexOflabels) {
// //                             if(indexOflabels==null)
// //                               {
// //                                 foodTag=snapshort.children.elementAt(0).value.toString();
// //                               }
// //                             if(indexOflabels==0)
// //                             {
// //                               foodTag = 'Main';
// //                             };
// //                             if(indexOflabels==1)
// //                             {
// //                               foodTag = 'Starter';
// //                             };
// //                             if(indexOflabels==2)
// //                             {
// //                               foodTag = 'Desert';
// //                             };
// //                             if(indexOflabels==3)
// //                             {
// //                               foodTag = 'Drinks';
// //                             };
// //                           },
// //                         ),
// //                         Container(
// //                           child: ElevatedButton(
// //                             onPressed: () async {
// //                               if(name.isEmpty)
// //                               {
// //                                 name=snapshort.children.elementAt(3).value.toString();
// //                               }
// //
// //                               if(price.isEmpty)
// //                                 {
// //                                   price=snapshort.children.elementAt(4).value.toString();
// //                                 }
// //                               if(discription.isEmpty){
// //                                 discription=snapshort.children.elementAt(1).value.toString();
// //                               }
// //                               await databaseReference.child('foodCardData/${snapshort.key.toString()}').remove();
// //                               print(snapshort.key.toString());
// //                               await _uploadCartData();
// //                               print(nameController.text);
// //                               print(price);
// //                               setState(() {
// //
// //                               });
// //                              },
// //                             child: Text('Update'),
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             }),
// //         ),
// //     );
// //   }
// // }
// import 'dart:io';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// class EditMenu extends StatefulWidget {
//   const EditMenu({Key? key}) : super(key: key);
//
//   @override
//   State<EditMenu> createState() => _EditMenuState();
// }
//
// class _EditMenuState extends State<EditMenu> {
//   DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
//   Reference storageReference = FirebaseStorage.instance.ref();
//   late String ImageURL;
//   late String name=nameCnt.text;
//   TextEditingController nameCnt = TextEditingController();
//   ImageUpload(String ImageName) async {
//     File? foodImage;
//     var temp = await ImagePicker().pickImage(source: ImageSource.gallery);
//     foodImage = File(temp!.path);
//     storageReference.child('food/$ImageName').delete();
//     UploadTask uploadTask =
//         storageReference.child('food/$ImageName').putFile(foodImage.absolute);
//     await uploadTask.whenComplete(
//         () => ImageURL = uploadTask.snapshot.ref.getDownloadURL().toString());
//   }
//   updateNameData(String foodName,String newFoodName)
//   async {
//    return {
//       databaseReference.child('foodCardData/$foodName').update({
//         'Name': name,
//       }).whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('Successfull${Icons.done}'),))))
//   };
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: FirebaseAnimatedList(
//           query: databaseReference.child('foodCardData'),
//           itemBuilder: (BuildContext context, DataSnapshot snapshot,
//               Animation<double> animation, int index) {
//             String foodName = snapshot.children.elementAt(3).value.toString();
//             String foodPrice = snapshot.children.elementAt(4).value.toString();
//
//             return Center(
//               child: Container(
//                 decoration: BoxDecoration(border: Border.all(width: 5)),
//                 child: Card(
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 380,
//                             child: ElevatedButton.icon(
//                               label: Image.network(
//                                   snapshot.children
//                                       .elementAt(2)
//                                       .value
//                                       .toString(),
//                                   fit: BoxFit.contain),
//                               onPressed: () {
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(SnackBar(
//                                   duration: Duration(milliseconds: 2000),
//                                   content: Container(
//                                     child: ElevatedButton.icon(
//                                       onPressed: () {
//                                         ImageUpload(snapshot.key.toString());
//                                       },
//                                       label: Container(
//                                         height: 100,
//                                         width: 100,
//                                         color: Colors.white70,
//                                         child:
//                                             Center(child: Text('Update Image')),
//                                       ),
//                                       icon: Icon(Icons.update),
//                                     ),
//                                   ),
//                                 ));
//                               },
//                               icon: Icon(Icons.edit),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         margin: EdgeInsets.all(10),
//                         decoration: BoxDecoration(border:Border.all(width:1,),borderRadius: BorderRadius.circular(25)),
//
//                         child: TextButton.icon(
//                           onPressed: () {
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(SnackBar(
//                               duration: Duration(seconds:60),
//                               content: Container(
//                                 child: ElevatedButton.icon(
//                                   onPressed: () {
//                                     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(minutes: 5),content: Container(height: 400,
//                                       child: Column(
//                                         children: [
//                                           TextField(
//                                             controller: nameCnt,
//                                             decoration: InputDecoration(border: OutlineInputBorder()),
//                                           ),
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 flex:1,
//                                                   child: ElevatedButton.icon(onPressed: (){
//                                                     updateNameData(snapshot.key.toString(),price.text as String);
//                                                   }, icon: Icon(Icons.upload),
//                                                   label:Text('Submit')),),
//                                                 Expanded(
//                                                     flex:1,
//                                                     child: ElevatedButton.icon(onPressed: (){
//                                                       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                                                     }, icon: Icon(Icons.cancel),
//                                                         label:Text('Cancel'))
//                                               )
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     )
//                                     );
//                                   },
//                                   label: Container(
//                                     height: 100,
//                                     width: 100,
//                                     color: Colors.white70,
//                                     child:
//                                         Center(child: Text('Update Name')),
//                                   ),
//                                   icon:
//                                       Icon(Icons.drive_file_rename_outline),
//                                 ),
//                               ),
//                             ));
//                           },
//                           icon: Icon(Icons.edit),
//                           label: Container(
//                             height: 100,
//                             width: 200,
//                             color: Colors.white,
//                             child: Center(child: Text('Name : ${foodName}')),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
