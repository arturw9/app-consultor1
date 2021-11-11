import 'dart:convert';
import 'package:app_consultor/modelos/Aluno.dart';
import 'package:app_consultor/modelos/Cliente.dart';
import 'package:app_consultor/modelos/UrlsServicos.dart';
import 'package:app_consultor/modelos/Usuario.dart';
import 'package:app_consultor/servicos/ServicosCliente.dart';
import 'package:app_consultor/servicos/ServicosUsuarioLogin.dart';
import 'package:get_it/get_it.dart';

import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Mobx
//Usa o storage do Mobx(https://pub.dev/packages/mobx)
class ControladorUsuario with Store {
  Future<SharedPreferences> _prefs = SharedPreferences
      .getInstance(); // usando a dependencia SharedPreference pequeno banco d dados , verifica se o usuario esta ou nao no banco

  ServicoUsuarioLogin servicosUsuarioLogin = GetIt.I.get<ServicoUsuarioLogin>();
  ServicosCliente servicoPersonagem = GetIt.I.get<ServicosCliente>();

  Usuario usuarioLogado = Usuario(email: "", senha: "");
  Usuario usuario = Usuario(email: "", senha: "");
  UrlsServicos urlsServicos = UrlsServicos();
  // Usuario get usuario {
  //   _prefs.then((db) {
  //     var usuarioJson = db.getString("user");
  //     return Usuario.fromJson(JsonCodec().decode(usuarioJson.toString()));
  //   });

  // }

  // void set usuario(Usuario user) {
  //   usuario = user;
  //   _prefs.then((db) {
  //     db.setString("user", JsonCodec().encode(usuario.retorno.toJson()));
  //     usuarioLogado = usuario.retorno;
  //   });
  // }

  void verificarSeTemUsuario(
      {Function()? temUsuario, Function()? naoTemUsuario}) {
    _prefs.then((db) {
      //SharedPreference pequeno banco de dados(https://pub.dev/packages/shared_preferences)
      // db.remove("user"); //apaga usuario de dentro do banco local
      var usuarioJson = db
          .getString("user"); // verifica se no banco de dados existe um usuario
      if (usuarioJson != null) {
        usuarioLogado = Usuario.fromJson(JsonCodec().decode(usuarioJson));
        usuario =
            usuarioLogado; //Um JsonCodec codifica objetos JSON em strings e decodifica strings em objetos JSON.
        temUsuario?.call();
      } else {
        naoTemUsuario
            ?.call(); //validando se é nulo ou nao para cair na chamado do call
      }
    });
  }

  void autenticarUsuario(
      {Function()? sucesso, Function(String mensagem)? erro}) {
    servicosUsuarioLogin.autentificarUsuario(usuario).then((retorno) {
      //chama o autenticar usuario do serviço de login
      usuario.token = retorno.token; //captura o token
      servicosUsuarioLogin
          .listarUrls(usuario.key.toString()) //chama o serviço de listarUrls
          .then((retorno) => urlsServicos = retorno)
          .catchError(
              (onError) => erro?.call("Urls de serviço não encontrados!"));
      _prefs.then((db) {
        //salva o usuario atual no prefs
        db.setString("user", JsonCodec().encode(usuario.toJson()));
        usuarioLogado = usuario;
      });
      sucesso?.call();
    }).catchError((onError) {
      erro?.call("Usuário ou senha estão incorretos!");
    });
  }

  void logarUsuario({Function()? sucesso, Function(String mensagem)? erro}) {
    if ((usuario.email.isEmpty) || (usuario.senha.isEmpty)) {
      //realiza a validação dos dados que o usuario informa
      erro?.call("Usuário ou senha inválidos!");
    } else {
      servicosUsuarioLogin //chama o serviço de logar o usuario
          .logarUsuario(
        usuario.email
            .toString()
            .toLowerCase()
            .trim(), //formata o email retirando os espaços em branco e colacando em lowerCase
        usuario.senha.toString(),
      )
          .then((retorno) {
        usuario.key = retorno.key;
        usuario.nome = retorno.nome;
        usuario.urlFoto = retorno.urlFoto;
        usuario.userName = retorno.userName;
        usuario.listaUnidades = retorno.listaUnidades;
        sucesso?.call();
      }).catchError((onError) {
        erro?.call("Usuário ou senha estão incorretos!");
      });
    }
  }

  void cadastrarCliente(Cliente clienteCadastrar,
      {Function(Aluno aluno)? sucesso, Function(String mensagem)? erro}) {
    // if (clienteCadastrar.cpf.toString().trim() ==
    //     clienteCadastrar.cpf.toString().trim()) {
    //   erro?.call("CPF já cadastrado!");
    if ((clienteCadastrar.celular.toString().isEmpty) ||
        (clienteCadastrar.imageUri.toString().isEmpty) ||
        (clienteCadastrar.cep.toString().isEmpty) ||
        (clienteCadastrar.email.toString().isEmpty) ||
        (clienteCadastrar.cpf.toString().isEmpty) ||
        (clienteCadastrar.dataNascimento.toString().isEmpty) ||
        (clienteCadastrar.nome.toString().isEmpty)) {
      // realiza a validação dos dados que o usuario informa
      erro?.call("Cadastro Inválido!");
    } else {
      servicoPersonagem.cadastroCliente(clienteCadastrar).then((aluno) {
        sucesso?.call(aluno.aluno);
      }).catchError((onError) {
        erro?.call(onError);
      });
    }
  }

  void logoutUsuario({Function()? deslogar}) {
    _prefs.then((db) {
      db.remove("user");
      usuarioLogado = Usuario(email: "", senha: "");
      usuario = Usuario(email: "", senha: "");
      deslogar!(); //apaga usuario de dentro do banco local
    });
  }
}
