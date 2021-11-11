import 'package:app_consultor/AppConsultor.dart';
import 'package:app_consultor/controladores/ControladorPlano.dart';
import 'package:app_consultor/servicos/ServicosCliente.dart';
import 'package:app_consultor/servicos/ServicosUsuarioLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'controladores/ControladorAluno.dart';
import 'controladores/ControladorCarrinho.dart';
import 'controladores/ControladorLancarDiaria.dart';
import 'controladores/ControladorUsuario.dart';
import 'controladores/ControladorDetalhePlano.dart';

final getIt = GetIt.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//Registro dos singletons do GetIt(https://pub.dev/packages/get_it)
  getIt.registerSingleton(ServicoUsuarioLogin());
  getIt.registerSingleton(ServicosCliente());
  getIt.registerSingleton(ControladorUsuario());
  getIt.registerSingleton(ControladorCarrinho());
  getIt.registerSingleton(ControladorPlano());
  getIt.registerSingleton(ControladorAluno());
  getIt.registerSingleton(ControladorLancarDiaria());
  getIt.registerSingleton(ControladorDetalhePlano());
  //Muda a cor da statusBar para transparente
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await dotenv.load(fileName: ".env_dev");
  //Roda o app
  runApp(AppConsultor());
}
