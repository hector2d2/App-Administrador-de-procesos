import 'package:flutter/material.dart';
import 'package:so/src/global/provider.dart';

class ProcessesPage extends StatefulWidget {
  @override
  _ProcessesPageState createState() => _ProcessesPageState();
}

class _ProcessesPageState extends State<ProcessesPage> {
  
  @override
  Widget build(BuildContext context) {
    final data = Provider.of(context);
    return Scaffold(
      body: _processes(data),
    );
  }

  Widget _processes(VariablesGlobal data) {
    return SingleChildScrollView(
      child:SafeArea(
              child: Column(
          children : _cards(data), 
        ),
      ) 
      
      
    );
  }

  List<Widget> _cards(VariablesGlobal data) {
    data.size = int.parse(data.processes);
    int _number = data.size;
    List<Widget> _listwidgets = List<Widget>();
    for (int i = 0; i < _number; i++) {
      data.inicia.add('');
      data.utiliza.add('');
      data.es.add('');
      data.bloqueado.add('');
    }
    for (int i = 0; i < _number; i++) {
      _listwidgets.add(_card(
          'proceso #${i + 1}', 'Inicia', 'Utiliza', 'E/S', 'Bloqueado', i,data));
    }
    _listwidgets.add(
      _button(_number,data),
    );
    return _listwidgets;
  }

  Widget _button(int number, VariablesGlobal data) {
    return Center(
      child: RaisedButton(
        onPressed: (_statusButton(number,data))
            ? () {
                for (int i = 0; i < number; i++) {
                  print(data.inicia[i]);
                  print(data.utiliza[i]);
                  print(data.es[i]);
                  print(data.bloqueado[i]);
                }
                Navigator.of(context).pushNamed('result');
              }
            : null,
        child: Text(
          'Calcular',
        ),
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  bool _statusButton(int number, VariablesGlobal data) {
    for (int i = 0; i < number; i++) {
      if (data.inicia[i].length < 1 ||
          data.utiliza[i].length < 1 ||
          data.es[i].length < 1 ||
          data.bloqueado[i].length < 1) {
        return false;
      }
    }
    return true;
  }

  Widget _card(String name, String labelText1, String labelText2,
      String labelText3, String labelText4, int id,VariablesGlobal data) {
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
            _textField(id, labelText1, 0,data),
            _textField(id, labelText2, 1,data),
            _textField(id, labelText3, 2,data),
            _textField(id, labelText4, 3,data),
          ],
        ),
      ),
    );
  }

  Widget _textField(int id, String labelText, int pos, data) {
    return TextField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          if (pos == 0) {
            data.inicia[id] = value;
          }
          if (pos == 1) {
            data.utiliza[id] = value;
          }
          if (pos == 2) {
            data.es[id] = value;
          }
          if (pos == 3) {
            data.bloqueado[id] = value;
          }
        });
      },
      decoration: InputDecoration(
        icon: Icon(
          Icons.timelapse,
          color: Colors.blue,
        ),
        labelText: labelText,
      ),
    );
  }
}
