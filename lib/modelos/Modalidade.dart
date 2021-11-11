import 'dart:convert';

class Modalidade {
  int codigo;
  String nome;
  double valorMensal;
  Modalidade({
    required this.codigo,
    required this.nome,
    required this.valorMensal,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nome': nome,
      'valorMensal': valorMensal,
    };
  }

  factory Modalidade.fromMap(Map<String, dynamic> map) {
    return Modalidade(
      codigo: map['codigo'],
      nome: map['nome'],
      valorMensal: map['valorMensal'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Modalidade.fromJson(String source) => Modalidade.fromMap(json.decode(source));
}
