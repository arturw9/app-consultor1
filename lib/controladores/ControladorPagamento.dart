import 'package:app_consultor/modelos/Aluno.dart';
import 'package:app_consultor/modelos/Plano.dart';

class ControladorPagamento {
  Aluno? aluno;
  Plano? plano;
  double? total;
  ControladorPagamento({
    this.aluno,
    this.plano,
    this.total,
  });
}
