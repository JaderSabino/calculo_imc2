import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculo_IMC",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoControler = TextEditingController();
  TextEditingController alturaControler = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _status = "Informe seus dados";

  void _reset() {
    pesoControler.text = "";
    alturaControler.text = "";
    setState(() {
      _status = "Informe seus dados";
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoControler.text);
      double altura = double.parse(alturaControler.text) / 100;

      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _status = "Abaixo do Peso! ($imc)";
      } else if (imc >= 18.6 && imc < 24.9) {
        _status = "Peso Ideal! ($imc)";
      } else if (imc >= 24.9 && imc < 29.9) {
        _status = "Levemente Acima do Peso! ($imc)";
      } else if (imc >= 29.9 && imc < 34.9) {
        _status = "Obesidade Grau I! ($imc)";
      } else if (imc >= 34.9 && imc < 39.9) {
        _status = "Obesidade Grau II! ($imc))";
      } else {
        _status = "Obesidade Grau III! ($imc)";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _reset();
                })
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline, size: 120, color: Colors.green),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (Kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: pesoControler,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (Cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: alturaControler,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua Altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            if(_formKey.currentState.validate()) {
                              _calcular();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          color: Colors.green,
                        )),
                  ),
                  Text(
                    "$_status",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  )
                ],
              ),
            )));
  }
}
