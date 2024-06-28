import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../Colours.dart';
import '../appBar.dart';

class CreateMenu extends StatefulWidget {
  const CreateMenu({Key? key}) : super(key: key);
  @override
  State<CreateMenu> createState() => _CreateMenuState();
}
class _CreateMenuState extends State<CreateMenu> {
  File? foodImage;
  late Reference storageReference;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref('foodCardData');
  late final String name = _foodNameCnt.text;
  late final String price = _foodPriceCnt.text;
  late final String discription = _foodDescriptionCnt.text;
  late String foodTag;
  late String imageUrl;
  TextEditingController _foodNameCnt = TextEditingController();
  TextEditingController _foodPriceCnt = TextEditingController();
  TextEditingController _foodDescriptionCnt = TextEditingController();
  Future getImage() async {
    var temp = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      foodImage = File(temp!.path);
    });
  }
  UploadSuccessfulDialog(){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
    child: Row(
      children: [
        Icon(Icons.done),
        Text('Succesfully Cart Uploaded')
      ],
    ),
  ),duration: Duration(seconds: 1),backgroundColor: Colors.white,));
  setState(() {
  });
  reassemble();
  }

  // Future UploadSuccessfulDialog() => showDialog(
  //     context: context,
  //     builder: (context) => Container(
  //           width: 200,
  //           height: 200,
  //           color: Colors.orangeAccent,
  //           child: Center(
  //             child: AlertDialog(
  //               title: Icon(Icons.verified, color: Colors.green, size: 50),
  //               content: Text('Succesfully Uploaded'),
  //               actions: [
  //                 ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: Text('Go BacK'))
  //               ],
  //             ),
  //           ),
  //         ));
  Future _uploadImage() async {
    var url;
    storageReference = FirebaseStorage.instance.ref('food/$name');
    UploadTask task = storageReference.putFile(foodImage!.absolute);
    await task.whenComplete(() async => {
          url = await task.snapshot.ref.getDownloadURL(),
          imageUrl = url.toString(),
          _uploadCartData(),
        });
  }
  _uploadCartData() async {
    return databaseReference
        .child(name)
        .set({
          'Name': name,
          'Price': price,
          'Discription': discription,
          'ImageUrl': imageUrl,
          'Cetogory': foodTag,
        })
        .catchError((error) => print('faild  $error'))
        .whenComplete(() => UploadSuccessfulDialog());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(int.parse(Colours.bodyColours)),
        appBar: AppBar(title: Container(height:50,child: appBar())),
        body: OrientationBuilder(builder: (BuildContext context, Orientation orientation) { 
          if(orientation==Orientation.portrait){
            return Container(
              clipBehavior: Clip.none,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(border: Border.all(width: 2)),
                    height: 200,
                    width: 450,
                    child: Card(
                        child: foodImage != null
                            ? InkWell(
                          onTap: () {
                            getImage();
                          },
                          child: Image.file(foodImage!),
                        )
                            : InkWell(
                            onTap: () {
                              getImage();
                            },
                            child: Center(child: Text('Select An Image',style: TextStyle(fontSize: 18),)))),),

                  Container(
                      width: 450,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: _foodNameCnt,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            label: Text('Name: ', style: TextStyle()),
                          ),
                        ),
                      )),
                  Container(
                      width: 450,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly, FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                          controller: _foodPriceCnt,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            label: Text('Price: ', style: TextStyle()),
                            suffix: Text('BDT'),
                          ),
                        ),
                      )),
                  Container(
                      width: 450,
//color: Colors.green,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: _foodDescriptionCnt,
                          minLines: 1,
                          maxLines: 6,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              label: Text('Description: ', style: TextStyle()),
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 90)),
                        ),
                      )),
                  Container(
                    width: 450,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Container(
                            child: ToggleSwitch(
                              initialLabelIndex: null,
                              borderWidth: 1.0,
                              totalSwitches: 4,
                              cornerRadius: 5,
                              activeBgColor: [Colors.white],
                              borderColor: [Colors.white],
                              labels: ['Main', 'Staters', 'Deserts', 'Drinks'],
                              doubleTapDisable: true,
                              onToggle: (indexOflabels) {
                                if (indexOflabels == 0) {
                                  foodTag = 'Main';
                                }

                                if (indexOflabels == 1) {
                                  foodTag = 'Starter';
                                }
                                if (indexOflabels == 2) {
                                  foodTag = 'Desert';
                                }
                                if (indexOflabels == 3) {
                                  foodTag = 'Drinks';
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      width: 450,
                      child: Container(
                          decoration: BoxDecoration(),
                          child: ElevatedButton.icon(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(int.parse(Colours.bodyColours)))),
                            onPressed:
                                () {
                              setState(() {
                                if( _foodNameCnt.text.isNotEmpty &&
                                    _foodPriceCnt.text.isNotEmpty &&
                                    _foodDescriptionCnt.text.isNotEmpty &&
                                    foodImage!.path.isNotEmpty)
                                {
                                  _uploadImage();
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Enter All Field Correctly'),duration: Duration(seconds: 1),)
                                  );
                                }
                              });
                            },
                            label: Text('Upload',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                            icon: Icon(Icons.upload,color: Colors.orangeAccent,),
                          )))
                ],
              ),
            );
          }
          else{
            return SingleChildScrollView(
              child: Container(
                clipBehavior: Clip.none,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 200,
                              width: 450,
                              child: Card(
                                  child: foodImage != null
                                      ? InkWell(
                                    onTap: () {
                                      getImage();
                                    },
                                    child: Image.file(foodImage!),
                                  )
                                      : InkWell(
                                      onTap: () {
                                        getImage();
                                      },
                                      child: Center(child: Text('Enter A Image ',style: TextStyle(fontSize: 20),))),)),
                            Container(
                              width: 450,color: Colors.orangeAccent,
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      'Category',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Container(
                                      child: ToggleSwitch(
                                        initialLabelIndex: null,
                                        borderWidth: 1.0,
                                        totalSwitches: 4,
                                        cornerRadius: 5,
                                        labels: ['Main', 'Staters', 'Deserts', 'Drinks'],
                                        doubleTapDisable: true,
                                        onToggle: (indexOflabels) {
                                          if (indexOflabels == 1) {
                                            foodTag = 'Main';
                                          }
                                          if (indexOflabels == 2) {
                                            foodTag = 'Starter';
                                          }
                                          if (indexOflabels == 3) {
                                            foodTag = 'Desert';
                                          }
                                          if (indexOflabels == 4) {
                                            foodTag = 'Drinks';
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                width: 450,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: TextField(
                                    controller: _foodNameCnt,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                      label: Text('Name: ', style: TextStyle()),
                                    ),
                                  ),
                                )),
                            Container(
                                width: 450,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: TextField(
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                                    controller: _foodPriceCnt,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                      label: Text('Price: ', style: TextStyle()),
                                      suffix: Text('BDT'),
                                    ),
                                  ),
                                )),
                            Container(
                                width: 450,
//color: Colors.green,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: TextField(
                                    controller: _foodDescriptionCnt,
                                    minLines: 1,
                                    maxLines: 6,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        label: Text('Description: ', style: TextStyle()),
                                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 90)),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),


                    Container(
                        width: 450,
                        child: Container(
                            decoration: BoxDecoration(color: Colors.orangeAccent),
                            child: ElevatedButton.icon(
                              onPressed:
                                  () {
                                setState(() {
                                  if( _foodNameCnt.text.isNotEmpty &&
                                      _foodPriceCnt.text.isNotEmpty &&
                                      _foodDescriptionCnt.text.isNotEmpty &&
                                      foodImage!.path.isNotEmpty)
                                  {
                                    _uploadImage();
                                  }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Enter All Field Correctly'),duration: Duration(seconds: 1),)
                                    );
                                  }
                                });
                              },
                              label: Text('Upload',
                                  style: TextStyle(
                                    color: Colors.orangeAccent,
                                  )),
                              icon: Icon(Icons.upload,color: Colors.orangeAccent,),
                            )))
                  ],
                ),
              ),
            );
          }
        },)
      ),
    );
  }
}
