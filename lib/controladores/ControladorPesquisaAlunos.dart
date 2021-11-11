import 'package:app_consultor/modelos/Aluno.dart';
import 'package:app_consultor/servicos/ServicosCliente.dart';
import 'package:flutter/material.dart';
import 'package:app_consultor/util/EnumPesquisaEstado.dart';

class ControladorPesquisaAluno {
  ServicosCliente servicosCliente =
      ServicosCliente(); //chama os serviços de conexão com a API
  List<Aluno>? listaAluno;
  int paginasTotal = 0; //recebe o valor de paginas total da api
  int paginaAtual = -1; //armazena a pagina atual começando da primeira
  final pesquisaEstado = ValueNotifier<PesquisaEstado>(PesquisaEstado
      .carregando); //declara um valueNotifier que ira informar quando o componente deve ser rebuildado
  Future pesquisaAluno({String aluno = ""}) async {
    //realiza a busca do aluno, caso o nomeAluno esteja vazio, somente lista os alunos
    pesquisaEstado.value = PesquisaEstado.carregando;
    servicosCliente.pesquisaAlunos(nome: aluno.toLowerCase()).then((retorno) {
      listaAluno = retorno.listaAluno;
      paginasTotal = retorno.totalPages;
      paginaAtual = 1; //incrementa a pagina atual
      pesquisaEstado.value = listaAluno!.isEmpty
          ? PesquisaEstado.erro
          : PesquisaEstado.sucesso; //caso a lista venha vazia informa erro
    }).catchError((mensagem) {
      pesquisaEstado.value = PesquisaEstado.erro;
    });
  }

  Future carregaAlunos({
    String aluno = "",
  }) async {
    pesquisaEstado.value = PesquisaEstado.novoConteudo;
    servicosCliente
        .pesquisaAlunos(
      nome: aluno.toLowerCase(),
      pagina: paginaAtual,
    )
        .then((retorno) {
      listaAluno!.addAll(retorno.listaAluno);
      paginasTotal = retorno.totalPages;
      pesquisaEstado.value =
          listaAluno!.length < 1 ? PesquisaEstado.erro : PesquisaEstado.sucesso;
      paginaAtual++;
    }).catchError((mensagem) {
      pesquisaEstado.value = PesquisaEstado.sucesso;
    });
  }
}
