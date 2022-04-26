import 'dart:convert';

class HorarioPlano {
  String? descricao;
  String? tipoValor;
  String? tipoOperacao;
  double? valorEspecifico;
  double? percentualdesconto;
  HorarioPlano({
    this.descricao,
    this.tipoValor,
    this.tipoOperacao,
    this.valorEspecifico,
    this.percentualdesconto,
  });

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'tipoValor': tipoValor,
      'tipoOperacao': tipoOperacao,
      'valorEspecifico': valorEspecifico,
      'percentualdesconto': percentualdesconto,
    };
  }

  factory HorarioPlano.fromMap(Map<String, dynamic> map) {
    return HorarioPlano(
      descricao: map["horario"]['descricao'],
      tipoValor: map['tipoValor'],
      tipoOperacao: map['tipoOperacao'],
      valorEspecifico: map['valorEspecifico'] ?? 0,
      percentualdesconto: map['percentualDesconto'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory HorarioPlano.fromJson(String source) =>
      HorarioPlano.fromMap(json.decode(source));
}
