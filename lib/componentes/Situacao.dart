import 'package:app_consultor/util/EnumSituacao.dart';
import 'package:flutter/material.dart';

import 'StatusSituacao.dart';

class Situacao extends StatelessWidget {
  final tipoSituacao tipo;
  const Situacao({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (tipo) {
      case tipoSituacao.ativo:
        return SituacaoAtivo();

      case tipoSituacao.inativo:
        return SituacaoInativo();

      case tipoSituacao.a_vencer:
        return SituacaoVencer();

      case tipoSituacao.atestado:
        return SituacaoAtestado();

      case tipoSituacao.ferias:
        return SituacaoFerias();

      case tipoSituacao.normal:
        return SituacaoFerias();

      case tipoSituacao.cancelado:
        return SituacaoCancelados();

      case tipoSituacao.renovado:
        return SituacaoRenovados();

      case tipoSituacao.inacancelado:
        return SituacaoInacacelados();

      case tipoSituacao.desistencia:
        return SituacaoDesistentes();

      case tipoSituacao.vencido:
        return SituacaoVencidos();

      case tipoSituacao.trancado:
        return SituacaoTrancados();

      case tipoSituacao.trancado_vencido:
        return SituacaoTranvencidos();

      case tipoSituacao.visitante:
        return SituacaoVisitantes();

      case tipoSituacao.diaria:
        return SituacaoDiaria();

      case tipoSituacao.freepass:
        return SituacaoFreepass();

      default:
        return Container();
    }
  }
}
