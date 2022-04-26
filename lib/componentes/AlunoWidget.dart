import 'package:app_consultor/componentes/Situacao.dart';
import 'package:app_consultor/modelos/Aluno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//constroi o elemento da lista de alunos
class AlunoWidget extends StatelessWidget {
  final Aluno aluno;
  const AlunoWidget({Key? key, required this.aluno}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uri;
    aluno.imageUri == null
        ? uri = ""
        : uri = aluno.imageUri
            .toString(); //chega se a url da imagem vem nulo se sim passa um valo vazio
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Container(
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: uri.isEmpty
                      ? SvgPicture.asset(
                          "assets/images/fotoPadrao.svg") //desenha a imagem padrão de usuario caso o url da imagem seja nulo
                      : ClipOval(
                          child: Image.network(
                            uri,
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, loadingProgress) {
                              //constroi um loading na tela até que a imagem carregue
                              if (loadingProgress == null) {
                                return child;
                              }
                              return ClipOval(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text("${aluno.nome}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    textDirection: TextDirection.rtl,
                    children: [
                      if (aluno.situacaoContrato != null)
                        Situacao(tipo: aluno.situacaoContrato!),
                      if (aluno.situacao != null)
                        Situacao(tipo: aluno.situacao!),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
