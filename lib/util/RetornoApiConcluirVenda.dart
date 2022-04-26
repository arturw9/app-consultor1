import 'dart:convert';

class VendaConcluida {
  String retorno;
  VendaConcluida({
    required this.retorno,
  });

  Map<String, dynamic> toMap() {
    return {
      'retorno': retorno,
    };
  }

  factory VendaConcluida.fromMap(Map<String, dynamic> map) {
    return VendaConcluida(
      retorno: map['return'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VendaConcluida.fromJson(String source) =>
      VendaConcluida.fromMap(json.decode(source));
}
