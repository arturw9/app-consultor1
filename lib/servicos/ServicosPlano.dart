import 'package:app_consultor/controladores/ControladorUsuario.dart';

import 'package:app_consultor/util/RetornoApiFecharVenda.dart';
import 'package:app_consultor/util/RetornoApiModalidade.dart';
import 'package:app_consultor/util/RetornoApiPlano.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();

class ServicosPlano {
  Future<RetornoApiPlano> pesquisaPlanos(
      {String plano = "", String pagina = "0", required Function erro}) async {
    String filterJson = '{"quicksearchValue": "$plano" ,"ativo":"true"}';
    var planoMsUrl =
        GetIt.I.get<ControladorUsuario>().urlsServicos.planoMsUrl.toString();
    var urlPesquisa = Uri.encodeFull(filterJson);
    var url = Uri.parse(
        planoMsUrl + "/planos?page=$pagina&size=20&filters=$urlPesquisa");
    var response = await http.get(url, headers: {
      'Authorization': _controladorUsuario.usuario.token.toString(),
      'empresaId': _controladorUsuario.usuario.unidade!.codigo.toString(),
    }).timeout(Duration(seconds: 10));
    if (response.statusCode == 401) {
      try {
        GetIt.I.get<ControladorUsuario>().autenticarUsuario(erro: (erro) {
          throw (erro);
        }, sucesso: () {
          pesquisaPlanos(
            plano: plano,
            erro: erro,
            pagina: pagina,
          );
        });
      } catch (e) {
        throw (e);
      }
    }
    return RetornoApiPlano.fromJson(response.body);
  }

  Future<RetornoApiFecharVenda> fecharVenda(int plano) async {
    var zwApiUrl =
        GetIt.I.get<ControladorUsuario>().urlsServicos.apiZwUrl.toString();
    var chave = _controladorUsuario.usuario.key;
    var empresa = _controladorUsuario.usuario.unidade!.codigo.toString();
    var url = Uri.parse("$zwApiUrl/v2/vendas/$chave/simular/$plano/$empresa");
    var response = await http.post(url).timeout(Duration(seconds: 10));

    return RetornoApiFecharVenda.fromJson(response.body);
  }

  static Future<RetornoApiModalidade> pesquisaModalidades(
      String modalidade) async {
    String filterJson = '{"quicksearchValue": "$modalidade" }';
    var urlPesquisa = Uri.encodeFull(filterJson);
    var planoMsUrl =
        GetIt.I.get<ControladorUsuario>().urlsServicos.planoMsUrl.toString();
    var url =
        Uri.parse("$planoMsUrl/modalidades/only-cod-name?filters=$urlPesquisa");
    var response = await http.get(url, headers: {
      'Authorization': _controladorUsuario.usuario.token.toString(),
      'empresaId': _controladorUsuario.usuario.unidade!.codigo.toString(),
    });
    return RetornoApiModalidade.fromJson(response.body);
  }
}
