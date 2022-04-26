import 'dart:convert';

import 'package:app_consultor/util/EnumSituacao.dart';
import 'package:flutter/foundation.dart';

class ContratosColaborador {
  // String? tipoContrato;
  String? vigenciaDe;
  String? vigenciaAteAjustada;
  int? codContrato;
  tipoSituacao? situacao;
  // String? respLancContrato;
  int? duracao;
  double? valorContrato;
  String? nomePlano;
  String? modalidadesNome;
  int? modalidadesNrVezesSemana;
  ContratosColaborador({
    // this.tipoContrato,
    this.vigenciaDe,
    this.vigenciaAteAjustada,
    this.codContrato,
    this.situacao,
    // this.respLancContrato,
    this.duracao,
    this.valorContrato,
    this.nomePlano,
    this.modalidadesNome,
    this.modalidadesNrVezesSemana,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'tipoContrato': tipoContrato,
      // 'respLancContrato': respLancContrato,
      'vigenciaDe': vigenciaDe,
      'vigenciaAteAjustada': vigenciaAteAjustada,
      'situacao': situacao,
      'duracao': duracao,
      'valorContrato': valorContrato,
      'plano': nomePlano,
      'modalidades': modalidadesNome,
      'modalidadesNrVezesSemana': modalidadesNrVezesSemana,
    };
  }

  factory ContratosColaborador.fromMap(Map<String, dynamic> map) {
    tipoSituacao strToTipoEnum(String str) {
      str = str.toLowerCase();
      if (str == 'visitante_normal') str = 'visitante';
      tipoSituacao tipo =
          tipoSituacao.values.firstWhere((e) => describeEnum(e) == str);
      return tipo;
    }

    return ContratosColaborador(
      codContrato: map['codigo'] != null ? map['codigo'] : null as int,
      nomePlano: map['nomePlano'] != null ? map['nomePlano'] : null as String,
      situacao: map['situacao'] != null ? strToTipoEnum(map['situacao']) : null,
      duracao: map['numeroMeses'] != null ? map['numeroMeses'] : null as int,
      valorContrato:
          map['valorFinal'] != null ? map['valorFinal'] : null as double,
      modalidadesNome: map['modalidades'][0]['modalidade'] != null
          ? map['modalidades'][0]['modalidade']
          : null as String,
      modalidadesNrVezesSemana: map['modalidades'][0]['nrVezesSemana'] as int,

      vigenciaDe:
          map['vigenciaDe'] != null ? map['vigenciaDe'] : null as String,
      vigenciaAteAjustada: map['vigenciaAteAjustada'] != null
          ? map['vigenciaAteAjustada']
          : null as String,

      // dataInicio: DateTime.fromMicrosecondsSinceEpoch(map['vigenciaDe']),
      // dataFim: DateTime.fromMicrosecondsSinceEpoch(map['vigenciaAteAjustada']),
      // tipoContrato: map['tipoContrato'],
      // respLancContrato: map['respLancContrato'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContratosColaborador.fromJson(String source) =>
      ContratosColaborador.fromMap(json.decode(source));
}
