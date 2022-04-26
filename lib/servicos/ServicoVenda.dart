import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/modelos/Venda.dart';
import 'package:app_consultor/util/RetornoApiConcluirVenda.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

//não funcionando
class ServicoVenda {
  static Future<Null> concluirVenda(Venda venda) async {
    ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
    var zwApiUrl = _controladorUsuario.urlsServicos.apiZwUrl.toString();
    var chave = _controladorUsuario.usuario.key;

    final body = venda.toJson();
    var url = Uri.parse("$zwApiUrl/v2/vendas/$chave/consultor/venda");
    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
    });

    var vendaFinal = VendaConcluida.fromJson(response.body);
    var isError = vendaFinal.retorno.contains("ERRO");
    VendaConcluida.fromJson(response.body);

    if (isError) {
      RegExp exp = new RegExp(r'(?<=trigger:)(.*?)(?=\.)');
      String mensagem = "";
      var match = exp.firstMatch(vendaFinal.retorno);
      if (match != null) mensagem = match.group(0).toString();
      if (match == null) {
        exp = new RegExp(r'(?<=ERRO:)(.*?)(?=\.)');
        match = exp.firstMatch(vendaFinal.retorno);
        if (match != null) mensagem = match.group(0).toString();
      }
      if (match == null) {
        throw "Não foi possivel lançar o contrato para este aluno. Verifique o perfil do aluno no sistem Pacto.";
      } else {
        throw mensagem;
      }
    }
  }
}
