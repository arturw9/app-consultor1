import 'package:flutter/material.dart';

import 'EnumNavegacao.dart';

//cards da tela de inicio
class CartaoInicio extends StatelessWidget {
  final Widget child;
  const CartaoInicio({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 161,
      height: 151,
      child: child,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 12),
              blurRadius: 24,
              color: Color(0xFFE4E5E6),
            ),
          ]),
    );
  }
}

//conteudo dos cards
class ConteudoCadastro extends StatelessWidget {
  const ConteudoCadastro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConteudoCartao(
      cor: Color(0xff1998fc),
      titulo: "Cadastrar aluno",
      icone: Icons.person_add_alt_1_outlined,
      navegacao: "/telaCadastro",
      tipoNavegacao: TipoNavegacao.non_replace,
    );
  }
}

class ConteudoVendasPlanos extends StatelessWidget {
  const ConteudoVendasPlanos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConteudoCartao(
      cor: Color(0xff28ab45),
      titulo: "Vender produtos",
      icone: Icons.view_in_ar_outlined,
      navegacao: "/telaPesquisaProdutos",
      tipoNavegacao: TipoNavegacao.non_replace,
    );
  }
}

class ConteudoVendasProdutos extends StatelessWidget {
  const ConteudoVendasProdutos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConteudoCartao(
      cor: Color(0xffff4b2b),
      titulo: "Venda de plano",
      icone: Icons.bookmark_border_outlined,
      navegacao: "/telaPesquisaPlanos",
      tipoNavegacao: TipoNavegacao.non_replace,
    );
  }
}

class ConteudoBuscarAluno extends StatelessWidget {
  const ConteudoBuscarAluno({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConteudoCartao(
      cor: Color(0xff4287b5),
      titulo: "Buscar aluno",
      icone: Icons.search,
      navegacao: "/telaPesquisaAlunos",
      tipoNavegacao: TipoNavegacao.non_replace,
    );
  }
}

class ConteudoLancarDiaria extends StatelessWidget {
  const ConteudoLancarDiaria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConteudoCartao(
      cor: Color(0xffd6a10f),
      titulo: "Lançar Diária",
      icone: Icons.calendar_today_outlined,
      navegacao: "/telaLancarDiaria",
      tipoNavegacao: TipoNavegacao.non_replace,
    );
  }
}

//Componente de conteudo padrão dos cards
class ConteudoCartao extends StatelessWidget {
  final Color cor;
  final String titulo;
  final IconData icone;
  final String navegacao;
  final tipoNavegacao;
  ConteudoCartao(
      {Key? key,
      required this.cor,
      required this.titulo,
      required this.icone,
      required this.navegacao,
      required this.tipoNavegacao})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        tipoNavegacao ==
                TipoNavegacao
                    .replace // muda o tipo de naveção dependendo do enumerados passado
            ? Navigator.pushReplacementNamed(context, navegacao)
            : Navigator.pushNamed(context, navegacao);
      },
      child: Container(
        alignment: Alignment.center,
        child: FittedBox(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Icon(
                icone,
                color: cor,
                size: 40,
              ),
              SizedBox(
                height: 7,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  titulo,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: cor,
                    fontSize: 18,
                    fontFamily: "Nunito Sans",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
