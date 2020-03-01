class Process{

  int inicio,utiliza,es,bloqueado;
  String nombre;
  Process(int inicio,int utiliza, int es, int bloqueado,String nombre){
    this.inicio = inicio;
    this.utiliza = utiliza;
    this.es = es;
    this.bloqueado = bloqueado;
    this.nombre = nombre;
  }
}