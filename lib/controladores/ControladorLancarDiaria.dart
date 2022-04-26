import 'package:app_consultor/modelos/Aluno.dart';
import 'package:app_consultor/modelos/Modalidade.dart';
import 'package:app_consultor/modelos/Produto.dart';
import 'package:flutter/material.dart';

//armazena dados que serão exibidos na tela de laçar diaria
class ControladorLancarDiaria {
  Aluno? aluno;
  Produto? produto;
  Modalidade? modalidade;
  DateTime? dataInicio;
  DateTime? lancamento;
  ValueNotifier<int> numProd = ValueNotifier(0);
  var listaProdutos = <Produto>[];
  ControladorLancarDiaria({
    this.aluno,
    this.produto,
    this.modalidade,
    this.dataInicio,
    this.lancamento,
  });
}
