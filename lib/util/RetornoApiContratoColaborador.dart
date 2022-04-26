import 'dart:convert';

import 'package:app_consultor/modelos/ContratosColaborador.dart';

class RetornoApiContratoColaborador {
  int totalPages;
  List<ContratosColaborador> contratosColaborador;
  RetornoApiContratoColaborador({
    required this.totalPages,
    required this.contratosColaborador,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalPages': totalPages,
      'contratosColaborador':
          contratosColaborador.map((x) => x.toMap()).toList(),
    };
  }

  factory RetornoApiContratoColaborador.fromMap(Map<String, dynamic> map) {
    return RetornoApiContratoColaborador(
      totalPages: map['totalPages']?.toInt() ?? 0,
      contratosColaborador: List<ContratosColaborador>.from(
          map['return']?.map((x) => ContratosColaborador.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RetornoApiContratoColaborador.fromJson(String source) =>
      RetornoApiContratoColaborador.fromMap(json.decode(source));
}
