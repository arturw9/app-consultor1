import 'dart:convert';

import 'package:app_consultor/modelos/DuracaoPlano.dart';
import 'HorarioPlano.dart';
import 'ModalidadePlano.dart';
import 'Pacote.dart';
import 'Produto.dart';
import 'Pacote.dart';

class Plano {
  List<ModalidadePlano> modalidades;
  int? fidelidadeDuracaoPlano;
  double taxaAdesao;
  double valorPlanoMensal;
  double? valorAnuidade;
  int codigo;
  String descricao;
  double valorProdutoMensal;
  double percentualMultaCancelamento;
  String tipoPlano;
  String produtoDescricao;
  String? horario;
  double? horarioValorEspecifico;
  bool bolsa;
  bool obrigatorio;
  bool? creditoTreinoNaoCumulativo = false;
  bool? creditoSessao = false;
  double valor;
  DateTime ingressoAte;
  DateTime vigenciaDe;
  DateTime vigenciaAte;
  double? valorFinal;
  Pacote? pacoteSelecionado;
  int? maximoVezesParcelar;
  List<int>? diasVencimentoProrata;
  List<HorarioPlano>? horarios;
  HorarioPlano? horarioPlanoSelecionado;
  List<Produto>? produtos;
  List<Pacote>? pacotes;
  List<DuracaoPlano>? duracoes;
  DuracaoPlano? duracaoSelecionada;

  Plano(
      {required this.modalidades,
      required this.fidelidadeDuracaoPlano,
      required this.taxaAdesao,
      required this.valorPlanoMensal,
      required this.valorAnuidade,
      required this.codigo,
      required this.descricao,
      required this.valorProdutoMensal,
      required this.percentualMultaCancelamento,
      required this.tipoPlano,
      required this.produtoDescricao,
      required this.horario,
      required this.horarioValorEspecifico,
      required this.bolsa,
      required this.obrigatorio,
      required this.valor,
      required this.ingressoAte,
      required this.vigenciaDe,
      required this.vigenciaAte,
      this.produtos,
      this.horarios,
      this.maximoVezesParcelar,
      this.diasVencimentoProrata,
      this.valorFinal,
      this.creditoTreinoNaoCumulativo,
      this.creditoSessao,
      this.duracoes,
      this.pacotes});

  List<Pacote> get pacotesAdicionais {
    List<Pacote> pacotesLista = <Pacote>[];
    pacotes!.forEach((value) {
      if (value.pacoteAdicional) {
        pacotesLista.add(value);
      }
    });
    return pacotesLista;
  }

  List<Pacote> get pacotesNormais {
    List<Pacote> pacotesLista = <Pacote>[];
    pacotes!.forEach((value) {
      if (!value.pacoteAdicional) {
        pacotesLista.add(value);
      }
    });
    return pacotesLista;
  }

  List<ModalidadePlano> modalidadesPorPacote(
      List<ModalidadePlano> modalidadesPacote) {
    List<ModalidadePlano> modalidadesRet = <ModalidadePlano>[];
    modalidadesPacote.forEach((value) {
      modalidadesRet.add(modalidades.firstWhere(
          (element) => value.codigo == element.codigo,
          orElse: () => value));
    });
    if (modalidadesRet.isEmpty)
      return modalidadesPacote;
    else
      return modalidadesRet;
  }

  Map<String, dynamic> toMap() {
    return {
      'valor': valor,
      'descricao': descricao,
      'horario': horario,
    };
  }

  factory Plano.fromMap(Map<String, dynamic> map) {
    List<dynamic> horarios = map['horarios'].toList();
    List<int> diasToList(String dias) {
      var lista = <int>[];
      int j;
      for (var i = 0; i < dias.length; i++) {
        if (dias[i] != ',') {
          if (dias[i + 1] != ',') {
            j = (int.parse(dias[i]) * 10) + int.parse(dias[i + 1]);
            lista.add(j);
            j = 0;
            i++;
          } else
            lista.add(int.parse(dias[i]));
        }
      }
      return lista;
    }

    try {
      return Plano(
        produtos: map['produtosSugeridos'] != null
            ? List<Produto>.from(
                map['produtosSugeridos']?.map((x) => Produto.fromMapPlano(x)))
            : null,
        valorFinal: map['valorFinal'] != null ? map['valorFinal'] : null,
        diasVencimentoProrata: map['diasVencimentoProrata'] != null
            ? diasToList(map['diasVencimentoProrata'])
            : null,
        maximoVezesParcelar: map['maximoVezesParcelar'] != null
            ? map['maximoVezesParcelar']
            : null,
        codigo: map['codigo'],
        modalidades: List<ModalidadePlano>.from(
                map['modalidades']?.map((x) => ModalidadePlano.fromMap(x)))
            .toList(),
        duracoes: List<DuracaoPlano>.from(
            map['duracoes']?.map((x) => DuracaoPlano.fromMap(x))).toList(),
        descricao: map['descricao'] as String,
        bolsa: map['bolsa'] as bool,
        horarios: List<HorarioPlano>.from(
            map['horarios']?.map((x) => HorarioPlano.fromMap(x))).toList(),
        obrigatorio: map['produtosSugeridos'][0]['obrigatorio'] as bool,
        tipoPlano: map['tipoPlano'] as String,
        fidelidadeDuracaoPlano: map["planoRecorrencia"] == null
            ? null
            : map['planoRecorrencia']['duracaoPlano'] as int,
        taxaAdesao: map["planoRecorrencia"] == null
            ? 0
            : map['planoRecorrencia']['taxaAdesao'] as double,
        valorAnuidade: map["planoRecorrencia"] == null
            ? null
            : map['planoRecorrencia']['valorAnuidade'] as double,
        horario: horarios.isNotEmpty
            ? map['horarios'][0]["horario"]["descricao"] as String
            : "",
        produtoDescricao:
            map['produtosSugeridos'][1]['produto']['descricao'] as String,
        valorPlanoMensal: map["planoRecorrencia"] == null
            ? 0
            : map['planoRecorrencia']['valorMensal'] as double,
        valorProdutoMensal:
            map['produtosSugeridos'][0]['valorProduto'] as double,
        horarioValorEspecifico: horarios.isNotEmpty
            ? map['horarios'][0]['valorEspecifico'] as double
            : null,
        percentualMultaCancelamento:
            map['percentualMultaCancelamento'] as double,
        valor: map['produtoContrato']['valorFinal'] as double,
        vigenciaDe: DateTime.fromMicrosecondsSinceEpoch(map['vigenciaDe']),
        vigenciaAte: DateTime.fromMicrosecondsSinceEpoch(map['vigenciaAte']),
        ingressoAte: DateTime.fromMicrosecondsSinceEpoch(map['ingressoAte']),
        creditoTreinoNaoCumulativo: map["creditoTreinoNaoCumulativo"],
        creditoSessao: map["creditoSessao"],
        pacotes: map['pacotes'] != null && map['pacotes'].length != 0
            ? List<Pacote>.from(map['pacotes']?.map((x) {
                return Pacote.fromMap(x['pacote']);
              }))
            : null,
      );
    } catch (e) {
      throw e;
    }
  }

  String toJson() => json.encode(toMap());

  factory Plano.fromJson(String source) => Plano.fromMap(json.decode(source));
}
