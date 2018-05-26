import "package:flutter/material.dart";

class TVShowCard extends StatelessWidget {
  final dynamic tvObj;

  TVShowCard(this.tvObj);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(18.0),
        child: Column(children: <Widget>[
          Text(tvObj["show"]["name"],
          style:TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),
          ),
          ImgProcessWidget(tvObj["show"]["image"]),
          Divider(),
        ]));
  }
}

class ImgProcessWidget extends StatelessWidget{
   
   final dynamic imgSrcObj;

   ImgProcessWidget(this.imgSrcObj);   

   @override 
   Widget build(BuildContext context){
     
     if (imgSrcObj != null && imgSrcObj != ''){

       return Image.network(imgSrcObj["original"]);
     }

     return Text("no Image");

     

   }

}
