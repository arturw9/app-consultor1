import 'package:flutter/material.dart';

class SituacaoAtivo extends StatelessWidget {
  const SituacaoAtivo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'AT',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFF41A041),
      radius: 12,
    );
  }
}

class SituacaoInativo extends StatelessWidget {
  const SituacaoInativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'IN',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFFD45D53),
      radius: 12,
    );
  }
}

class SituacaoVencer extends StatelessWidget {
  const SituacaoVencer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'AV',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFFA69d39),
      radius: 12,
    );
  }
}

class SituacaoAtestado extends StatelessWidget {
  const SituacaoAtestado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'AT',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFF282826),
      radius: 12,
    );
  }
}

class SituacaoFerias extends StatelessWidget {
  const SituacaoFerias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'FR',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFF8a8184),
      radius: 12,
    );
  }
}

class SituacaoNormais extends StatelessWidget {
  const SituacaoNormais({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'NO',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFFEBEFF5),
      radius: 12,
    );
  }
}

class SituacaoCancelados extends StatelessWidget {
  const SituacaoCancelados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'CA',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFFA9433A),
      radius: 12,
    );
  }
}

class SituacaoRenovados extends StatelessWidget {
  const SituacaoRenovados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'RN',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFF4EBEE0),
      radius: 12,
    );
  }
}

class SituacaoInacacelados extends StatelessWidget {
  const SituacaoInacacelados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'CA',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFFAF4337),
      radius: 12,
    );
  }
}

class SituacaoDesistentes extends StatelessWidget {
  const SituacaoDesistentes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'DE',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFF98303B),
      radius: 12,
    );
  }
}

class SituacaoVencidos extends StatelessWidget {
  const SituacaoVencidos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'VE',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFF9D3FB1),
      radius: 12,
    );
  }
}

class SituacaoTrancados extends StatelessWidget {
  const SituacaoTrancados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'TR',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFFCDB452),
      radius: 12,
    );
  }
}

class SituacaoTranvencidos extends StatelessWidget {
  const SituacaoTranvencidos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'TV',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFFAB9B36),
      radius: 12,
    );
  }
}

class SituacaoVisitantes extends StatelessWidget {
  const SituacaoVisitantes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'VI',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFF9DC552),
      radius: 12,
    );
  }
}

class SituacaoDiaria extends StatelessWidget {
  const SituacaoDiaria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'DI',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFF279BAD),
      radius: 12,
    );
  }
}

class SituacaoFreepass extends StatelessWidget {
  const SituacaoFreepass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        'PL',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: Color(0XFF3DBBC3),
      radius: 12,
    );
  }
}
