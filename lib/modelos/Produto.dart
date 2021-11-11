import 'dart:convert';

class Produto {
  String descricao;
  double valorFinal;
  String codigo;
  int quantidade = 0;

  //Contrutores
  Produto(
      {required this.descricao,
      required this.valorFinal,
      required this.codigo,
      required this.quantidade});

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'valorFinal': valorFinal,
      'codigo': codigo,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
        descricao: map['descricao'].toString(),
        valorFinal: map['valorFinal'],
        codigo: map['codigo'].toString(),
        quantidade: 0);
  }
  factory Produto.fromMapPlano(Map<String, dynamic> map) {
    map = map['produto'];
    return Produto(
        descricao: map['descricao'].toString(),
        valorFinal: map['valorFinal'],
        codigo: map['codigo'].toString(),
        quantidade: 1);
  }

  String toJson() => json.encode(toMap());

  factory Produto.fromJson(String source) =>
      Produto.fromMap(json.decode(source));
}
