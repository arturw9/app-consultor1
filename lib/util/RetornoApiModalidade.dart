import 'dart:convert';

import 'package:app_consultor/modelos/Modalidade.dart';

class RetornoApiModalidade {
  List<Modalidade> modalidades;
  RetornoApiModalidade({
    required this.modalidades,
  });

  Map<String, dynamic> toMap() {
    return {
      'modalidades': modalidades.map((x) => x.toMap()).toList(),
    };
  }

  factory RetornoApiModalidade.fromMap(Map<String, dynamic> map) {
    return RetornoApiModalidade(
      modalidades: List<Modalidade>.from(
          map['content']?.map((x) => Modalidade.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RetornoApiModalidade.fromJson(String source) =>
      RetornoApiModalidade.fromMap(json.decode(source));
}
