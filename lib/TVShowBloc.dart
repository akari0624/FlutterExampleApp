import 'dart:async';
import 'package:rxdart/subjects.dart';

class TVShowBloc{


final BehaviorSubject<List<dynamic>> _tvShows = BehaviorSubject<List<dynamic>>(seedValue:[]);
final _tvShowController = StreamController<List<dynamic>>();
Stream<List<dynamic>> get tvShowList => _tvShows.stream;
Sink<List<dynamic>> get pipeToSink => _tvShowController.sink;


BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>(seedValue:false);
final _isLoadingController = StreamController<bool>();
Stream<bool> get isLoading => _isLoading.stream;
Sink<bool> get pipeIsLoading => _isLoadingController.sink;
  
  
  TVShowBloc() {

    _tvShowController.stream.listen((newTVShowList){


    _tvShows.add(newTVShowList);

    });

    _isLoadingController.stream.listen((isLoading){

       _isLoading.add(isLoading);
    });
    }


void dispose(){
  _tvShows.close();
  _tvShowController.close();

  _isLoading.close();
  _isLoadingController.close();
}


  }

