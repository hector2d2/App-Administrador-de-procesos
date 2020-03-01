class VariablesGlobal {

  String sonumber='', processes='';

  int size;

  List<String> inicia = List<String>();
  List<String> utiliza = List<String>();
  List<String> es = List<String>();
  List<String> bloqueado = List<String>();
  List<String> resultados = List<String>();


  set soNumber(String value) {
    this.sonumber = value;
  }

  get soNumber => this.sonumber;

  set numberProcesses(String value) {
    this.processes = value;
  }

  get numberProcesses => this.processes;

}
