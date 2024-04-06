import 'package:flutter/material.dart';
import 'package:tfc_flutter/pages/pages.dart';

class page1 extends StatelessWidget{
  const page1({super.key});


  @override
  Widget build(BuildContext context){
    return Center(
      child: Scaffold(
        appBar: AppBar(title: Text(pages[0].title)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Icon(pages[0].icon, size: 100,),
            Text(pages[0].title, style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}