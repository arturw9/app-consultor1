import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

enum IconeNavegacao { home, busca, carrinho, perfil }

// ignore: must_be_immutable
class AppBarra extends StatelessWidget {
  final IconeNavegacao iconeNavegacao;
  AppBarra({Key? key, required this.iconeNavegacao}) : super(key: key);
  ControladorCarrinho _controladorCarrinho = GetIt.I.get<ControladorCarrinho>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _controladorCarrinho.numProd,
        builder: (context, value, child) {
          return Container(
            color: Colors.transparent,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 5,
                    color: Colors.black,
                  ),
                ],
              ),
              child: Container(
                //usa os icones componentizados
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NavegacaoBotao(
                          titulo: "Home",
                          iconeNavegacao: iconeNavegacao,
                          iconeNavegacaoSelecionado: IconeNavegacao.home,
                          icone: Icon(
                            Icons.home_outlined,
                            size: 30,
                          ),
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, "/telaInicio")),
                      _controladorCarrinho.listaProdutos.isEmpty
                          ? NavegacaoBotao(
                              titulo: "Carrinho",
                              iconeNavegacao: iconeNavegacao,
                              iconeNavegacaoSelecionado:
                                  IconeNavegacao.carrinho,
                              icone: Icon(
                                Icons.shopping_cart_outlined,
                                size: 30,
                              ),
                              onPressed: () =>
                                  Navigator.pushNamed(context, "/telaCarrinho"))
                          : Stack(
                              children: [
                                NavegacaoBotao(
                                    titulo: "Carrinho",
                                    iconeNavegacao: iconeNavegacao,
                                    iconeNavegacaoSelecionado:
                                        IconeNavegacao.carrinho,
                                    icone: Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 30,
                                    ),
                                    onPressed: () => Navigator.pushNamed(
                                        context, "/telaCarrinho")),
                                Positioned(
                                  left: 28,
                                  top: 3,
                                  height: 16,
                                  width: 16,
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        _controladorCarrinho.numProd.value
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xff0380E3),
                                        shape: BoxShape.circle),
                                  ),
                                )
                              ],
                            ),
                      NavegacaoBotao(
                          titulo: "Perfil",
                          iconeNavegacao: iconeNavegacao,
                          iconeNavegacaoSelecionado: IconeNavegacao.perfil,
                          icone: Icon(
                            Icons.person_outline_outlined,
                            size: 30,
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, "/telaPerfil")),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

//botao da barra de navegação
// ignore: must_be_immutable
class NavegacaoBotao extends StatelessWidget {
  final iconeNavegacao;
  final iconeNavegacaoSelecionado;
  final String titulo;
  final Icon icone;
  Function onPressed;
  NavegacaoBotao({
    Key? key,
    required this.titulo,
    required this.iconeNavegacao,
    required this.iconeNavegacaoSelecionado,
    required this.icone,
    required this.onPressed,
  }) : super(key: key);

  selecionado() {
    return iconeNavegacao == iconeNavegacaoSelecionado;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            height: 30,
            child: IconButton(
                color: selecionado() ? Colors.blue : Color(0xff6f747b),
                icon: icone,
                onPressed: () {
                  onPressed();
                }),
          ),
        ),
        Text("$titulo"),
      ],
    );
  }
}
