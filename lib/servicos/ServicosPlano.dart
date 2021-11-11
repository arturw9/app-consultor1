import 'package:app_consultor/controladores/ControladorUsuario.dart';

import 'package:app_consultor/util/RetornoApiFecharVenda.dart';
import 'package:app_consultor/util/RetornoApiModalidade.dart';
import 'package:app_consultor/util/RetornoApiPlano.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();

class ServicosPlano {
  Future<RetornoApiPlano> pesquisaPlanos(
      {String plano = "", String pagina = "0", required Function erro}) async {
    //aceita o parametro de pesquisa e o valor da pagina atual
    String filterJson =
        '{"quicksearchValue": "$plano" ,"tipo":["recorrencia"],"status":["true"]}';

    var urlPesquisa = Uri.encodeFull(filterJson);
    var url = Uri.parse(dotenv.env['urlBuscaPlano'].toString() +
        "page=$pagina&size=20&filters=$urlPesquisa");
    var response = await http.get(url, headers: {
      'Authorization': _controladorUsuario.usuario.token.toString(),
      'empresaId': _controladorUsuario.usuario.unidade!.codigo.toString(),
    }).timeout(Duration(seconds: 10));
    if (response.statusCode == 401) {
      try {
        GetIt.I.get<ControladorUsuario>().autenticarUsuario(erro: (erro) {
          throw (erro);
        }, sucesso: () {
          pesquisaPlanos(erro: () {});
        });
      } catch (e) {
        throw (e);
      }
    }
    return RetornoApiPlano.fromJson(response.body);
  }

  Future<RetornoApiFecharVenda> fecharVenda(int plano) async {
    var url = Uri.parse(
        "${dotenv.env['urlFecharVenda']}${_controladorUsuario.usuario.key}/simular/$plano/${_controladorUsuario.usuario.unidade!.codigo.toString()}");
    var response = await http.post(url).timeout(Duration(seconds: 10));

    return RetornoApiFecharVenda.fromJson(response.body);
  }

  static Future<RetornoApiModalidade> pesquisaModalidades(
      String modalidade) async {
    String filterJson = '{"quicksearchValue": "$modalidade" }';
    var urlPesquisa = Uri.encodeFull(filterJson);
    var url = Uri.parse(
        "http://swarm-42.pactosolucoes.com.br:8310/modalidades/only-cod-name?filters=$urlPesquisa");
    var response = await http.get(url, headers: {
      'Authorization': _controladorUsuario.usuario.token.toString(),
      'empresaId': _controladorUsuario.usuario.unidade!.codigo.toString(),
    });
    return RetornoApiModalidade.fromJson(response.body);
  }
}
