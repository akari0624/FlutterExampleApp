import 'package:flutter/widgets.dart';
import './TVShowBloc.dart';

class TVShowProvider extends InheritedWidget{

  final TVShowBloc tvShowBloc;
  

TVShowProvider({
Key key,
TVShowBloc tvShowBloc,
Widget child,
}) : tvShowBloc = tvShowBloc ?? TVShowBloc(),
super(key:key, child:child);
  


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;



static TVShowBloc of(BuildContext ctx) => (ctx.inheritFromWidgetOfExactType(TVShowProvider) as TVShowProvider).tvShowBloc;


}




