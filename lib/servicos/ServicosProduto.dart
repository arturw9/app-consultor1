import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/util/RetornoApiProduto.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();

class ServicosProduto {
  Future<RetornoApiProduto> pesquisaProdutos(
      {String produto = "", int pagina = 0, bool diaria = false}) async {
    //aceita o parametro de pesquisa
    String filterJson =
        '{"quicksearchValue": "$produto", "classeProdutos" : "VENDAS" }';
    var planoMsUrl =
        GetIt.I.get<ControladorUsuario>().urlsServicos.planoMsUrl.toString();

    var urlPesquisa;
    var response;
    if (!diaria) {
      urlPesquisa = Uri.encodeFull(filterJson);
      var url = Uri.parse(
          "$planoMsUrl/produtos?page=$pagina&size=20&filters=$urlPesquisa");
      // "http://10.33.82.101:8018/produtos?page=$pagina&size=20&filters=$urlPesquisa");
      response = await http.get(url, headers: {
        'Authorization': _controladorUsuario.usuario.token.toString(),
        'empresaId': _controladorUsuario.usuario.unidade!.codigo.toString(),
      });
    } else {
      filterJson = '{"tipoProduto":"DI"}';
      urlPesquisa = Uri.encodeFull(filterJson);
      var url = Uri.parse(
          "$planoMsUrl/produtos?page=$pagina&size=20&filters=$urlPesquisa");
      // "http://10.33.82.101:8018/produtos?page=$pagina&size=20&filters=$urlPesquisa");
      response = await http.get(url, headers: {
        'Authorization': _controladorUsuario.usuario.token.toString(),
      });
    }

    if (response.statusCode == 401) {
      try {
        GetIt.I.get<ControladorUsuario>().autenticarUsuario(erro: (erro) {
          throw (erro);
        }, sucesso: () {
          pesquisaProdutos(produto: produto, pagina: pagina, diaria: diaria);
        });
      } catch (e) {
        throw (e);
      }
    }
    return RetornoApiProduto.fromJson(response.body);
  }

  Future<RetornoApiProduto> pesquisaDiaria(
      {String produto = "", int pagina = 0}) async {
    //aceita o parametro de pesquisa
    String filterJson = '{"tipoProduto":"DI"}';

    var urlPesquisa = Uri.encodeFull(filterJson);
    var planoMsUrl =
        GetIt.I.get<ControladorUsuario>().urlsServicos.planoMsUrl.toString();
    var url = Uri.parse(
        "$planoMsUrl/produtos?page=$pagina&size=20&filters=$urlPesquisa");
    var response = await http.get(url, headers: {
      'Authorization': _controladorUsuario.usuario.token.toString(),
    });
    if (response.statusCode == 401) {
      try {
        GetIt.I.get<ControladorUsuario>().autenticarUsuario(erro: (erro) {
          throw (erro);
        }, sucesso: () {
          pesquisaDiaria(produto: produto, pagina: pagina);
        });
      } catch (e) {
        throw (e);
      }
    }
    return RetornoApiProduto.fromJson(response.body);
  }
}
