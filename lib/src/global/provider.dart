import 'package:flutter/material.dart';
import 'package:so/src/global/varibles_global.dart';
export 'package:so/src/global/varibles_global.dart';


class Provider extends InheritedWidget {
  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  final variablesGlobal = VariablesGlobal();

  //Provider({Key key,Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static VariablesGlobal of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().variablesGlobal;
  }
}