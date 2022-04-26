import 'dart:convert';
import 'package:app_consultor/modelos/HorarioAcesso.dart';

class RetornoApiHorarioAcesso {
  List<HorarioAcesso> listaHorarioAcesso;
  RetornoApiHorarioAcesso({
    required this.listaHorarioAcesso,
  });

  Map<String, dynamic> toMap() {
    return {
      'listaHorarioAcesso': listaHorarioAcesso.map((x) => x.toMap()).toList(),
    };
  }

  factory RetornoApiHorarioAcesso.fromMap(List<dynamic> map) {
    return RetornoApiHorarioAcesso(
      listaHorarioAcesso:
          List<HorarioAcesso>.from(map.map((x) => HorarioAcesso.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RetornoApiHorarioAcesso.fromJson(String source) =>
      RetornoApiHorarioAcesso.fromMap(json.decode(source));
}
