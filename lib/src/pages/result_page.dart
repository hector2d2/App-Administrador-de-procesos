import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:so/src/class/process_class.dart';
import 'package:so/src/global/provider.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of(context);
    data.resultados = [];
    return Scaffold(
      body: _cards(data),
    );
  }

  Widget _cards(VariablesGlobal data) {
    return ListView(
      children: <Widget>[
        _card1(data),
      ],
    );
  }

  Widget _card1(VariablesGlobal data) {
    return SingleChildScrollView(
      child: Column(
        children: _cardsresult(data),
      ),
    );
  }

  List<Widget> _cardsresult(VariablesGlobal data) {
    List<Widget> cards = List<Widget>();

    var result = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 11.0,
      child: ListTile(
        title: Text('Resultado'),
        subtitle: Text(_solution(data)),
      ),
    );
    cards.add(result);

    for (int i = 0; i < data.size; i++) {
      cards.add(SizedBox(
        height: 10.0,
      ));
      cards.add(_processCard(data.resultados[i]));
    }

    return cards;
  }

  Widget _processCard(String data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 11.0,
      child: ListTile(
        title: Text(data),
      ),
    );
  }

  String _solution(VariablesGlobal data) {
    int seconds = 0;
    int secondsofso = int.parse(data.sonumber);
    List<Process> process = List<Process>();
    List<int> numbers = List<int>();
    for (int i = 0; i < data.size; i++) {
      Process p = Process(
        int.parse(data.inicia[i]),
        int.parse(data.utiliza[i]),
        int.parse(data.es[i]),
        int.parse(data.bloqueado[i]),
        'Proceso #${i + 1}',
      );
      process.add(p);
    }
    for (int i = 0; i < data.size; i++) {
      numbers.add(process[i].inicio);
    }

    for (int i = 0; i < data.size; i++) {
      for (int j = i + 1; j < data.size; j++) {
        if (process[i].inicio > process[j].inicio) {
          Process p = process[i];
          process[i] = process[j];
          process[j] = p;
        }
      }
    }

    Queue<Process> listo = Queue<Process>();
    Queue<Process> ejecucion = Queue<Process>();
    Queue<Process> bloqueado = Queue<Process>();
    seconds += process[0].inicio;
    if (seconds >= 1) seconds--;
    ejecucion.add(process[0]);
    process.removeAt(0);

    while (listo.length > 0 || ejecucion.length > 0 || bloqueado.length > 0) {
      if (ejecucion.length > 0) {
        if (ejecucion.first.utiliza > secondsofso) {
          if (process.length > 0) {
            for (int i = 1; i <= secondsofso; i++) {
              for (int j = 0; j < process.length; j++) {
                if (process.elementAt(j).inicio <= seconds + i) {
                  listo.add(process.elementAt(j));
                  process.removeAt(j);
                  j = -1;
                }
              }
            }
          }

          if (bloqueado.length > 0) {
            for (int i = 1; i <= secondsofso; i++) {
              for (int j = 0; j < bloqueado.length; j++) {
                bloqueado.elementAt(j).es--;
                if (bloqueado.elementAt(j).es == 0) {
                  bloqueado.elementAt(j).utiliza =
                      bloqueado.elementAt(j).bloqueado;
                  listo.add(bloqueado.elementAt(j));
                  bloqueado.remove(bloqueado.elementAt(j));
                  j = -1;
                }
              }
            }
          }

          seconds += secondsofso;
          ejecucion.first.utiliza -= secondsofso;
          listo.add(ejecucion.removeFirst());
          ejecucion.add(listo.removeFirst());
        } else {
          if (process.length > 0) {
            for (int i = 1; i <= ejecucion.first.utiliza; i++) {
              for (int j = 0; j < process.length; j++) {
                if (process.elementAt(j).inicio <= seconds + i) {
                  listo.add(process.elementAt(j));
                  process.removeAt(j);
                  j = -1;
                }
              }
            }
          }

          if (bloqueado.length > 0) {
            for (int i = 1; i <= ejecucion.first.utiliza; i++) {
              for (int j = 0; j < bloqueado.length; j++) {
                bloqueado.elementAt(j).es--;
                if (bloqueado.elementAt(j).es <= 0) {
                  if (bloqueado.elementAt(j).bloqueado == 0) {
                    bloqueado.remove(bloqueado.elementAt(j));
                    print('finalizo en el segundo${seconds + i}');
                  } else {
                    bloqueado.elementAt(j).utiliza =
                        bloqueado.elementAt(j).bloqueado;
                    listo.add(bloqueado.elementAt(j));
                    bloqueado.remove(bloqueado.elementAt(j));
                    j = -1;
                  }
                }
              }
            }
          }

          seconds += ejecucion.first.utiliza;
          ejecucion.first.utiliza = 0;
          if (ejecucion.first.es > 0 && ejecucion.first.bloqueado > 0) {
            bloqueado.add(ejecucion.removeFirst());
          } else {
            print(
                'finalizo en el segundo ${seconds}   ${ejecucion.elementAt(0).inicio}');
            data.resultados.add(
                ejecucion.elementAt(0).nombre + ' termino en el segundo : ' + seconds.toString());
            ejecucion.removeFirst();
          }

          if (listo.length > 0) {
            ejecucion.add(listo.removeFirst());
          }
        }
      } else if (listo.length > 0) {
        ejecucion.add(listo.removeFirst());
      } else if (bloqueado.length > 0) {
        bool mayor = true;
        for (int i = 0; i < bloqueado.length; i++) {
          if (bloqueado.elementAt(i).es < secondsofso) mayor = false;
        }

        if (mayor) {
          int secondsnow = 0;
          if (process.length > 0) {
            for (int i = 1; i <= secondsofso; i++) {
              for (int j = 0; j < process.length; j++) {
                if (process.elementAt(j).inicio <= seconds + i) {
                  listo.add(process.elementAt(j));
                  process.removeAt(j);
                  secondsnow = i;
                  j = process.length;
                  i = secondsofso + 1;
                }
              }
            }
          }
          if (secondsnow == 0) secondsnow = secondsofso;

          for (int i = 1; i <= secondsnow; i++) {
            for (int j = 0; j < bloqueado.length; j++) {
              bloqueado.elementAt(j).es--;
              if (bloqueado.elementAt(j).es == 0) {
                if (bloqueado.elementAt(j).bloqueado == 0) {
                  bloqueado.remove(bloqueado.elementAt(j));
                  print('finalizo en el segundo ${seconds + i}');
                } else {
                  bloqueado.elementAt(j).utiliza =
                      bloqueado.elementAt(j).bloqueado;
                  bloqueado.elementAt(j).bloqueado = 0;
                  if (ejecucion.length > 0) {
                    listo.add(bloqueado.elementAt(j));
                  } else {
                    ejecucion.add(bloqueado.elementAt(j));
                    secondsnow = i;
                  }
                  bloqueado.remove(bloqueado.elementAt(j));
                  j = -1;
                }
              }
            }
          }
          seconds += secondsnow;
        } else {
          int menor = 99999;

          for (int i = 0; i < bloqueado.length; i++) {
            if (bloqueado.elementAt(i).es < menor)
              menor = bloqueado.elementAt(i).es;
          }

          if (process.length > 0) {
            for (int i = 1; i <= menor; i++) {
              for (int j = 0; j < process.length; j++) {
                if (process.elementAt(j).inicio <= seconds + i) {
                  listo.add(process.elementAt(j));
                  process.removeAt(j);
                  menor = i;
                  j = process.length;
                  i++;
                }
              }
            }
          }

          for (int i = 1; i <= menor; i++) {
            for (int j = 0; j < bloqueado.length; j++) {
              bloqueado.elementAt(j).es--;
              if (bloqueado.elementAt(j).es == 0) {
                if (bloqueado.elementAt(j).bloqueado == 0) {
                  bloqueado.remove(bloqueado.elementAt(j));
                  print('finalizo en el segundo ${seconds + i}');
                } else {
                  bloqueado.elementAt(j).utiliza =
                      bloqueado.elementAt(j).bloqueado;
                  bloqueado.elementAt(j).bloqueado = 0;
                  if (ejecucion.length > 0) {
                    listo.add(bloqueado.elementAt(j));
                  } else {
                    ejecucion.add(bloqueado.elementAt(j));
                  }
                  bloqueado.remove(bloqueado.elementAt(j));
                  j = -1;
                }
              }
            }
          }
          seconds += menor;
        }
      }
    }
    return seconds.toString();
  }
}

//tes
// listo = null;
// ejecucion = null;
// bloqueado = null;
//
