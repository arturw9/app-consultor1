import 'dart:convert';

class VezesModalidade {
  int codigo;
  int numeroVezes;
  double valorEspecifico;
  double percentualDesconto;
  String? tipoOPeracao;
  String? tipoValor;
  VezesModalidade({
    required this.codigo,
    required this.numeroVezes,
    required this.valorEspecifico,
    required this.percentualDesconto,
    this.tipoOPeracao = '',
    this.tipoValor = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'numeroVezes': numeroVezes,
      'valorEspecifico': valorEspecifico,
      'percentualDesconto': percentualDesconto,
      'tipoOPeracao': tipoOPeracao,
      'tipoValor': tipoValor,
    };
  }

  factory VezesModalidade.fromMap(Map<String, dynamic> map) {
    return VezesModalidade(
      codigo: map["codigo"],
      numeroVezes: map['nrVezes']?.toInt() ?? 0,
      valorEspecifico: map['valorEspecifico']?.toDouble() ?? 0.0,
      percentualDesconto: map['percentualDesconto']?.toDouble() ?? 0.0,
      tipoOPeracao: map['tipoOperacao'] ?? '',
      tipoValor: map['tipoValor'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VezesModalidade.fromJson(String source) =>
      VezesModalidade.fromMap(json.decode(source));
}
