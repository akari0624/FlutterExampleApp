import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "./TVShowCard.dart";
import "./TVShowDetailPage.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'TV maze Queryable'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isLoading = false;

  var _tvProgrameData = List<dynamic>();

  void fetchData(String text) async {
    var url = "http://api.tvmaze.com/search/shows?q=$text";

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _tvProgrameData = json.decode(response.body);
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget renderItem(dynamic tvObj, BuildContext cxt) {
    return FlatButton(
          onPressed:(){
            print("item clicked");
            Navigator.push(cxt, MaterialPageRoute(
                          builder:(cxt) => TVShowDetailPage(tvObj)
            ));
          },
          child:TVShowCard(tvObj)

    );
    
  }

 Widget renderSerachableCondition(dataArr){

      ListView renderTVProgrameList(dataArr) {
          return ListView.builder(
            itemCount: dataArr.length,
            itemBuilder: (context, i) {
              return renderItem(dataArr[i], context);
            },
          );
        }

  return Container(

    child: Column(
      
      children:<Widget>[
        TextField(onSubmitted:(text){
           fetchData(text);
        }),
        Expanded(child:renderTVProgrameList(dataArr))
        ]
    ),
  );

 }


 

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text(widget.title),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  print("reloading....");
                })
          ]),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : renderSerachableCondition(_tvProgrameData),
      // floatingActionButton: new FloatingActionButton(
      //   onPressed: (){fetchData("batman");},
      //   tooltip: 'Increment', 
      //   child: new Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
