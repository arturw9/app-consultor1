import 'dart:async';

import 'package:app_consultor/AppConsultor.dart';
import 'package:app_consultor/controladores/ControladorPlano.dart';
import 'package:app_consultor/servicos/ServicosCliente.dart';
import 'package:app_consultor/servicos/ServicosNavegacao.dart';
import 'package:app_consultor/servicos/ServicosUsuarioLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'controladores/ControladorAluno.dart';
import 'controladores/ControladorCarrinho.dart';

import 'controladores/ControladorLancarDiaria.dart';
import 'controladores/ControladorPagamento.dart';
import 'controladores/ControladorUsuario.dart';
import 'controladores/ControladorDetalhePlano.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//Registro dos singletons do GetIt(https://pub.dev/packages/get_it)
  getIt.registerLazySingleton<ServicoUsuarioLogin>(() => ServicoUsuarioLogin());
  getIt.registerLazySingleton<ServicosCliente>(() => ServicosCliente());
  getIt.registerLazySingleton<ControladorUsuario>(() => ControladorUsuario());
  getIt.registerLazySingleton<ControladorCarrinho>(() => ControladorCarrinho());
  getIt.registerLazySingleton<ControladorPagamento>(
      () => ControladorPagamento());
  getIt.registerLazySingleton<ServicoNavegacao>(() => ServicoNavegacao());
  getIt.registerLazySingleton<ControladorPlano>(() => ControladorPlano());
  getIt.registerLazySingleton<ControladorAluno>(() => ControladorAluno());
  getIt.registerLazySingleton<ControladorLancarDiaria>(
      () => ControladorLancarDiaria());
  getIt.registerLazySingleton<ControladorDetalhePlano>(
      () => ControladorDetalhePlano());
  //Muda a cor da statusBar para transparente
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await dotenv.load(fileName: '.env');
  const intervalo = Duration(minutes: 15);
  Timer.periodic(intervalo, (Timer t) {
    ControladorUsuario controlador = GetIt.I.get<ControladorUsuario>();
    controlador.verificarSeTemUsuario(
        naoTemUsuario: () {},
        temUsuario: () {
          controlador.estaDentroDoHorario();
        });
  });
  //Roda o app
  runApp(AppConsultor());
}
