import 'dart:convert';

import 'package:app_consultor/modelos/Plano.dart';

class RetornoApiPlano {
  int totalPages;
  List<Plano> listaPlano;
  RetornoApiPlano({
    required this.totalPages,
    required this.listaPlano,
  });

  Map<String, dynamic> toMap() {
    return {
      'listaPlano': listaPlano.map((x) => x.toMap()).toList(),
    };
  }

  factory RetornoApiPlano.fromMap(Map<String, dynamic> map) {
    return RetornoApiPlano(
      totalPages: map['totalPages'],
      listaPlano:
          List<Plano>.from(map['content']?.map((x) => Plano.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RetornoApiPlano.fromJson(String source) {
    return RetornoApiPlano.fromMap(json.decode(source));
  }
}
