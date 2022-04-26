import 'package:app_consultor/modelos/Aluno.dart';
import 'package:app_consultor/modelos/ContratosColaborador.dart';
import 'package:app_consultor/modelos/VinculoColaborador.dart';
import 'package:app_consultor/servicos/ServicosCliente.dart';

class ControladorAluno {
  Aluno? aluno;

  List<VinculoColaborador>? vinculos;
  List<ContratosColaborador>? contratos;
  ControladorAluno({
    this.aluno,
    this.vinculos,
    this.contratos,
  });

  void obterAluno(int id,
      {Function()? sucesso, Function(String mensagem)? erro}) {
    ServicosCliente.obterAluno(id).then((retorno) {
      aluno = retorno.aluno;

      ServicosCliente.obterVinculo(id).then((retorno) {
        vinculos = retorno.vinculoColaborador;

        ServicosCliente.obterContratos(id).then((retorno) {
          contratos = retorno.contratosColaborador;

          sucesso?.call();
        });
      });
    }).catchError((error) {
      erro?.call(error.toString());
    });
  }
}
