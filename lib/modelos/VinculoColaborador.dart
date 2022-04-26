import 'dart:convert';

class VinculoColaborador {
  String? nome;
  String? tipoDeVinculo;
  VinculoColaborador({
    this.nome,
    this.tipoDeVinculo,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'tipoVinculo': tipoDeVinculo,
    };
  }

  factory VinculoColaborador.fromMap(Map<String, dynamic> map) {
    return VinculoColaborador(
      nome: map['colaborador']['pessoa']['nome'] as String,
      tipoDeVinculo: map['tipoVinculo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VinculoColaborador.fromJson(String source) =>
      VinculoColaborador.fromMap(json.decode(source));
}
