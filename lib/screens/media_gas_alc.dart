import 'package:flutter/material.dart';
import 'package:my_car/widgets/elevatedButton.dart';
import 'package:my_car/widgets/textfield.widget.dart';

class MediaGasAlc extends StatefulWidget {
  @override
  _MediaGasAlcState createState() => _MediaGasAlcState();
}

class _MediaGasAlcState extends State<MediaGasAlc> {
  TextEditingController mediaKm = TextEditingController();
  TextEditingController totalAbastecido = TextEditingController();
  TextEditingController valorLitro = TextEditingController();

  GlobalKey<FormState> chaveFormulario = GlobalKey<FormState>();

  String resultado = '';

  void limparCampos() {
    setState(() {
      totalAbastecido.text = '';
      valorLitro.text = '';
      mediaKm.text = '';
      resultado = '';
      chaveFormulario = GlobalKey<FormState>();
    });
  }

  void calcularMedia() {
    setState(() {
      double total = double.parse(
          totalAbastecido.text.replaceAll(new RegExp(r'[,  ]'), '.'));
      double litro =
          double.parse(valorLitro.text.replaceAll(new RegExp(r'[,  ]'), '.'));
      double media =
          double.parse(mediaKm.text.replaceAll(new RegExp(r'[,  ]'), '.'));
      double calculoGas = total / litro * media;
      resultado =
          '  O Veículo percorrera ${calculoGas.toStringAsFixed(0)} Km  ';
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
            'Quanto vou percorrer ? ',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.green[700],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Form(
                key: chaveFormulario,
                child: Column(
                  children: [
                    TextField2(
                        controller: totalAbastecido,
                        labelText: 'Digite o valor Total abastecido!',
                        validatorText: 'Digite o valor Total abastecido!'),
                    SizedBox(
                      height: 15,
                    ),
                    TextField2(
                        controller: valorLitro,
                        labelText: 'Digite o Valor do Litro do Combustivel!',
                        validatorText:
                            'Digite o Valor do Litro do Combustivel!'),
                    SizedBox(
                      height: 15,
                    ),
                    TextField2(
                        controller: mediaKm,
                        labelText: 'Digite a média do Veiculo!',
                        validatorText: 'Digite a média do Veiculo!'),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 80,
                      width: 160,
                      child: ElevatedButton2(
                        buttonName: 'Calcular',
                        onPressed: () {
                          if (chaveFormulario.currentState.validate()) {
                            calcularMedia();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 160,
                      child: ElevatedButton2(
                        buttonName: 'Limpar',
                        onPressed: limparCampos,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 340,
                      child: ElevatedButton2(
                        buttonName: '${resultado.toString()}',
                        onPressed: limparCampos,
                      ),
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
