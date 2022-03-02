import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _price = '0';

  _getPrice() async {
    http.Response response =
        await http.get(Uri.parse('https://blockchain.info/ticker'));
    Map<String, dynamic> resp = json.decode(response.body);
    setState(() {
      _price = resp['BRL']['buy'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png'),
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                ),
                child: Text(
                  "R\$ " + _price,
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              RaisedButton(
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                child: Text(
                  'Atualizar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: _getPrice,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
