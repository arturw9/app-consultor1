import 'dart:convert';

import 'package:app_consultor/modelos/Aluno.dart';

class RetornoApiAluno {
    int totalPages;
  List<Aluno> listaAluno;
  RetornoApiAluno({
    required this.totalPages,
    required this.listaAluno,
  });

  Map<String, dynamic> toMap() {
    return {
      'listaAluno': listaAluno.map((x) => x.toMap()).toList(),
    };
  }

  factory RetornoApiAluno.fromMap(Map<String, dynamic> map) {
    return RetornoApiAluno(
            totalPages: map['totalPages'],
      listaAluno:
          List<Aluno>.from(map['content']?.map((x) => Aluno.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RetornoApiAluno.fromJson(String source) =>
      RetornoApiAluno.fromMap(json.decode(source));
}
