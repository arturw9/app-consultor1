import 'dart:convert';

import 'package:app_consultor/modelos/UrlsServicos.dart';
import 'package:app_consultor/modelos/Usuario.dart';
import 'package:app_consultor/util/RetornoAutenticacao.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:app_consultor/util/RetornoApiOAMD.dart';

//https://app.pactosolucoes.com.br/oamd/prest/usuarioapp/v2

//faz a checagem de email e senha na api de login e retorna os dados do usuario
class ServicoUsuarioLogin {
  Future<RetornoApiOAMD> logarUsuario(String email, String senha) async {
    var url;
    url = Uri.parse(
        "${dotenv.env['urlLogin']}email=$email&senha=$senha");
    var response = await http.post(url);
    return RetornoApiOAMD.fromJson(response.body);
  }

//lista as urls na api
  Future<UrlsServicos> listarUrls(String key) async {
    var url;
    url = Uri.parse("https://discovery.ms.pactosolucoes.com.br/find/$key");
    var response = await http.get(url);
    return UrlsServicos.fromJson(response.body);
  }

//autentica o usuario e retorna um token de acesso
  Future<RetornoAutenticacao> autentificarUsuario(Usuario user) async {
    var url = Uri.parse("${dotenv.env['urlAut']}");
    final body = {
      "chave": user.key,
      "username": user.userName,
      "senha": user.senha
    };
    var response = await http.post(url,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    return RetornoAutenticacao.fromJson(response.body);
  }
}
