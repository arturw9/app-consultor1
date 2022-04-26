import 'dart:convert';

class HorarioAcesso {
  String horaInicial;
  String horaFinal;
  int diaSemana;
  HorarioAcesso({
    required this.horaInicial,
    required this.horaFinal,
    required this.diaSemana,
  });

  Map<String, dynamic> toMap() {
    return {
      'horaInicial': horaInicial,
      'horaFinal': horaFinal,
      'diaSemana': diaSemana,
    };
  }

  static int diaStr2Int(String dia) {
    switch (dia) {
      case 'SEGUNDA_FEIRA':
        return 1;

      case 'TERCA_FEIRA':
        return 2;

      case 'QUARTA_FEIRA':
        return 3;

      case 'QUINTA_FEIRA':
        return 4;

      case 'SEXTA_FEIRA':
        return 5;

      case 'SABADO':
        return 6;

      case 'DOMINGO':
        return 7;

      default:
        return 1;
    }
  }

  factory HorarioAcesso.fromMap(Map<String, dynamic> map) {
    return HorarioAcesso(
      horaInicial: map['horaInicial'] ?? '',
      horaFinal: map['horaFinal'] ?? '',
      //chama função que converte o literal da string para um inteiro correspondente
      diaSemana: map['diaSemana'] is String
          ? diaStr2Int(map['diaSemana'])
          : map['diaSemana'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HorarioAcesso.fromJson(String source) =>
      HorarioAcesso.fromMap(json.decode(source));
}
