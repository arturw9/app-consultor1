import 'dart:convert';

class Unidade {
  String nome;
  int codigo;
  Unidade({
    required this.nome,
    required this.codigo,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'codigo': codigo,
    };
  }

  factory Unidade.fromMap(Map<String, dynamic> map) {
    return Unidade(
      nome: map['nome'],
      codigo: map['codigo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Unidade.fromJson(String source) =>
      Unidade.fromMap(json.decode(source));
}
