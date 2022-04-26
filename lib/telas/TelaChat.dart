import 'dart:async';
import 'dart:io';
import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/telas/TelaInicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  ControladorUsuario controladorUsuario = GetIt.I.get<ControladorUsuario>();

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    } else if (Platform.isIOS) {
      WebView.platform = CupertinoWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    var nome = Uri.encodeFull(controladorUsuario.usuario.nome!);
    var codFin =
        Uri.encodeFull(controladorUsuario.usuario.unidade!.codigoFinanceiro);
    var email = Uri.encodeFull(controladorUsuario.usuario.email);
    var telefone =
        Uri.encodeFull(controladorUsuario.usuario.telefone.toString());
    var unidade =
        Uri.encodeFull(controladorUsuario.usuario.unidade!.codigo.toString());
    var codColaborador =
        Uri.encodeFull(controladorUsuario.usuario.codigoColaborador.toString());
    var key = Uri.encodeFull(controladorUsuario.usuario.key.toString());
    var codRef = key + '-' + unidade + '-' + codColaborador;
    var codApp = dotenv.env['codAppChat'];

    String filterUrl =
        "http://chat.movidesk.com/ChatWidget/Login/$codApp?Name=$nome&Email=$email&PhoneNumber=$telefone&CodeReference=$codRef&OrganizationCodeReference=$codFin&StayConnected=false&EmptySubject=false&StartChat=true";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: new IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  //retira as telas anteriores
                  MaterialPageRoute(builder: (context) => TelaInicio()),
                  (Route<dynamic> route) => false);
              CookieManager().clearCookies();
            },
            icon:
                new Icon(Icons.arrow_back_ios, color: Colors.black, size: 24)),
        actions: <Widget>[],
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: filterUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0xFFFFFFFF),
        );
      }),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(
      this._webViewControllerFuture); //  : assert(_webViewControllerFuture != null)

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller!.canGoBack()) {
                        await controller.goBack();
                      } else {
                        // ignore: deprecated_member_use
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Nenhum item do histórico anterior')),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller!.canGoForward()) {
                        await controller.goForward();
                      } else {
                        // ignore: deprecated_member_use
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Nenhum item do histórico de encaminhamento')),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller!.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}
