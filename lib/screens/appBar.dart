import 'package:flutter/material.dart';
class appBar extends StatelessWidget {
  const appBar( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child:
    Image.asset('Images/AppBarImage.png',fit: BoxFit.cover,)
    //  Text( 'ok')
    );
  }
}
