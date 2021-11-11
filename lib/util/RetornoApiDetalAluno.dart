import 'dart:convert';

import 'package:app_consultor/modelos/Aluno.dart';

class RetornoApiDetalAluno {
  final Aluno aluno;

  RetornoApiDetalAluno(this.aluno);

  Map<String, dynamic> toMap() {
    return {
      'aluno': aluno.toMap(),
    };
  }

  factory RetornoApiDetalAluno.fromMap(Map<String, dynamic> map) {
    return RetornoApiDetalAluno(
      Aluno.fromMap(map['content']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RetornoApiDetalAluno.fromJson(String source) =>
      RetornoApiDetalAluno.fromMap(json.decode(source));
}
