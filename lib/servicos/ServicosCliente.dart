import 'dart:convert';

import 'package:app_consultor/controladores/ControladorUsuario.dart';

import 'package:app_consultor/modelos/Cliente.dart';
import 'package:app_consultor/util/RetornoApiAluno.dart';
import 'package:app_consultor/util/RetornoApiCliente.dart';
import 'package:app_consultor/util/RetornoApiDetalAluno.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();

class ServicosCliente {
  Future<RetornoApiAluno> pesquisaAlunos(
      {String nome = "", int pagina = 0}) async {
    //  //aceita o parametro de pesquisa do aluno
    String filterJson = '{"quicksearchValue": "$nome" }';

    var urlPesquisa = Uri.encodeFull(filterJson);
    var url = Uri.parse(
        "http://swarm-42.pactosolucoes.com.br:8314/clientes?page=$pagina&size=20&filters=$urlPesquisa");
    var response = await http.get(url, headers: {
      'Authorization': _controladorUsuario.usuario.token.toString(),
      'empresaId': _controladorUsuario.usuario.unidade!.codigo.toString(),
    });
    if (response.statusCode == 401) {
      try {
        GetIt.I.get<ControladorUsuario>().autenticarUsuario(erro: (erro) {
          throw (erro);
        }, sucesso: () {
          pesquisaAlunos(nome: nome, pagina: pagina);
        });
      } catch (e) {
        throw (e);
      }
    }
    return RetornoApiAluno.fromJson(response.body);
  }

  Future<RetornoApiCliente> cadastroCliente(Cliente cliente) async {
    var url = Uri.parse(
        "http://swarm-42.pactosolucoes.com.br:8314/clientes/incluirCliente");

    var response = await http.post(url, body: cliente.toJson(), headers: {
      'Authorization': _controladorUsuario.usuario.token.toString(),
      'empresaId': _controladorUsuario.usuario.unidade!.codigo.toString(),
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 401) {
      try {
        GetIt.I.get<ControladorUsuario>().autenticarUsuario(erro: (erro) {
          throw (erro);
        }, sucesso: () {
          cadastroCliente(cliente);
        });
      } catch (e) {
        throw (e);
      }
    }
    if (response.statusCode == 200) {
      return RetornoApiCliente.fromJson(response.body);
    } else {
      String erro = jsonDecode(response.body)['meta']['message'];
      throw (erro);
    }
  }

  Future<RetornoApiDetalAluno> obterAluno(int id) async {
    //  //aceita o parametro de pesquisa do aluno

    var url =
        Uri.parse("http://swarm-42.pactosolucoes.com.br:8314/clientes/$id");
    var response = await http.get(url, headers: {
      'Authorization': _controladorUsuario.usuario.token.toString(),
    });
    if (response.statusCode == 401) {
      try {
        GetIt.I.get<ControladorUsuario>().autenticarUsuario(erro: (erro) {
          throw (erro);
        }, sucesso: () {
          obterAluno(id);
        });
      } catch (e) {
        throw (e);
      }
    }
    return RetornoApiDetalAluno.fromJson(response.body);
  }
}
