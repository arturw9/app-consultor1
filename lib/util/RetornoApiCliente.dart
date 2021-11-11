import 'dart:convert';

import 'package:app_consultor/modelos/Aluno.dart';

class RetornoApiCliente {
  Aluno aluno;

  RetornoApiCliente({
    required this.aluno,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': aluno.toMap(),
    };
  }

  factory RetornoApiCliente.fromMap(Map<String, dynamic> map) {
    return RetornoApiCliente(
      aluno: Aluno.fromMap(map['content']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RetornoApiCliente.fromJson(String source) =>
      RetornoApiCliente.fromMap(json.decode(source));
}
