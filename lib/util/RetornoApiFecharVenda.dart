import 'dart:convert';

class RetornoApiFecharVenda {
  double valorFinal;
  int nrParcelas;
  RetornoApiFecharVenda({
    required this.valorFinal,
    required this.nrParcelas,
  });

  Map<String, dynamic> toMap() {
    return {
      'valorFinal': valorFinal,
      'nrParcelas': nrParcelas,
    };
  }

  factory RetornoApiFecharVenda.fromMap(Map<String, dynamic> map) {
    return RetornoApiFecharVenda(
      valorFinal: map['valorFinal'],
      nrParcelas: map['nrParcelas'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RetornoApiFecharVenda.fromJson(String source) {
    dynamic retorno = json.decode(source);
    return RetornoApiFecharVenda.fromMap(retorno['return']);
  }
}
