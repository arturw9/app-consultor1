import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/util/RetornoApiProduto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();

class ServicosProduto {
  Future<RetornoApiProduto> pesquisaProdutos(
      {String produto = "", int pagina = 0}) async {
    //aceita o parametro de pesquisa
    String filterJson = '{"quicksearchValue": "$produto" }';

    var urlPesquisa = Uri.encodeFull(filterJson);
    var url = Uri.parse(
        "${dotenv.env['urlBuscaProd']}page=$pagina&size=20&filters=$urlPesquisa");
    var response = await http.get(url, headers: {
      'Authorization': _controladorUsuario.usuario.token.toString(),
      'empresaId': _controladorUsuario.usuario.unidade!.codigo.toString(),
    });
       if (response.statusCode == 401) {
      try {
        GetIt.I.get<ControladorUsuario>().autenticarUsuario(erro: (erro) {
          throw (erro);
        }, sucesso: () {
         pesquisaProdutos(produto: produto, pagina: pagina);
        });
      } catch (e) {
        throw (e);
      }
    }
    return RetornoApiProduto.fromJson(response.body);
  }
}
