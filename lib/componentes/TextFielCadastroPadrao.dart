import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:keyboard_actions/keyboard_actions.dart';

class FieldNome extends StatelessWidget {
  final String? valorInicial;
  final Function(String text) onChanged;

  const FieldNome({
    Key? key,
    this.valorInicial,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return " Nome Obrigatório ";
          }
          return (value.trim().length < 3) ? 'Use acime de 3 caracteres' : null;
        },
        initialValue: valorInicial,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'NunitoSans',
          color: Color(0XFF6F747B),
        ),
        decoration: InputDecoration(
          labelText: "Nome",
          hintText: 'Nome e Sobrenome',
          hintStyle: TextStyle(fontSize: 18),
          labelStyle: TextStyle(
            fontSize: 18,
            color: Color(0XFF0380E3),
            fontFamily: 'NunitoSansBold',
          ),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 20),
    );
  }
}

class FieldCPF extends StatelessWidget {
  final Function(String text) onChanged;
  const FieldCPF({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
    return Container(
      child: TextFormField(
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return " CPF Obrigatório ";
          }
          if (!GetUtils.isCpf(value)) {
            return " CPF Invádido ";
          }
        },
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'NunitoSans',
          color: Color(0XFF6F747B),
        ),
        inputFormatters: [maskFormatter],
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          labelText: "CPF",
          hintText: '000.000.000-00',
          labelStyle: TextStyle(
            fontSize: 18,
            color: Color(0XFF0380E3),
            fontFamily: 'NunitoSansBold',
          ),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 30),
    );
  }
}

class FieldCelular extends StatelessWidget {
  final Function(String text) onChanged;
  const FieldCelular({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(mask: '(##)# ####-####');
    return Container(
      child: TextFormField(
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return " Celular Obrigatório ";
          }
        },
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'NunitoSans',
          color: Color(0XFF6F747B),
        ),
        inputFormatters: [maskFormatter],
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          labelText: "Celular",
          hintText: '(99)9 9999-9999',
          labelStyle: TextStyle(
            fontSize: 18,
            color: Color(0XFF0380E3),
            fontFamily: 'NunitoSansBold',
          ),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 20),
    );
  }
}

class FieldEmail extends StatelessWidget {
  final Function(String text) onChanged;
  const FieldEmail({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return " E-mail Obrigatório ";
          }
          return (!value.contains('@')) ? 'Use @ para validar o e-mail' : null;
        },
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'NunitoSans',
          color: Color(0XFF6F747B),
        ),
        decoration: InputDecoration(
          labelText: "Email",
          hintText: 'example@provedor.com',
          labelStyle: TextStyle(
            fontSize: 18,
            color: Color(0XFF0380E3),
            fontFamily: 'NunitoSansBold',
          ),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 20),
    );
  }
}

class FieldDataNasc extends StatefulWidget {
  final TextEditingController dataControler;
  final ValueChanged<String> onSelected;
  // final ValueChanged<DateTime> onSelectedDate;

  const FieldDataNasc({
    Key? key,
    required this.dataControler,
    required this.onSelected,
    // required this.onSelectedDate,
  }) : super(key: key);

  @override
  _FieldDataNascState createState() => _FieldDataNascState();
}

//TextEditingController();

class _FieldDataNascState extends State<FieldDataNasc> {
  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(mask: '##/##/####');

    return Container(
      child: TextFormField(
        controller: widget.dataControler,
        readOnly: true,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return " Data Nascimento Obrigatório ";
          }
        },
        //controller: widget.dataControler,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'NunitoSans',
          color: Color(0XFF6F747B),
        ),
        inputFormatters: [maskFormatter],

        // keyboardType: TextInputType.number,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              Icons.calendar_today_outlined,
              color: Color(0XFF60380E3),
            ),
            onPressed: () async {
              await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 120),
                      lastDate: DateTime(DateTime.now().year + 1))
                  .then((selectedDate) {
                if (selectedDate != null) {
                  widget.dataControler.text =
                      DateFormat('dd/MM/yyyy').format(selectedDate);
                  widget.onSelected(widget.dataControler.text);
                }
              });
            },
          ),
          labelText: "Data de nascimento",
          hintText: '20/10/2000',
          labelStyle: TextStyle(
            fontSize: 18,
            color: Color(0XFF0380E3),
            fontFamily: 'NunitoSansBold',
          ),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 20),
    );
  }
}

class FieldCEP extends StatelessWidget {
  final Function(String text) onChanged;
  const FieldCEP({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(mask: '#####-###');
    return Container(
      child: TextFormField(
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return " CEP Obrigatório ";
          }
        },
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'NunitoSans',
          color: Color(0XFF6F747B),
        ),
        inputFormatters: [maskFormatter],
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          labelText: "CEP",
          hintText: '74956-123',
          labelStyle: TextStyle(
            fontSize: 18,
            color: Color(0XFF0380E3),
            fontFamily: 'NunitoSansBold',
          ),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 20),
    );
  }
}

class Content extends StatefulWidget {
  Content({Key? key}) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

//Modelo usando pub keyboard_actions: ^3.4.6 ,  caso queira implementar somente teclado numerico no IOS

class _ContentState extends State<Content> {
  final FocusNode _nodeText2 = FocusNode();

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: _nodeText2, toolbarButtons: [
          (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.close),
              ),
            );
          }
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                focusNode: _nodeText2,
                decoration: InputDecoration(
                  hintText: "Input Text with Custom Done Button",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
