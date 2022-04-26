import 'dart:convert';

import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/modelos/UrlsServicos.dart';
import 'package:app_consultor/modelos/Usuario.dart';
import 'package:app_consultor/util/RetornoApiHorarioAcesso.dart';
import 'package:app_consultor/util/RetornoAutenticacao.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:app_consultor/util/RetornoApiOAMD.dart';

class ServicoUsuarioLogin {
  Future<RetornoApiOAMD> logarUsuario(String email, String senha) async {
    ControladorUsuario controlador = GetIt.I.get<ControladorUsuario>();
    var oamdUrl = controlador.urlsServicos.oamdUrl.toString();
    var url = Uri.parse(
        "$oamdUrl/prest/usuarioapp/v2/loginEmpresaComEmail?email=$email&senha=$senha");
    var response = await http.post(url);
    return RetornoApiOAMD.fromJson(response.body);
  }

  Future<UrlsServicos> listarUrls(String key) async {
    var discoveryMsUrl = dotenv.env['urlDiscovery'];
    var url = Uri.parse("$discoveryMsUrl/find/$key");
    var response = await http.get(url);
    return UrlsServicos.fromJson(response.body);
  }

  Future<RetornoAutenticacao> autentificarUsuario(Usuario user) async {
    ControladorUsuario controlador = GetIt.I.get<ControladorUsuario>();
    var autenticacaoMsUrl = controlador.urlsServicos.autenticacaoUrl.toString();
    var url = Uri.parse("$autenticacaoMsUrl/aut/login");
    final body = {
      "chave": user.key,
      "username": user.userName,
      "senha": user.senha
    };
    var response = await http.post(url,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    return RetornoAutenticacao.fromJson(response.body);
  }

  Future<RetornoApiHorarioAcesso> buscarHorarioAcesso() async {
    ControladorUsuario controlador = GetIt.I.get<ControladorUsuario>();
    var zwUrl = controlador.urlsServicos.zwUrl;
    var usuario = controlador.usuario.codigoColaborador;
    var chaveAcad = controlador.usuario.key;
    var url = Uri.parse(
        "$zwUrl/prest/horarioacesso?chave=$chaveAcad&usuario=$usuario");
    var response =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    return RetornoApiHorarioAcesso.fromJson(response.body);
  }
}
