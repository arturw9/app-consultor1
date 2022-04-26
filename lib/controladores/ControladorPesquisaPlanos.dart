import 'package:app_consultor/modelos/Plano.dart';
import 'package:app_consultor/servicos/ServicosPlano.dart';
import 'package:app_consultor/util/EnumPesquisaEstado.dart';
import 'package:flutter/material.dart';

class ControladorPesquisaPlanos {
  ServicosPlano servicosPlano = ServicosPlano();
  List<Plano>? listaPlano;
  int paginasTotal = 0; //recebe o valor de paginas total da api
  int paginaAtual = -1; //armazena a pagina atual começando da primeira
  final pesquisaEstado =
      ValueNotifier<PesquisaEstado>(PesquisaEstado.carregarConteudo);

  Future pesquisaPlano({String plano = ""}) async {
    //pesquisa o plano, caso não informado somente lista os planos
    pesquisaEstado.value = PesquisaEstado.carregando;
    servicosPlano
        .pesquisaPlanos(
            plano: plano.toLowerCase(),
            erro: () => pesquisaEstado.value = PesquisaEstado.erro)
        .then((retorno) {
      listaPlano = retorno.listaPlano;
      paginasTotal = retorno.totalPages;
      paginaAtual = 1; //incrementa a pagina atual
      pesquisaEstado.value = listaPlano!.length < 1
          ? PesquisaEstado.erro
          : PesquisaEstado.sucesso; //caso vazio o resultado informa erro
    }).catchError((mensagem) {
      pesquisaEstado.value = PesquisaEstado.erro;
    });
  }

//incrementa outra pagina na lista de planos
  Future carregaPlanos({
    String plano = "",
  }) async {
    pesquisaEstado.value = PesquisaEstado.novoConteudo;
    servicosPlano
        .pesquisaPlanos(
            plano: plano.toLowerCase(),
            pagina: paginaAtual.toString(),
            erro: () => pesquisaEstado.value = PesquisaEstado.erro)
        .then((retorno) {
      listaPlano!.addAll(retorno.listaPlano);
      paginasTotal = retorno.totalPages;
      pesquisaEstado.value =
          listaPlano!.length < 1 ? PesquisaEstado.erro : PesquisaEstado.sucesso;
      paginaAtual++;
    }).catchError((mensagem) {
      pesquisaEstado.value = PesquisaEstado.sucesso;
    });
  }
}
