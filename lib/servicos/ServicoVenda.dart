import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/modelos/Venda.dart';
import 'package:app_consultor/util/RetornoApiAluno.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

//não funcionando
class ServicoVenda {
  static Future<RetornoApiAluno> concluirVenda(Venda venda) async {
    //  //aceita o parametro de pesquisa do aluno
    ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
    final body = venda.toJson();
    var url = Uri.parse(
        "${dotenv.env['urlConcluirVenda']}${_controladorUsuario.usuario.key}");
    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
      'Authorization': _controladorUsuario.usuario.token.toString(),
    });

    return RetornoApiAluno.fromJson(response.body);
  }
}
