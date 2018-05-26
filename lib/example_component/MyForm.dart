import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


class MyForm extends StatefulWidget{

  @override
  _MyFormState createState() => new _MyFormState();

}


class _MyFormState extends State<MyForm>{

  final myController = new TextEditingController();

@override
void dispose(){
  myController.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return new Container(
    
      child: new Padding(
          padding:const EdgeInsets.all(16.0),
          child:  new TextField(
              controller: myController,
              ),
        ),
      );
  }


}