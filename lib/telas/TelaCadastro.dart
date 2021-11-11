import 'dart:io';
import 'dart:ui';

import 'package:app_consultor/componentes/ButtonPadrao.dart';
import 'package:app_consultor/componentes/TextFielCadastroPadrao.dart';
import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/modelos/Cliente.dart';
import 'package:app_consultor/telas/TelaCarrinho.dart';
import 'package:app_consultor/util/UtilDialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

//Tela com formulario de cadastro de um aluno
class TelaCadastro extends StatefulWidget {
  TelaCadastro({Key? key}) : super(key: key);

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  ControladorCarrinho _controladorCarrinho = GetIt.I.get<ControladorCarrinho>();
  Cliente _cliente = Cliente();
  final formKey = GlobalKey<FormState>();
  var parsedDate = DateTime.parse('1974-03-20 00:00:00.000');

  File? image;
  Future pegarImagemGaleria(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Falha ao escolher imagem : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CADASTRO",
          style: TextStyle(fontSize: 16, fontFamily: 'NunitoSans'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: SizedBox(
                    height: 130,
                    width: 130,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        image != null
                            ? ClipOval(
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipOval(
                                child: SvgPicture.asset(
                                    "assets/images/fotoPadrao.svg"),
                              ),
                        Positioned(
                          right: -3,
                          bottom: 0,
                          child: Container(
                            height: 40,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0XFF0380E3),
                            ),
                            child: SizedBox(
                              height: 46,
                              width: 46,
                              child: IconButton(
                                icon: Icon(Icons.add_a_photo_outlined),
                                color: Colors.white,
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 3,
                                            sigmaY: 3,
                                          ),
                                          child: Container(
                                            height: 130,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30))),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 300,
                                                  child: TextButton.icon(
                                                      onPressed: () {
                                                        pegarImagemGaleria(
                                                            ImageSource.camera);
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(
                                                        Icons.camera_alt,
                                                        color: Colors
                                                            .grey.shade600,
                                                      ),
                                                      label: Text(
                                                        'Câmera',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors
                                                                .grey.shade600),
                                                      )),
                                                ),
                                                Divider(),
                                                Container(
                                                  width: 300,
                                                  child: TextButton.icon(
                                                      onPressed: () {
                                                        pegarImagemGaleria(
                                                            ImageSource
                                                                .gallery);
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(
                                                        Icons.photo,
                                                        color: Colors
                                                            .grey.shade600,
                                                      ),
                                                      label: Text(
                                                        'Galeria',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors
                                                                .grey.shade600),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              FieldNome(
                onChanged: (text) {
                  _cliente.nome = text;
                },
              ),
              FieldCPF(
                onChanged: (text) {
                  _cliente.cpf = text;
                },
              ),
              FieldCelular(
                onChanged: (text) {
                  _cliente.celular = text;
                },
              ),
              FieldEmail(
                onChanged: (text) {
                  _cliente.email = text;
                },
              ),
              FieldDataNasc(
                onSelected: (text) {
                  _cliente.dataNascimento = DateFormat.yMd('pt_BR').parse(text);
                  //  FormatarData.convertStringToDate(text);
                },
                dataControler: TextEditingController(),

                // onChanged: (text) {},
              ),
              FieldCEP(
                onChanged: (text) {
                  _cliente.cep = text;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: Center(
          child: ButtonCadastroSalvar(
            value: "SALVAR",
            onTap: () {
              _cliente.empresa = _controladorUsuario.usuario.unidade!.codigo;

              if (formKey.currentState?.validate() == true) {
                _controladorUsuario.cadastrarCliente(
                  _cliente,
                  sucesso: (aluno) {
                    // Navigator.pushReplacementNamed(context, "/telaCarrinho");
                    _controladorCarrinho.aluno = aluno;
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                          builder: (BuildContext context) => TelaCarrinho(),
                        ))
                        .then((_) => formKey.currentState?.reset());
                  },
                  erro: (mensagem) {
                    UtilDialog.exibirInformacoes(context,
                        titulo: "Ops!", mensagem: mensagem);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // void _enviarImagem() {
  //   //https://www.youtube.com/watch?v=RXjparAoJoc&t=368s
  //   if (image == null) return;
  //   //base64 string
  //   String base64image = base64Encode(image!.readAsBytesSync());
  //   String fileName = image!.path.split('/').last;
  //   var url = Uri.parse(
  //       "http://swarm-42.pactosolucoes.com.br:8314/clientes/incluirCliente");

  //   http.post(url, body: {
  //     'imagem': base64image,
  //     'nome': fileName,
  //   }).then((resultado) {
  //     print(resultado.statusCode);
  //     setState(() {
  //       //limpar
  //       image = null;
  //     });
  //   });
  // }
}
