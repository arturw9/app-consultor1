import 'package:app_consultor/modelos/Modalidade.dart';
import 'package:app_consultor/servicos/ServicosPlano.dart';
import 'package:app_consultor/util/EnumPesquisaEstado.dart';
import 'package:flutter/material.dart';

class ControladorPesquisaModalidades {
  List<Modalidade>? listaModalidade;
  final pesquisaEstado =
      ValueNotifier<PesquisaEstado>(PesquisaEstado.carregando);
  Future pesquisaModalidade({String modalidade = ""}) async {
    //pesquisa o plano, caso não informado somente lista os planos
    pesquisaEstado.value = PesquisaEstado.carregando;
    ServicosPlano.pesquisaModalidades(modalidade).then((retorno) {
      listaModalidade = retorno.modalidades;
      pesquisaEstado.value = listaModalidade!.length < 1
          ? PesquisaEstado.erro
          : PesquisaEstado.sucesso; //caso vazio o resultado informa erro
    }).catchError((mensagem) {
      pesquisaEstado.value = PesquisaEstado.erro;
    });
  }
}
