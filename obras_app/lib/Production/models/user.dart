class User {
  final String id;
  final String Id_Obra;
  final String Cliente;
  final String telefone;
  final String Data_Entrada;
  final String Previsao_Producao;
  final String Previsao_Instalacao;
  final String Endereco;
  late String Estatus;
  final String valor;
  final String imagem;
  final String Coments;
  final String Coments2;

  User({
    required this.id,
    required this.Id_Obra,
    required this.Cliente,
    required this.telefone,
    required this.Data_Entrada,
    required this.Previsao_Producao,
    required this.Endereco,
    required this.Previsao_Instalacao,
    required this.Estatus,
    required this.valor,
    required this.imagem,
    required this.Coments,
    required this.Coments2,
  });
}

enum Status {
  suprimentos,
  fabricacao,
  instalacao,
  finalizado,
}

extension ParseToString on Status {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
