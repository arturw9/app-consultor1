import 'dart:convert';
import 'dart:core';

import 'package:app_consultor/modelos/Produto.dart';

class Venda {
  DateTime? dataInicioVendaProdutos;
  int unidade;
  int? plano;
  String nome;
  String cpf;
  DateTime? diaVencimento;
  String? dataInicio;
  String? dataLancamento;
  int? nrVezesDividir = 1;
  List<Produto>? produtos;
  Venda({
    required this.unidade,
    required this.plano,
    required this.nome,
    required this.cpf,
    required this.diaVencimento,
    required this.nrVezesDividir,
    required this.produtos,
    this.dataInicio,
    this.dataLancamento,
  });

  Map<String, dynamic> toMap() {
    return {
      'dataInicioVendaProdutos': dataInicioVendaProdutos != null
          ? dataInicioVendaProdutos!.millisecondsSinceEpoch
          : null,
      'unidade': unidade,
      'plano': plano != null ? plano : null,
      'nome': nome,
      'cpf': cpf,
      "sexo": null,
      "dataNascimento": null,
      "responsavelPai": null,
      "responsavelMae": null,
      "email": null,
      "numeroCartao": null,
      "nomeCartao": null,
      "cvv": null,
      "validade": null,
      "telefone": null,
      "endereco": null,
      "numero": null,
      "bairro": null,
      "complemento": null,
      "cep": null,
      'diaVencimento': diaVencimento?.millisecondsSinceEpoch,
      'nrVezesDividir': nrVezesDividir,
      "numeroCupomDesconto": null,
      "cpftitularcard": null,
      "vencimentoFatura": 5,
      'produtos': produtos?.map((x) => x.toMap()).toList(),
      "cobrarParcelasEmAberto": true,
      "dataInicioContrato": dataInicio,
      "dataLancamento": dataLancamento,
      "aulasMarcadas": []
    };
  }

  factory Venda.fromMap(Map<String, dynamic> map) {
    return Venda(
      unidade: map['unidade'],
      plano: map['plano'] != null ? map['plano'] : null,
      nome: map['nome'],
      cpf: map['cpf'],
      diaVencimento: map['diaVencimento'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['diaVencimento'])
          : null,
      nrVezesDividir:
          map['nrVezesDividir'] != null ? map['nrVezesDividir'] : null,
      produtos: map['produtos'] != null
          ? List<Produto>.from(map['produtos']?.map((x) => Produto.fromMap(x)))
          : null,
      dataInicio: map['dataInicio'],
      dataLancamento: map['datalancamento'],
    );
  }

  dynamic toJson() => json.encode(toMap());

  factory Venda.fromJson(String source) => Venda.fromMap(json.decode(source));
}
