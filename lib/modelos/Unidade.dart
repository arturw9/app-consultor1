import 'dart:convert';

class Unidade {
  String nome;
  int codigo;
  String codigoFinanceiro;
  Unidade({
    required this.nome,
    required this.codigo,
    required this.codigoFinanceiro,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'codigo': codigo,
      'codigoFinanceiro': codigoFinanceiro,
    };
  }

  factory Unidade.fromMap(Map<String, dynamic> map) {
    return Unidade(
      nome: map['nome'],
      codigo: map['codigo'],
      codigoFinanceiro: map['codigoFinanceiro'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Unidade.fromJson(String source) =>
      Unidade.fromMap(json.decode(source));
}
