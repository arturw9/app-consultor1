import 'package:flutter/material.dart';

import 'package:app_consultor/modelos/Produto.dart';
import 'package:app_consultor/servicos/ServicosProduto.dart';
import 'package:app_consultor/util/EnumPesquisaEstado.dart';

class ControladorPesquisaProdutos {
  bool diaria;
  ServicosProduto servicosProduto = ServicosProduto();
  List<Produto>? listaProduto;
  int paginasTotal = 0; //recebe o valor de paginas total da api
  int paginaAtual = -1; //armazena a pagina atual começando da primeira
  ControladorPesquisaProdutos({required this.diaria});
  final pesquisaEstado =
      ValueNotifier<PesquisaEstado>(PesquisaEstado.carregarConteudo);
  Future pesquisaProdutos({String produto = ""}) async {
    //realiza a busca do produto, caso o produto esteja vazio, somente lista os produtos
    pesquisaEstado.value = PesquisaEstado.carregando;
    servicosProduto
        .pesquisaProdutos(produto: produto.toLowerCase(), diaria: diaria)
        .then((retorno) {
      listaProduto = retorno.listaProdutos;
      paginasTotal = retorno.totalPages;
      paginaAtual = 1; //incrementa a pagina atual
      pesquisaEstado.value =
          listaProduto!.length < 1 //caso o resultado venha vazio, retorna erro
              ? PesquisaEstado.erro
              : PesquisaEstado.sucesso;
    }).catchError((mensagem) {
      pesquisaEstado.value = PesquisaEstado.erro;
    });
  }

  Future carregaProdutos({
    String plano = "",
  }) async {
    pesquisaEstado.value = PesquisaEstado.novoConteudo;
    servicosProduto
        .pesquisaProdutos(
            produto: plano.toLowerCase(), pagina: paginaAtual, diaria: diaria)
        .then((retorno) {
      listaProduto!.addAll(retorno.listaProdutos!.toList());
      paginasTotal = retorno.totalPages;
      pesquisaEstado.value = listaProduto!.length < 1
          ? PesquisaEstado.erro
          : PesquisaEstado.sucesso;
      paginaAtual++;
    }).catchError((mensagem) {
      pesquisaEstado.value = PesquisaEstado.sucesso;
    });
  }
}
