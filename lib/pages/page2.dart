import 'package:flutter/material.dart';
import 'package:tfc_flutter/pages/pages.dart';

class page2 extends StatelessWidget{
  const page2({super.key});


  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Icon(pages[1].icon, size: 100,),
          Text(pages[1].title, style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }
}