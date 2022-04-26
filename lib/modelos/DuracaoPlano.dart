import 'dart:convert';

class DuracaoPlano {
  int? duracaoNumeroMeses;
  String? tipoValor;
  String? tipoOperacao;
  double? valorEspecifico;
  double? percentualdesconto;

  DuracaoPlano({
    this.duracaoNumeroMeses,
    this.tipoValor,
    this.tipoOperacao,
    this.valorEspecifico,
    this.percentualdesconto,
  });

  Map<String, dynamic> toMap() {
    return {
      'duracaoNumeroMeses': duracaoNumeroMeses,
      'tipoValor': tipoValor,
      'tipoOperacao': tipoOperacao,
      'valorEspecifico': valorEspecifico,
      'percentualdesconto': percentualdesconto,
    };
  }

  factory DuracaoPlano.fromMap(Map<String, dynamic> map) {
    return DuracaoPlano(
      duracaoNumeroMeses: map['numeroMeses'] as int,
      tipoValor: map['tipoValor'] as String,
      tipoOperacao: map['tipoOperacao'] as String,
      valorEspecifico: map['valorEspecifico'] ?? 0,
      percentualdesconto: map['percentualdesconto'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DuracaoPlano.fromJson(String source) =>
      DuracaoPlano.fromMap(json.decode(source));
}
