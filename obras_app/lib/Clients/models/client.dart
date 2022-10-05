class Client {
  final String id;
  final String name;
  final String Ide;
  final String valor;
  final String Data_Entrega;
  final String Data_Entrada;
  late String Estatus;
  final String imagem;
  final String Coments;
  final String Coments2;

  Client(
      {required this.id,
      required this.name,
      required this.Ide,
      required this.valor,
      required this.Data_Entrega,
      required this.Data_Entrada,
      required this.Estatus,
      required this.imagem,
      required this.Coments,
      required this.Coments2});
}

enum Status {
  suprimentos,
  fabricacao,
  entrega,
  finalizado,
}

extension ParseToString on Status {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
