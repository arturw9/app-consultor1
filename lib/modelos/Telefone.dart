import 'dart:convert';

class Telefone {
  String tipo;
  String numero;
  Telefone({
    required this.tipo,
    required this.numero,
  });

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'numero': numero,
    };
  }

  factory Telefone.fromMap(Map<String, dynamic> map) {
    return Telefone(
      tipo: map['tipo'],
      numero: map['numero'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Telefone.fromJson(String source) =>
      Telefone.fromMap(json.decode(source));
}
