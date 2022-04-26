import 'dart:convert';
import 'Modalidade.dart';
import 'VezesModalidade.dart';


class ModalidadePlano extends Modalidade {
  List<VezesModalidade> numeroVezes;
  int vezesAtual;
  bool? selecionado = false;
  bool? selecionadoPacote;
  bool? selecionadoPacoteAdicional;
  bool? selecionadoPacoteNaoEspecifico;
  int? pacoteCodigo;
  ModalidadePlano({
    required int codigo,
    required String nome,
    required this.numeroVezes,
    required this.vezesAtual,
    this.selecionado,
    this.selecionadoPacote = false,
    this.selecionadoPacoteAdicional = false,
    this.selecionadoPacoteNaoEspecifico = false,
    required double valorMensal,
  }) : super(codigo: codigo, nome: nome, valorMensal: valorMensal);

  VezesModalidade? get numeroVezesSelecionado {
    return numeroVezes
        .firstWhere((element) => element.numeroVezes == vezesAtual);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nome': nome,
      'numeroVezes': numeroVezes,
      'valorMensal': valorMensal,
    };
  }

// map['vezesSemana'] == null
//           ? <int>[map['modalidade']['nrVezes']]
//           : List<int>.from(map['vezesSemana']?.map((x) => x["nrVezes"])),
  @override
  factory ModalidadePlano.fromMap(Map<String, dynamic> map) {
    return ModalidadePlano(
      selecionado: false,
      codigo: map['modalidade']['codigo'],
      nome: map['modalidade']['nome'],
      numeroVezes: map['vezesSemana'] == null
          ? <VezesModalidade>[
              new VezesModalidade(
                codigo: 0,
                numeroVezes: map['modalidade']['nrVezes'],
                percentualDesconto: 0,
                valorEspecifico: 0,
              )
            ]
          : List<VezesModalidade>.from(
              map['vezesSemana']?.map((x) => VezesModalidade.fromMap(x))),
      vezesAtual: map['modalidade']['nrVezes'],
      valorMensal: map['modalidade']['valorMensal'],
    );
  }
  @override
  String toJson() => json.encode(toMap());
  @override
  factory ModalidadePlano.fromJson(String source) =>
      ModalidadePlano.fromMap(json.decode(source));
}
