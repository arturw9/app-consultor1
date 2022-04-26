//classe principal do app
import 'package:app_consultor/componentes/AvisoInternet.dart';
import 'package:app_consultor/servicos/ServicosNavegacao.dart';
import 'package:app_consultor/telas/TelaCadastro.dart';
import 'package:app_consultor/telas/TelaCarrinho.dart';
import 'package:app_consultor/telas/TelaChat.dart';
import 'package:app_consultor/telas/TelaDetalhePlano.dart';
import 'package:app_consultor/telas/TelaFechamentoDiaria.dart';
import 'package:app_consultor/telas/TelaFechamentoVenda.dart';
import 'package:app_consultor/telas/TelaFechamentoVendaProdutos.dart';
import 'package:app_consultor/telas/TelaForaDoHorario.dart';
import 'package:app_consultor/telas/TelaInicio.dart';
import 'package:app_consultor/telas/TelaLogin.dart';
import 'package:app_consultor/telas/TelaPesquisaAlunos.dart';
import 'package:app_consultor/telas/TelaPesquisaPlanos.dart';
import 'package:app_consultor/telas/TelaSplash.dart';
import 'package:app_consultor/telas/TelaUnidades.dart';

import 'package:app_consultor/telas/TelaLancarDiaria.dart';

import 'package:app_consultor/telas/TelaLoginCelular.dart';
import 'package:app_consultor/telas/TelaLoginCodigoCelular.dart';
import 'package:app_consultor/telas/TelaPagamento.dart';
import 'package:app_consultor/telas/TelaPerfil.dart';
import 'package:app_consultor/telas/TelaPerfilAluno.dart';

import 'package:app_consultor/telas/TelaPesquisaProdutos.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

class AppConsultor extends StatelessWidget {
  const AppConsultor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //MaterialApp no começo da arvore de widgets
    return MaterialApp(
      builder: (context, child) => BaseWidget(child: child!),
      //Remove a fita do Debug
      debugShowCheckedModeBanner: false,
      //Declara a localiazão de linguagem para android e IOS
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      //Rotas do app
      initialRoute: "/telaSplash",
      navigatorKey: GetIt.I.get<ServicoNavegacao>().navigatorKey,

      routes: {
        "/telaSplash": (_) => TelaSplash(),
        "/telaLogin": (_) => TelaLogin(),
        "/telaInicio": (_) => TelaInicio(),
        "/telaCadastro": (_) => TelaCadastro(),
        "/telaUnidades": (_) => TelaUnidades(),
        "/telaPesquisaAlunos": (_) => TelaPesquisaAlunos(),
        "/telaPesquisaPlanos": (_) => TelaPesquisaPlanos(),
        "/telaPesquisaProdutos": (_) => TelaPesquisaProdutos(),
        "/telaLoginCelular": (_) => TelaLoginCelular(),
        "/telaLoginCodigoCelular": (_) => TelaLoginCodigoCelular(),
        "/telaPerfilAluno": (_) => TelaPerfilAluno(),
        "/telaCarrinho": (_) => TelaCarrinho(),
        "/telaLancarDiaria": (_) => TelaLancarDiaria(),
        "/telaPerfil": (_) => TelaPerfil(),
        "/telaDetalhePlano": (_) => TelaDetalhePlano(),
        "/telaFechamentoVenda": (_) => TelaFechamentoVenda(),
        "/telaPagamento": (_) => TelaPagamento(),
        "/telaFechamentoVendaProdutos": (_) => TelaFechamentoVendaProdutos(),
        "/telaFechamentoDiaria": (_) => TelaFechamentoDiaria(),
        "/telaChat": (_) => WebViewExample(),
        "/telaForaDoHorario": (_) => TelaForaDoHorario(),
      },
      //Adiciona as linguagens suportadas
      supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}
