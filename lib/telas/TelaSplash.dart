import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class TelaSplash extends StatefulWidget {
  // Tela splash serve carregar informacoes para saber se o usuario esta logado ou nao carregados os dados e enviando pra tela correta (principal do app)

  TelaSplash({Key? key}) : super(key: key);

  @override
  _TelaSplashState createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  @override
  void initState() {
    // metodo initState e chamado antes de chamar as construcoes dos Widegts

    Future.delayed(Duration(seconds: 2)).then((value) {
      // demorar 2 segundos fixando a tela carregando
      GetIt.I.get<ControladorUsuario>().verificarSeTemUsuario(
          // usando depedencia get_it para verificar o registro no controladorUsuario se usario estalogado ou nao
          temUsuario: () {
        Navigator.pushReplacementNamed(context, "/telaInicio");
        //pushReplacementNamed retira botao de voltar
      }, naoTemUsuario: () {
        Navigator.pushReplacementNamed(context,
            "/telaLogin"); //pushReplacementNamed usado para usuario nao voltar para tela splash
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0XFF026ABC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/pactoLogoWhite.svg",
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "APP DO CONSULTOR",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'NunitoSansBold'),
            ),
            Text(
              "A gente se envolve!",
              style: TextStyle(
                  fontSize: 16, color: Colors.white, fontFamily: 'NunitoSans'),
            ),
          ],
        ),
      ),
    ));
  }
}
