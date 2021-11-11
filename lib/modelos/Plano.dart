import 'dart:convert';

import 'ModalidadePlano.dart';
import 'Produto.dart';

class Plano {
  List<ModalidadePlano> modalidades;

  int fidelidadeDuracaoPlano;
  double taxaAdesao;
  double valorPlanoMensal;
  double valorAnuidade;
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
  double valor;
  DateTime ingressoAte;
  DateTime vigenciaDe;
  DateTime vigenciaAte;
  double? valorFinal;
  int? nrParcelas;
  List<Produto>? produtos;

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
      this.nrParcelas,
      this.valorFinal});

  Map<String, dynamic> toMap() {
    return {
      'valor': valor,
      'descricao': descricao,
      'horario': horario,
    };
  }

  factory Plano.fromMap(Map<String, dynamic> map) {
    List<dynamic> horarios = map['horarios'].toList();
    if (horarios.isEmpty) {
      return Plano(
        produtos: map['produtosSugeridos'] != null
            ? List<Produto>.from(
                map['produtosSugeridos']?.map((x) => Produto.fromMapPlano(x)))
            : null,
        valorFinal: map['valorFinal'] != null ? map['valorFinal'] : null,
        nrParcelas: map['nrParcelas'] != null ? map['nrParcelas'] : null,
        codigo: map['codigo'],
        modalidades: List<ModalidadePlano>.from(
                map['modalidades']?.map((x) => ModalidadePlano.fromMap(x)))
            .toList(),
        descricao: map['descricao'] as String,
        horario: null,
        tipoPlano: map['tipoPlano'] as String,
        taxaAdesao: map['planoRecorrencia']['taxaAdesao'] as double,
        valorAnuidade: map['planoRecorrencia']['valorAnuidade'] as double,
        horarioValorEspecifico: null,
        valorProdutoMensal:
            map['produtosSugeridos'][0]['valorProduto'] as double,
        valorPlanoMensal: map['planoRecorrencia']['valorMensal'] as double,
        fidelidadeDuracaoPlano: map['planoRecorrencia']['duracaoPlano'] as int,
        bolsa: map['bolsa'] as bool,
        obrigatorio: map['produtosSugeridos'][0]['obrigatorio'] as bool,
        valor: map['produtoContrato']['valorFinal'] as double,
        produtoDescricao:
            map['produtosSugeridos'][1]['produto']['descricao'] as String,
        percentualMultaCancelamento:
            map['percentualMultaCancelamento'] as double,
        vigenciaDe: DateTime.fromMicrosecondsSinceEpoch(map['vigenciaDe']),
        vigenciaAte: DateTime.fromMicrosecondsSinceEpoch(map['vigenciaAte']),
        ingressoAte: DateTime.fromMicrosecondsSinceEpoch(map['ingressoAte']),
      );
    } else
      return Plano(
        produtos: map['produtosSugeridos'] != null
            ? List<Produto>.from(
                map['produtosSugeridos']?.map((x) => Produto.fromMapPlano(x)))
            : null,
        valorFinal: map['valorFinal'] != null ? map['valorFinal'] : null,
        nrParcelas: map['nrParcelas'] != null ? map['nrParcelas'] : null,
        codigo: map['codigo'],
        modalidades: List<ModalidadePlano>.from(
                map['modalidades']?.map((x) => ModalidadePlano.fromMap(x)))
            .toList(),
        descricao: map['descricao'] as String,
        bolsa: map['bolsa'] as bool,
        obrigatorio: map['produtosSugeridos'][0]['obrigatorio'] as bool,
        tipoPlano: map['tipoPlano'] as String,
        fidelidadeDuracaoPlano: map['planoRecorrencia']['duracaoPlano'] as int,
        taxaAdesao: map['planoRecorrencia']['taxaAdesao'] as double,
        valorAnuidade: map['planoRecorrencia']['valorAnuidade'] as double,
        horario: map['horarios'][0]["horario"]["descricao"] as String,
        produtoDescricao:
            map['produtosSugeridos'][1]['produto']['descricao'] as String,
        valorPlanoMensal: map['planoRecorrencia']['valorMensal'] as double,
        valorProdutoMensal:
            map['produtosSugeridos'][0]['valorProduto'] as double,
        horarioValorEspecifico: map['horarios'][0]['valorEspecifico'] as double,
        percentualMultaCancelamento:
            map['percentualMultaCancelamento'] as double,
        valor: map['produtoContrato']['valorFinal'] as double,
        vigenciaDe: DateTime.fromMicrosecondsSinceEpoch(map['vigenciaDe']),
        vigenciaAte: DateTime.fromMicrosecondsSinceEpoch(map['vigenciaAte']),
        ingressoAte: DateTime.fromMicrosecondsSinceEpoch(map['ingressoAte']),
      );
  }

  String toJson() => json.encode(toMap());

  factory Plano.fromJson(String source) => Plano.fromMap(json.decode(source));
}
