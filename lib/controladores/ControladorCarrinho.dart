import 'package:app_consultor/modelos/Aluno.dart';
import 'package:app_consultor/modelos/ModalidadePlano.dart';
import 'package:app_consultor/modelos/Pacote.dart';
import 'package:app_consultor/modelos/Plano.dart';
import 'package:app_consultor/modelos/Produto.dart';
import 'package:app_consultor/util/CalculoValor.dart';
import 'package:flutter/material.dart';

//armazena dados que serão exibidos no carrinho
class ControladorCarrinho {
  Aluno? aluno;
  Plano? plano;
  DateTime? datainicio;
  DateTime? lancamento;
  double? percentual;
  ValueNotifier<int> numProd = ValueNotifier(0);
  var listaProdutos = <Produto>[];
  var listaProdutosPlano = <Produto>[];
  ControladorCarrinho(
      {this.aluno,
      this.plano,
      this.datainicio,
      this.lancamento,
      this.percentual = 0});

  double get totalProdutos {
    double total = 0;
    listaProdutos.forEach((element) {
      total += element.valorFinal * element.quantidade;
    });
    if (listaProdutos.isEmpty)
      return 0;
    else
      return total;
  }

  double get totalProdutosPlano {
    double total = 0;
    plano!.produtos!.forEach((element) {
      total += element.valorFinal * element.quantidade;
    });
    return total;
  }

  double get totalModalidade {
    double total = 0;
    plano!.modalidades.forEach((element) {
      //checagem para saber se o plano é não é do tipo credito, ou é do tipo credito por sessão
      if (plano!.tipoPlano != "PLANO_CREDITO" ||
          (plano!.tipoPlano == "PLANO_CREDITO" &&
              plano!.creditoSessao == true)) {
        if (element.selecionado! && !element.selecionadoPacote!)
          total += obterValorTotalModalidade(element);
      } else if (!element.selecionadoPacote!)
        total += obterValorTotalModalidade(element);
    });
    return total;
  }

  double get totalContrato {
    return plano!.valorFinal! + totalModalidade;
  }

  double get totalFechamento {
    return totalProdutos + totalContrato + totalProdutosPlano;
  }

  void selecionarModalidadesPacote(Pacote? pacote,
      {bool pacoteAdicional = false, bool modalidadeNaoEspecifica = false}) {
    if (pacote != null) {
      //limpar os dados dos pacotes anteriores se o pacote atual não for adicional
      if (!pacoteAdicional) {
        plano!.modalidades.forEach((element) {
          if (element.selecionadoPacote == true && !pacote.pacoteAdicional) {
            element.selecionado = false;
            element.selecionadoPacote = false;
          } else if (element.selecionadoPacoteAdicional == true &&
              element.selecionadoPacote == false) {
            element.selecionado = false;
            element.selecionadoPacoteAdicional = false;
            element.selecionadoPacoteNaoEspecifico = false;
          }
        });
      }
      //marcar as modalidades se o pacote for de modalidades especificas
      if (pacote.modalidadesEspecificas) {
        pacote.modalidades.forEach((element) {
          plano!.modalidades.forEach((e) {
            if (e.codigo == element.codigo) {
              pacote.pacoteAdicional
                  ? e.selecionadoPacoteAdicional = true
                  : e.selecionadoPacote = true;
              e.pacoteCodigo = pacote.codigo;
              e.selecionado = true;
            }
          });
        });
      }
    } else if (!pacoteAdicional) {
      //caso o pacote seja nulo, ele deve limpar os seus dados
      plano!.pacotesAdicionais.forEach((element) {
        element.selecionado = false;
      });
      plano!.modalidades.forEach((element) {
        if (element.selecionadoPacote == true ||
            element.selecionadoPacoteAdicional == true) {
          element.selecionado = false;
          element.selecionadoPacote = false;
          element.selecionadoPacoteAdicional = false;
        }
      });
    } else {
      //se o pacote for nulo porem adicional ele deve manter os dados dos outros pacotes
      plano!.modalidades.forEach((element) {
        if (element.selecionadoPacoteAdicional == true &&
            element.selecionadoPacote == false) {
          element.selecionado = false;
          element.selecionadoPacoteAdicional = false;
          if (modalidadeNaoEspecifica == true) {
            element.selecionadoPacoteNaoEspecifico = false;
          }
        }
      }); //para manter os dados dos outros pacotes adicionais, a função é chamada denovo para cada ativo deles
      plano!.pacotesAdicionais.forEach((element) {
        if (element.selecionado == true) selecionarModalidadesPacote(element);
      });
    }
  }

  double obterValorTotalModalidade(ModalidadePlano m) {
    var valor;
    if (m.selecionadoPacote! ||
        m.selecionadoPacoteAdicional! ||
        m.selecionadoPacoteNaoEspecifico!) {
      Pacote p = plano!.pacotes!
          .firstWhere((element) => element.codigo == m.pacoteCodigo!);
      if (m.selecionadoPacoteNaoEspecifico!)
        valor = p.precoComposicao / p.qtdModalidadesSelecionadas!;
      else
        valor = p.precoComposicao / p.modalidades.length;
    } else
      valor = m.valorMensal;
    if (m.numeroVezesSelecionado != null) {
      return CalculoValor.calcularValorPorOperacao(
          valorBase: valor,
          tipoOperacao: m.numeroVezesSelecionado!.tipoOPeracao!,
          percentualDesconto: m.numeroVezesSelecionado!.percentualDesconto,
          tipoValor: m.numeroVezesSelecionado!.tipoValor!,
          valorEspecifico: m.numeroVezesSelecionado!.valorEspecifico);
    } else
      return m.valorMensal;
  }
}
