import "package:flutter/material.dart";

class TVShowDetailPage extends StatelessWidget {
  final dynamic tvObj;

  TVShowDetailPage(this.tvObj);

  @override
  Widget build(BuildContext context) {
     
    var summary = tvObj["show"]["summary"]?? '';
    summary = summary.replaceAll(new RegExp(r'<p>|</p>|<b>|</b>'),'');
        

    return new Scaffold(
        appBar: AppBar(
          title: Text("detailPage"),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Text(
              tvObj["show"]["name"],
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "language: " + tvObj["show"]["language"],
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "type: " + tvObj["show"]["type"],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Padding(
                child: Text(
                  summary,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  maxLines: 20,
                  overflow: TextOverflow.ellipsis,
                ),
                padding: EdgeInsets.all(15.0))
          ],
        )));
  }
}
