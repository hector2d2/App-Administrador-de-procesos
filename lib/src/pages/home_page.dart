import 'package:flutter/material.dart';
import 'package:so/src/global/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final data = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Administración de Procesos'),
      ),
      body: _cards(data),
    );
  }
  

  Widget _cards(VariablesGlobal data) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _card('SO', 'Quantum de ejecucion de proceso', true,data),
          _card('Procesos', 'num. de procesos', false,data),
          _button(data),
        ],
      ),
    );
  }

  Widget _button(VariablesGlobal data) {
    return RaisedButton(
      onPressed: (_buttonState(data))
          ? () {
              setState(() {
                Navigator.of(context).pushNamed('processes');
              });
            }
          : null,
      child: Text(
        'Generar',
      ),
      color: Colors.blue,
    );
  }

  bool _buttonState(VariablesGlobal data) => (data.sonumber.length > 0 &&
          data.processes.length > 0)
      ? true
      : false;

  Widget _card(String name, String labelText, bool whatIs, VariablesGlobal data) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      elevation: 11.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  (whatIs)
                      ? data.sonumber = value
                      : data.processes = value;
                });
              },
              decoration: InputDecoration(
                icon: Icon(
                  Icons.timelapse,
                  color: Colors.blue,
                ),
                labelText: labelText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
