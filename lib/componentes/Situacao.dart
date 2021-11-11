import 'package:app_consultor/componentes/StatusSituacao.dart';
import 'package:app_consultor/modelos/Aluno.dart';
import 'package:app_consultor/util/EnumSituacao.dart';
import 'package:flutter/material.dart';

/*class Situacao {
  static Widget retornaSituacao(tipoSituacao tipo) {
    switch (tipo) {
      case tipoSituacao.ativo:
        return CircleAvatar(
          child: const Text(
            'AT',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          backgroundColor: Color(0XFF2EC750),
          radius: 12,
        );
      default:
        return Container();
    }
  }
}*/

class SituacaoWidget extends StatelessWidget {
  final Aluno aluno;
  const SituacaoWidget({Key? key, required this.aluno}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget retornaSituacao(tipoSituacao tipo) {
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

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        textDirection: TextDirection.rtl,
        children: [
          if (aluno.situacao != null) retornaSituacao(aluno.situacao!),
          if (aluno.situacaoContrato != null)
            retornaSituacao(aluno.situacaoContrato!),
        ],
      ),
    );
  }
}
