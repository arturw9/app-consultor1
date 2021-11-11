import 'dart:convert';

import 'package:app_consultor/modelos/Telefone.dart';
import 'package:app_consultor/util/EnumSituacao.dart';
import 'package:flutter/foundation.dart';

class Aluno {
  int? codigo;
  String? matricula;
  String? nome;
  String? cpf;
  String? imageUri;
  tipoSituacao? situacao;
  tipoSituacao? situacaoContrato;
  List<Telefone>? telefones;
  List<String>? emails;
  DateTime? dataNascimento;
  List<String>? avisos;
  List<String>? observacoes;

  Aluno({
    this.codigo,
    this.matricula,
    this.nome,
    this.cpf,
    this.imageUri,
    this.situacao,
    this.situacaoContrato,
    this.telefones, //
    this.emails, //
    this.dataNascimento,
    this.avisos,
    this.observacoes, //
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'matricula': matricula,
      'nome': nome,
      'imageUri': imageUri,
      'situacao': situacao,
      'cpf': cpf,
      'situacaoContrato': situacaoContrato,
      'telefones': telefones,
      'email': emails,
      'dataNascimento': dataNascimento?.millisecondsSinceEpoch,
      'avisos': avisos,
      'observacoes': observacoes,
    };
  }

  factory Aluno.fromMap(Map<String, dynamic> map) {
    tipoSituacao strToTipoEnum(String str) {
      str = str.toLowerCase();
      if (str == 'visitante_normal') str = 'visitante';
      tipoSituacao tipo =
          tipoSituacao.values.firstWhere((e) => describeEnum(e) == str);
      return tipo;
    }

    return Aluno(
      codigo: map['codigo'],
      matricula: map['matricula'] != null ? map['matricula'] : null,
      nome: map['nome'] != null ? map['nome'] : null,
      cpf: map['cpf'] != null ? map['cpf'] : null,
      imageUri: map['imageUri'] != null ? map['imageUri'] : null,
      situacao: map['situacao'] != null ? strToTipoEnum(map['situacao']) : null,
      situacaoContrato: map['situacaoContrato'] != null
          ? strToTipoEnum(map['situacaoContrato'])
          : null,
      telefones: map['telefones'] != null
          ? List<Telefone>.from(
              map['telefones']?.map((x) => Telefone.fromMap(x)))
          : null,
      emails: map['emails'] != null
          ? List<String>.from(map['emails'].map((x) => x.toString()))
          : null,
      dataNascimento: map['dataNascimento'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dataNascimento'])
          : null,
      avisos: map['avisos'] != null
          ? List<String>.from(
              map['avisos'].map((x) => x['mensagem'].toString()))
          : null,
      observacoes: map['observacoes'] != null
          ? List<String>.from(
              map['observacoes'].map((x) => x['mensagem'].toString()))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Aluno.fromJson(String source) => Aluno.fromMap(json.decode(source));
}
