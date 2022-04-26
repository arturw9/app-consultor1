import 'dart:convert';

import 'package:app_consultor/controladores/ControladorUsuario.dart';

import 'package:app_consultor/modelos/Cliente.dart';

import 'package:app_consultor/util/RetornoApiAluno.dart';
import 'package:app_consultor/util/RetornoApiCliente.dart';
import 'package:app_consultor/util/RetornoApiContratoColaborador.dart';
import 'package:app_consultor/util/RetornoApiDetalAluno.dart';
import 'package:app_consultor/util/RetornoApiVinculoColaborador.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();

class ServicosCliente {
  Future<RetornoApiAluno> pesquisaAlunos(
      {String nome = "", int pagina = 0}) async {
    //  //aceita o parametro de pesquisa do aluno
    String filterJson = '{"quicksearchValue": "$nome" }';

    var urlPesquisa = Uri.encodeFull(filterJson);
    var clienteMsUrl =
        GetIt.I.get<ControladorUsuario>().urlsServicos.clienteMsUrl;
    var url = Uri.parse(
        "$clienteMsUrl/clientes?page=$pagina&size=20&filters=$urlPesquisa");
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
    var clienteMsUrl =
        GetIt.I.get<ControladorUsuario>().urlsServicos.clienteMsUrl;
    var url = Uri.parse("$clienteMsUrl/clientes/incluirCliente");

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

  static Future<RetornoApiDetalAluno> obterAluno(int id) async {
    var clienteMsUrl =
        GetIt.I.get<ControladorUsuario>().urlsServicos.clienteMsUrl;
    var url = Uri.parse("$clienteMsUrl/clientes/$id");
    var response = await http.get(url, headers: {
      'Authorization': _controladorUsuario.usuario.token.toString(),
    }).timeout(Duration(seconds: 10));
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

  static Future<RetornoApiVinculoColaborador> obterVinculo(int id) async {
    int pagina = 0;
    var clienteMsUrl =
        GetIt.I.get<ControladorUsuario>().urlsServicos.clienteMsUrl;
    var url =
        Uri.parse("$clienteMsUrl/vinculos?page=$pagina&size=10&cliente=$id");
    var response = await http.get(url, headers: {
      'Authorization': _controladorUsuario.usuario.token.toString(),
    }).timeout(Duration(seconds: 10));
    if (response.statusCode == 401) {
      try {
        GetIt.I.get<ControladorUsuario>().autenticarUsuario(erro: (erro) {
          throw (erro);
        }, sucesso: () {
          obterVinculo(id);
        });
      } catch (e) {
        throw (e);
      }
    }
    return RetornoApiVinculoColaborador.fromJson(response.body);
  }

  static Future<RetornoApiContratoColaborador> obterContratos(int id) async {
    ControladorUsuario controlador = GetIt.I.get<ControladorUsuario>();
    int pagina = 0;
    var chaveAcad = controlador.usuario.key;
    var apiZwUrl = GetIt.I.get<ControladorUsuario>().urlsServicos.apiZwUrl;
    var url = Uri.parse(
        "$apiZwUrl/cliente/$chaveAcad/consultarContratos?cliente=$id&registros=$pagina");

    var response = await http.post(url, headers: {
      'Authorization': _controladorUsuario.usuario.token.toString(),
    }).timeout(Duration(seconds: 10));
    if (response.statusCode == 401) {
      try {
        GetIt.I.get<ControladorUsuario>().autenticarUsuario(erro: (erro) {
          throw (erro);
        }, sucesso: () {
          obterContratos(id);
        });
      } catch (e) {
        throw (e);
      }
    }
    return RetornoApiContratoColaborador.fromJson(response.body);
  }
}
