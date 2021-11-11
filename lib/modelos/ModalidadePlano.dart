import 'dart:convert';

class ModalidadePlano {
  int? codigo;
  String? nome;
  int? numeroVezes;
  double? valorMensal;
  ModalidadePlano({
    this.codigo,
    this.nome,
    this.numeroVezes,
    this.valorMensal,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nome': nome,
      'numeroVezes': numeroVezes,
      'valorMensal': valorMensal,
    };
  }

  factory ModalidadePlano.fromMap(Map<String, dynamic> map) {
    return ModalidadePlano(
      codigo: map['modalidade']['codigo'],
      nome: map['modalidade']['nome'],
      numeroVezes: map['modalidade']['nrVezes'],
      valorMensal: map['modalidade']['valorMensal'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModalidadePlano.fromJson(String source) =>
      ModalidadePlano.fromMap(json.decode(source));
}
