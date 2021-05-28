import 'package:flutter/material.dart';
import 'package:my_car/widgets/elevatedButton.dart';
import 'package:my_car/widgets/textfield.widget.dart';

class GasOuAl extends StatefulWidget {
  const GasOuAl({
    Key key,
  }) : super(key: key);
  @override
  _GasOuAlState createState() => _GasOuAlState();
}

class _GasOuAlState extends State<GasOuAl> {
  String resultado;

  GlobalKey<FormState> chaveFormulario = GlobalKey<FormState>();

  TextEditingController gasolina = TextEditingController();
  TextEditingController alcool = TextEditingController();

  String resultadoFinal = '';

  void limparCampos() {
    setState(() {
      gasolina.text = '';
      alcool.text = '';
      resultadoFinal = '';
      chaveFormulario = GlobalKey<FormState>();
    });
  }

  void calcular() {
    setState(() {
      double valorGas =
          double.parse(gasolina.text.replaceAll(new RegExp(r'[,  ]'), '.')) /
              100;
      double valorAlc =
          double.parse(alcool.text.replaceAll(new RegExp(r'[,  ]'), '.')) / 100;

      double calculo = valorAlc / valorGas;
      if (calculo > 0.7) {
        resultadoFinal = 'Compensa Utilizar Gasolina!';
      } else {
        resultadoFinal = 'Compensa Utilizar Álcool !';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/");
          },
          backgroundColor: Colors.green[700],
        ),
        appBar: AppBar(
          title: Text(
            'Álcool ou Gasolina',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.green[700],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Form(
                key: chaveFormulario,
                child: Column(
                  children: [
                    TextField2(
                        controller: gasolina,
                        labelText: '   Digite o valor do Litro da Gasolina!',
                        validatorText: 'Digite o Valor do Litro da Gasolina!'),
                    SizedBox(
                      height: 15,
                    ),
                    TextField2(
                        controller: alcool,
                        labelText: '   Digite o valor do Litro do Álcool!',
                        validatorText: 'Digite o valor do Litro do Álcool!'),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 80,
                      width: 160,
                      child: ElevatedButton2(
                          buttonName: 'Calcular',
                          onPressed: () {
                            if (chaveFormulario.currentState.validate()) {
                              calcular();
                            }
                          }),
                    ),
                    SizedBox(
                      height: 80,
                      width: 160,
                      child: ElevatedButton2(
                          buttonName: 'Limpar', onPressed: limparCampos),
                    ),
                    SizedBox(
                      height: 90,
                      width: 300,
                      child: ElevatedButton2(
                          buttonName: resultadoFinal, onPressed: calcular),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
