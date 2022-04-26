import 'dart:convert';

import 'package:app_consultor/modelos/VinculoColaborador.dart';

class RetornoApiVinculoColaborador {
  int totalPages;
  List<VinculoColaborador> vinculoColaborador;
  RetornoApiVinculoColaborador({
    required this.totalPages,
    required this.vinculoColaborador,
  });

  Map<String, dynamic> toMap() {
    return {
      'vinculoColaborador': vinculoColaborador.map((x) => x.toMap()).toList(),
    };
  }

  factory RetornoApiVinculoColaborador.fromMap(Map<String, dynamic> map) {
    return RetornoApiVinculoColaborador(
      totalPages: map['totalPages']?.toInt() ?? 0,
      vinculoColaborador: List<VinculoColaborador>.from(
          map['content']?.map((x) => VinculoColaborador.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RetornoApiVinculoColaborador.fromJson(String source) =>
      RetornoApiVinculoColaborador.fromMap(json.decode(source));
}
