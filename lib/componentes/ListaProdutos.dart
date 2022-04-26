import 'package:app_consultor/controladores/ControladorLancarDiaria.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/controladores/ControladorPesquisaProdutos.dart';
import 'package:app_consultor/modelos/Produto.dart';
import 'package:app_consultor/util/EnumPesquisaEstado.dart';

import 'ProdutoWidget.dart';

// ignore: must_be_immutable
class ListaProdutos extends StatelessWidget {
  ValueChanged<Produto>? onTap;
  final produtos = <Produto>[];
  final listaVazia = ValueNotifier<bool>(true);
  ControladorCarrinho _controladorCarrinho = GetIt.I.get<ControladorCarrinho>();
  ControladorLancarDiaria _controladorLancarDiaria =
      GetIt.I.get<ControladorLancarDiaria>();
  ScrollController scrollController;
  ControladorPesquisaProdutos controlador;
  Function? onClose;
  ListaProdutos(
      {Key? key,
      required this.scrollController,
      required this.controlador,
      this.onClose,
      this.onTap})
      : super(key: key);
  double posicaoScroll = 0.0;

  gereciadorEstado(PesquisaEstado estado) {
    scrollController = ScrollController(initialScrollOffset: posicaoScroll);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          controlador.pesquisaEstado.value != PesquisaEstado.novoConteudo &&
          controlador.paginaAtual != controlador.paginasTotal + 1) {
        posicaoScroll = scrollController.position.pixels;
        controlador.carregaProdutos();
      }
    });
    switch (estado) {
      case PesquisaEstado.carregarConteudo:
        controlador.pesquisaProdutos();
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 7,
          ),
        );

      case PesquisaEstado.carregando:
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 7,
          ),
        );
      case PesquisaEstado.sucesso:
        return RefreshIndicator(
          strokeWidth: 4,
          onRefresh: () {
            posicaoScroll = 0;
            return controlador.pesquisaProdutos();
          },
          child: Scaffold(
            body: ListBuilderProdutos(
              scrollController: scrollController,
              controlador: controlador,
              listaVazia: listaVazia,
              produtos: produtos,
              onTap: onTap,
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
              ),
              height: 69,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9.5),
                    child: Container(
                      height: 48,
                      width: 343,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: ValueListenableBuilder(
                        builder: (context, value, child) {
                          return ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                primary: Color(0XFF0380E3),
                              ),
                              onPressed: produtos.isNotEmpty
                                  ? () {
                                      bool achou = false;
                                      if (controlador.diaria == false
                                          ? _controladorCarrinho
                                              .listaProdutos.isNotEmpty
                                          : _controladorLancarDiaria
                                              .listaProdutos.isNotEmpty) {
                                        for (final prod in produtos) {
                                          for (final carr
                                              in controlador.diaria == false
                                                  ? _controladorCarrinho
                                                      .listaProdutos
                                                  : _controladorLancarDiaria
                                                      .listaProdutos) {
                                            if (carr.codigo == prod.codigo) {
                                              achou = true;
                                              carr.quantidade +=
                                                  prod.quantidade;
                                              break;
                                            }
                                          }
                                          if (!achou)
                                            controlador.diaria == false
                                                ? _controladorCarrinho
                                                    .listaProdutos
                                                    .add(prod)
                                                : _controladorLancarDiaria
                                                    .listaProdutos
                                                    .add(prod);
                                          else
                                            achou = false;
                                        }
                                      } else
                                        controlador.diaria == false
                                            ? _controladorCarrinho
                                                .listaProdutos = produtos
                                            : _controladorLancarDiaria
                                                .listaProdutos = produtos;
                                      onClose == null
                                          ? Navigator.pushReplacementNamed(
                                              context, "/telaCarrinho")
                                          : onClose!();

                                      if (controlador.diaria == false)
                                        _controladorCarrinho.numProd.value =
                                            _controladorCarrinho
                                                .listaProdutos.length;
                                    }
                                  : null,
                              icon: Icon(Icons.refresh),
                              label: Text("ATUALIZAR CARRINHO"));
                        },
                        valueListenable: listaVazia,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      case PesquisaEstado.novoConteudo:
        return Stack(
          children: [
            ListBuilderProdutos(
                scrollController: scrollController,
                controlador: controlador,
                listaVazia: listaVazia,
                produtos: produtos),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 7,
                  ),
                ),
              ),
            ),
          ],
        );
      case PesquisaEstado.erro:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Não há resulados para a busca"),
              IconButton(
                  onPressed: () => controlador.pesquisaProdutos(),
                  icon: Icon(Icons.refresh_outlined))
            ],
          ),
        );
      default:
        Center(
          child: CircularProgressIndicator(
            strokeWidth: 7,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controlador.pesquisaEstado,
      builder: (context, child) {
        return gereciadorEstado(controlador.pesquisaEstado.value);
      },
    );
  }
}

class ListBuilderProdutos extends StatelessWidget {
  final List<Produto> produtos;
  final ValueNotifier<bool> listaVazia;
  final ScrollController scrollController;
  final ControladorPesquisaProdutos controlador;
  final ValueChanged<Produto>? onTap;
  const ListBuilderProdutos({
    Key? key,
    required this.scrollController,
    required this.controlador,
    required this.listaVazia,
    required this.produtos,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.all(0),
      itemCount: controlador.listaProduto!.length,
      itemBuilder: (BuildContext context, int index) {
        final Produto produto = controlador.listaProduto![index];
        return controlador.diaria == false
            ? ProdutoWidget(
                produto: produto,
                adicionarUm: () {
                  if (produto.quantidade == 0) {
                    produtos.add(produto);
                  }
                  listaVazia.value = produtos.isEmpty;
                },
                removerUm: () {
                  if (produto.quantidade == 1) {
                    produtos.remove(produto);
                  }
                  listaVazia.value = produtos.isEmpty;
                },
              )
            : GestureDetector(
                onTap: () {
                  onTap!(produto);
                },
                child: ProdutoDiariaWidget(produto: produto));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
