import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "./TVShowCard.dart";
import "./TVShowDetailPage.dart";
import './TVShowProvider.dart';
import './TVShowBloc.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new TVShowProvider(
          child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
        primarySwatch: Colors.blue,
        ),
        home: new MyHomePage(title:'TV maze Queryable'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final String title;

MyHomePage({this.title:'my app'});


  void fetchData(String text, TVShowBloc tvShowBloc) async {
    var url = "http://api.tvmaze.com/search/shows?q=$text";

     tvShowBloc.pipeIsLoading.add(true);

    final response = await http.get(url);


    if (response.statusCode == 200) {
  
    final _tvProgrameData = json.decode(response.body);
       

      tvShowBloc.pipeToSink.add(_tvProgrameData);

       tvShowBloc.pipeIsLoading.add(false);

    }

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

 Widget renderSerachableCondition(TVShowBloc bloc){

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
           fetchData(text, bloc);
        }),
        Expanded(child:
        StreamBuilder<List<dynamic>>(

          stream:bloc.tvShowList,
          initialData:[],
          builder:(ctx,snapshot) => renderTVProgrameList(snapshot.data),
        ),
        ),
        ]
    ),
  );

 }

 

  @override
  Widget build(BuildContext context) {
    final tvShowBloc = TVShowProvider.of(context);
    return new Scaffold(
      appBar: new AppBar(
       title: new Text(this.title),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  print("reloading....");
                })
          ]),
       body: StreamBuilder<bool>(
         stream:tvShowBloc.isLoading,
          initialData:false,
          builder:(ctx,snapshot) => snapshot.data ? Center(child:CircularProgressIndicator()) : renderSerachableCondition(tvShowBloc) 
       )
     
     );
  }

}