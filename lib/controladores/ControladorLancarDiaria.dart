
import 'package:app_consultor/modelos/Aluno.dart';
import 'package:app_consultor/modelos/Modalidade.dart';
import 'package:app_consultor/modelos/Produto.dart';

//armazena dados que serão exibidos na tela de laçar diaria
class ControladorLancarDiaria {
  Aluno? aluno;
  Produto? produto;
  Modalidade? modalidade;
  DateTime? dataInicio;
  DateTime? lancamento;
  ControladorLancarDiaria({
    this.aluno,
    this.produto,
    this.modalidade,
    this.dataInicio,
    this.lancamento,
  });
}
