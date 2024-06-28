// import 'dart:io';
//
// import 'package:bott/screens/EditMenu.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class UpdateImage extends StatefulWidget {
//   const UpdateImage({Key? key,snapshort}) : super(key: key);
//
//   @override
//   State<UpdateImage> createState() => _UpdateImageState();
// }
//
// class _UpdateImageState extends State<UpdateImage> {
//   File? foodImage;
//   Reference storageReference=FirebaseStorage.instance.ref();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: InkWell(onTap:() async {
//           var temp=await ImagePicker().pickImage(source: ImageSource.gallery);
//           setState(() async {
//             foodImage=File(temp!.path);
//               UploadTask task =storageReference.child('food/${}').putFile(foodImage.absolute);
//               await task.whenComplete(() async =>
//               {imageURL = await task.snapshot.ref.getDownloadURL()});
//               print(imageURL!);
//             }
//           }
//           );
//         },child: Image.network(imageURL!,fit: BoxFit.fill,)),
//       ),,
//     );
//   }
// }
