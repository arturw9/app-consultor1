import 'package:app_consultor/modelos/Aluno.dart';
import 'package:app_consultor/modelos/Plano.dart';
import 'package:app_consultor/modelos/Produto.dart';
import 'package:flutter/material.dart';

//armazena dados que serão exibidos no carrinho
class ControladorCarrinho {
  Aluno? aluno;
  Plano? plano;
  double totalProdutos = 0;
  ValueNotifier<int> numProd = ValueNotifier(0);
  var listaProdutos = <Produto>[];
  var listaProdutosPlano = <Produto>[];
  ControladorCarrinho({
    this.aluno,
    this.plano,
  });
  void limparCarrinho() {
    aluno = null;
    plano = null;
    totalProdutos = 0;
    numProd.value = 0;
    listaProdutos = <Produto>[];
  }
}
