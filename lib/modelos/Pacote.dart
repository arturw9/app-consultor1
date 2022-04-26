import 'dart:convert';

import 'ModalidadePlano.dart';

class Pacote {
  int codigo;
  double precoComposicao;
  String descricao;
  bool pacotePadrao;
  bool pacoteAdicional;
  bool modalidadesEspecificas;
  int quantidadeModalidades;
  int? qtdModalidadesSelecionadas;
  List<ModalidadePlano> modalidades;
  bool? selecionado;
  Pacote({
    required this.precoComposicao,
    required this.codigo,
    required this.descricao,
    required this.pacotePadrao,
    required this.pacoteAdicional,
    required this.modalidadesEspecificas,
    required this.quantidadeModalidades,
    required this.modalidades,
    this.qtdModalidadesSelecionadas = 0,
    this.selecionado = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'pacotePadrao': pacotePadrao,
      'pacoteAdicional': pacoteAdicional,
      'modalidadesEspecificas': modalidadesEspecificas,
      'quantidadeModalidades': quantidadeModalidades,
      'modalidades': modalidades.map((x) => x.toMap()).toList(),
    };
  }

  factory Pacote.fromMap(Map<String, dynamic> map) {
    return Pacote(
      precoComposicao: map['precoComposicao'],
      codigo: map['codigo']?.toInt() ?? 0,
      descricao: map['descricao'] ?? '',
      pacotePadrao: map['pacotePadrao'] ?? false,
      pacoteAdicional: map['pacoteAdicional'] ?? false,
      modalidadesEspecificas: map['modalidadesEspecificas'] ?? false,
      quantidadeModalidades: map['quantidadeModalidades']?.toInt() ?? 0,
      modalidades: List<ModalidadePlano>.from(
          map['modalidades']?.map((x) => ModalidadePlano.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pacote.fromJson(String source) => Pacote.fromMap(json.decode(source));
}
