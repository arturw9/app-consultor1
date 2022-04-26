import 'dart:async';
import 'dart:convert';
import 'package:app_consultor/modelos/Aluno.dart';
import 'package:app_consultor/modelos/Cliente.dart';
import 'package:app_consultor/modelos/HorarioAcesso.dart';
import 'package:app_consultor/modelos/UrlsServicos.dart';
import 'package:app_consultor/modelos/Usuario.dart';
import 'package:app_consultor/servicos/ServicosCliente.dart';
import 'package:app_consultor/servicos/ServicosNavegacao.dart';
import 'package:app_consultor/servicos/ServicosUsuarioLogin.dart';
import 'package:app_consultor/util/UtilDialog.dart';
import 'package:get_it/get_it.dart';

import 'package:mobx/mobx.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControladorUsuario with Store {
  Future<SharedPreferences> _prefs = SharedPreferences
      .getInstance(); // usando a dependencia SharedPreference pequeno banco d dados , verifica se o usuario esta ou nao no banco

  ServicoUsuarioLogin servicosUsuarioLogin = GetIt.I.get<ServicoUsuarioLogin>();
  ServicosCliente servicoPersonagem = GetIt.I.get<ServicosCliente>();

  Usuario usuarioLogado = Usuario(email: "", senha: "");
  Usuario usuario = Usuario(email: "", senha: "");
  UrlsServicos urlsServicos = UrlsServicos();
  void verificarSeTemUsuario(
      {Function()? temUsuario,
      Function()? naoTemUsuario,
      Function(String mensagem)? erro}) {
    _prefs.then((db) {
      var usuarioJson = db.getString("user");
      if (usuarioJson != null) {
        usuarioLogado = Usuario.fromJson(JsonCodec().decode(usuarioJson));
        usuario = usuarioLogado;
        temUsuario?.call();
      } else {
        naoTemUsuario?.call();
      }
    }).catchError((err) {
      erro?.call("Algo deu errado, por favor realize o login novamente");
    });
  }

  void listarUrl({Function()? sucesso, Function(String mensagem)? erro}) {
    servicosUsuarioLogin
        .listarUrls(usuario.key != null ? usuario.key.toString() : "")
        .then((retorno) {
      sucesso!.call();
      urlsServicos = retorno;
    }).catchError((onError) => erro?.call("Urls de serviço não encontrados!"));
  }

  void autenticarUsuario(
      {Function()? sucesso, Function(String mensagem)? erro}) {
    servicosUsuarioLogin.autentificarUsuario(usuario).then((retorno) {
      usuario.token = retorno.token;
      servicosUsuarioLogin.buscarHorarioAcesso().then((horario) {
        usuario.horarioAcesso = horario.listaHorarioAcesso;
        _prefs.then((db) {
          db.setString("user", JsonCodec().encode(usuario.toJson()));
          usuarioLogado = usuario;
          sucesso?.call();
        });
      });
    }).catchError((onError) {
      erro?.call("Usuário ou senha estão incorretos!");
    });
  }

  void logarUsuario({Function()? sucesso, Function(String mensagem)? erro}) {
    if ((usuario.email.isEmpty) || (usuario.senha.isEmpty)) {
      erro?.call("Usuário ou senha inválidos!");
    } else {
      servicosUsuarioLogin
          .logarUsuario(
        usuario.email.toString().toLowerCase().trim(),
        usuario.senha.toString(),
      )
          .then((retorno) {
        usuario.key = retorno.key;
        usuario.nome = retorno.nome;
        usuario.urlFoto = retorno.urlFoto;
        usuario.userName = retorno.userName;
        usuario.listaUnidades = retorno.listaUnidades;
        usuario.codigoColaborador = retorno.codigoColaborador;
        listarUrl(sucesso: () => sucesso?.call(), erro: erro);
      }).catchError((onError) {
        erro?.call("Usuário ou senha estão incorretos!");
      });
    }
  }

  void cadastrarCliente(Cliente clienteCadastrar,
      {Function(Aluno aluno)? sucesso, Function(String mensagem)? erro}) {
    if ((clienteCadastrar.celular.toString().isEmpty) ||
        (clienteCadastrar.imageUri.toString().isEmpty) ||
        (clienteCadastrar.cep.toString().isEmpty) ||
        (clienteCadastrar.email.toString().isEmpty) ||
        (clienteCadastrar.cpf.toString().isEmpty) ||
        (clienteCadastrar.dataNascimento.toString().isEmpty) ||
        (clienteCadastrar.nome.toString().isEmpty)) {
      erro?.call("Cadastro Inválido!");
    } else {
      servicoPersonagem.cadastroCliente(clienteCadastrar).then((aluno) {
        sucesso?.call(aluno.aluno);
      }).catchError((onError) {
        erro?.call(onError);
      });
    }
  }

  static Future<DateTime> dateTimeAtual() async {
    DateTime horaAtual = await NTP.now().catchError((e) {
      return DateTime.now();
    });

    return horaAtual;
  }

  void estaDentroDoHorario({
    Function()? dentroHorario,
    Function()? foraHorario,
  }) async {
    DateTime agora = DateTime.now();
    await dateTimeAtual().then((hora) => agora = hora);
    HorarioAcesso horario = usuario.horarioAcesso!
        .firstWhere((element) => element.diaSemana == agora.weekday);
    DateTime horaInicial = new DateTime(
        agora.year,
        agora.month,
        agora.day,
        int.parse(horario.horaInicial.substring(0, 2)),
        int.parse(horario.horaInicial.substring(3, 5)),
        agora.second,
        agora.millisecond,
        agora.microsecond);
    DateTime horaFinal = new DateTime(
        agora.year,
        agora.month,
        agora.day,
        int.parse(horario.horaFinal.substring(0, 2)),
        int.parse(horario.horaFinal.substring(3, 5)),
        agora.second,
        agora.millisecond,
        agora.microsecond);
    if (horaInicial.isBefore(agora) && horaFinal.isAfter(agora)) {
      if (horaFinal.difference(agora).inMinutes < 20) {
        int tempoAviso = horaFinal.difference(agora).inMinutes - 5 < 0
            ? 0
            : horaFinal.difference(agora).inMinutes - 5;
        Timer(Duration(minutes: tempoAviso, seconds: 5), () {
          UtilDialog.exibirInformacoes(
              GetIt.I.get<ServicoNavegacao>().navigatorKey.currentContext!,
              mensagem:
                  "Seu horario de acesso encerra em ${horaFinal.difference(agora).inMinutes} minutos!",
              titulo: "AVISO");
          Timer(
              Duration(minutes: horaFinal.difference(agora).inMinutes),
              () => GetIt.I
                  .get<ServicoNavegacao>()
                  .navegarPara('/telaForaDoHorario'));
        });
      }
      dentroHorario?.call();
    } else {
      foraHorario?.call();
      if (foraHorario == null)
        GetIt.I.get<ServicoNavegacao>().navegarPara('/telaForaDoHorario');
    }
  }

  void logoutUsuario({Function()? deslogar}) {
    _prefs.then((db) {
      db.remove("user");
      usuarioLogado = Usuario(email: "", senha: "");
      usuario = Usuario(email: "", senha: "");
      deslogar!();
    });
  }
}
