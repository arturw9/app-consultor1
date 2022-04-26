import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AvisoInternet extends StatefulWidget {
  @override
  State createState() {
    return _AvisoInternet();
  }
}

class _AvisoInternet extends State {
  StreamSubscription? internetconnection;
  bool isoffline = false;

  @override
  void initState() {
    internetconnection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        setState(() {
          isoffline = false;
        });
      }
    });

    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    internetconnection!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: errmsg("Sem conexão com Internet", isoffline),
    );
  }

  Widget errmsg(String text, bool show) {
    if (show == true) {
      return Container(
        width: MediaQuery.of(context).size.width * 1,
        padding: EdgeInsets.all(10.00),
        margin: EdgeInsets.only(bottom: 10.00),
        color: Color(0xFF0000).withOpacity(0.5),
        child: Row(children: [
          Container(
            margin: EdgeInsets.only(right: 6.00),
            child: Icon(Icons.info, color: Colors.white),
          ),
          Text(text, style: TextStyle(color: Colors.white)),
        ]),
      );
    } else {
      return Container();
    }
  }
}

class BaseWidget extends StatelessWidget {
  final Widget child;
  const BaseWidget({required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          Positioned(top: 30, child: AvisoInternet()),
        ],
      ),
    );
  }
}
