import 'package:flutter/material.dart';

class ButtonCadastroSalvar extends StatelessWidget {
  final String value;
  final Function() onTap;
  const ButtonCadastroSalvar(
      {Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      child: Container(
        child: ElevatedButton.icon(
            icon: Icon(
              Icons.done,
              color: Colors.white,
              size: 22.0,
            ),
            onPressed: onTap,
            label: Text("$value",
                style: TextStyle(fontSize: 18, fontFamily: "NunitoSansBold")),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              primary: Color(0XFF0380E3),
            )),
      ),
    );
  }
}

class ButtonSalvarPerfil extends StatelessWidget {
  final String value;
  final Function() onTap;
  const ButtonSalvarPerfil({Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      child: Container(
        child: ElevatedButton(
            onPressed: onTap,
            child: Text("$value",
                style: TextStyle(fontSize: 18, fontFamily: "NunitoSansBold")),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              primary: Color(0XFF0380E3),
            )),
      ),
    );
  }
}

class ButtonDeslogarPerfil extends StatelessWidget {
  final String value;
  final Function() onTap;
  const ButtonDeslogarPerfil(
      {Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      child: Container(
        child: ElevatedButton(
            onPressed: onTap,
            child: Text("$value",
                style: TextStyle(fontSize: 18, fontFamily: "NunitoSansBold")),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              primary: Colors.red.shade400,
            )),
      ),
    );
  }
}

class ButtonLogin extends StatelessWidget {
  final String value;
  final Function() onTap;
  const ButtonLogin({Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: onTap,
          child: Text("$value",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "NunitoSansBold",
                  color: Color(0XFF026ABC))),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(240, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            primary: Color(0XFFFFFFFF),
          )),
    );
  }
}

class ButtonLoginEntrarCodigoCelular extends StatelessWidget {
  final String value;
  final Function() onTap;
  const ButtonLoginEntrarCodigoCelular(
      {Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: onTap,
          child: Text("$value",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "NunitoSansBold",
                  color: Color(0XFF026ABC))),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(160, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            primary: Color(0XFFFFFFFF),
          )),
    );
  }
}

class ButtonLoginReenviarCodigoCelular extends StatelessWidget {
  final String value;
  final Function() onTap;
  const ButtonLoginReenviarCodigoCelular(
      {Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: onTap,
          child: Text("$value",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "NunitoSansBold",
                  color: Color(0XFFFFFFFF))),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(160, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            primary: Color(0XFF026ABC),
          )),
    );
  }
}

class ButtonEnviarCelular extends StatelessWidget {
  final String value;
  final Function() onTap;
  const ButtonEnviarCelular(
      {Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: onTap,
          child: Text("$value",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "NunitoSansBold",
                  color: Color(0XFF026ABC))),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(160, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            primary: Color(0XFFFFFFFF),
          )),
    );
  }
}

class ButtonLoginEntrarCelular extends StatelessWidget {
  final String value;
  final Function() onTap;
  const ButtonLoginEntrarCelular(
      {Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: onTap,
          child: Text("$value",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: " NunitoSansBold ",
                  color: Color(0XFF026ABC))),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(240, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            primary: Color(0XFFFFFFFF),
          )),
    );
  }
}

class ButtonNovaVenda extends StatelessWidget {
  final String value;
  final Function() onTap;
  const ButtonNovaVenda({Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      child: Container(
        child: ElevatedButton.icon(
            icon: Icon(
              Icons.add_outlined,
              color: Colors.white,
              size: 22.0,
            ),
            onPressed: onTap,
            label: Text("$value",
                style: TextStyle(fontSize: 18, fontFamily: "NunitoSansBold")),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              primary: Color(0XFF0380E3),
            )),
      ),
    );
  }
}

class ButtonConcluirFechamentoVenda extends StatelessWidget {
  final String value;
  final Function() onTap;
  const ButtonConcluirFechamentoVenda(
      {Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      height: 49,
      child: Container(
        child: ElevatedButton.icon(
          icon: Icon(
            Icons.check,
            color: Colors.white,
            size: 22.0,
          ),
          onPressed: onTap,
          label: Text("$value",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "NunitoSans",
                  fontWeight: FontWeight.w700)),
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            primary: Color(0XFF0380E3),
          ),
        ),
      ),
    );
  }
}

class ButtonAlterarFechamentoVenda extends StatelessWidget {
  final String value;
  final Function() onTap;
  const ButtonAlterarFechamentoVenda(
      {Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      height: 49,
      child: Container(
        child: ElevatedButton.icon(
          icon: Icon(
            Icons.repeat,
            color: Color(0XFF1B4166),
            size: 22.0,
          ),
          onPressed: onTap,
          label: Text("$value",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0XFF1B4166),
                  fontFamily: "NunitoSans",
                  fontWeight: FontWeight.w700)),
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            primary: Color(0XFFFAFAFA),
          ),
        ),
      ),
    );
  }
}

class ButtonVoltarInicio extends StatelessWidget {
  final String value;
  final Function() onTap;
  const ButtonVoltarInicio({Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      height: 49,
      child: ElevatedButton.icon(
        icon: Icon(
          Icons.house_outlined,
          color: Colors.white,
          size: 22.0,
        ),
        onPressed: onTap,
        label: Text("$value",
            style: TextStyle(
                fontSize: 16,
                fontFamily: "NunitoSans",
                fontWeight: FontWeight.w700)),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          primary: Color(0XFF0380E3),
        ),
      ),
    );
  }
}
// class TextButtonEsqueceuSenha extends StatelessWidget {
//   final Function() onTap;
//   const TextButtonEsqueceuSenha({Key? key, required this.onTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//             onPressed: onTap,
//             child: Text(
//               "Esqueceu sua senha?",
//               style: TextStyle(
//                   color: Color(0xFF616161),
//                   fontFamily: "NunitoSans",
//                   fontSize: 14),
//             ));
//   }
// }

// class TextButtonVejaComoQrCode extends StatelessWidget {
//   final Function() onTap;
//   const TextButtonVejaComoQrCode({Key? key, required this.onTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//         onPressed: onTap,
//         child: Text(
//           "VEJA COMO, POR AQUI",
//           style: TextStyle(
//               color: Colors.blue.shade500, fontFamily: "NunitoSansBold", fontSize: 15),
//         ));
//   }
// }

// class ButtonQrCode extends StatefulWidget {
//   ButtonQrCode({Key? key}) : super(key: key);

//   @override
//   _ButtonQrCodeState createState() => _ButtonQrCodeState();
// }

// class _ButtonQrCodeState extends State<ButtonQrCode> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//           shape: CircleBorder(), primary: Colors.white),
//       child: Container(
//           width: 75,
//           height: 75,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(shape: BoxShape.circle),
//           child: Icon(
//             Icons.qr_code_scanner_rounded,
//             size: 40,
//             color: Colors.black,
//           )),
//       onPressed: () {},
//     );
//   }
// }
