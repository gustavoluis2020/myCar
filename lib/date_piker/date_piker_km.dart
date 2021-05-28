import 'package:flutter/material.dart';
import 'package:my_car/contants.dart';
import 'package:my_car/widgets/elevatedButton.dart';
import 'package:my_car/widgets/textfield.widget.dart';

class DatePikerKM extends StatefulWidget {
  @override
  _DatePikerKMState createState() => _DatePikerKMState();
}

class _DatePikerKMState extends State<DatePikerKM> {
  DateTime date = DateTime.now();
  DateTime date2 = DateTime.now();

  String totalDias = '';

  TextEditingController kminicial = TextEditingController();
  TextEditingController kmfinal = TextEditingController();

  GlobalKey<FormState> chaveFormulario = GlobalKey<FormState>();

  double diferenca, meses, ano;

  String resultadoFinal = '';

  String resultadokm = '';

  void limparCamposKm() {
    setState(() {
      kminicial.text = '';
      kmfinal.text = '';
      date = DateTime.now();
      date2 = DateTime.now();
      resultadokm = '';
      totalDias = '';
      resultadoFinal = '';

      chaveFormulario = GlobalKey<FormState>();
    });
  }

  Future<Null> selectDate1(BuildContext context) async {
    DateTime datePiker = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1901),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget child) {
          return Theme(
            child: child,
            data: ThemeData(
              primarySwatch: appColor,
              primaryColor: appColor,
              accentColor: appColor,
            ),
          );
        });

    if (datePiker != null && datePiker != date) {
      setState(() {
        date = datePiker;
        print(date);
      });
    }
  }

  Future<Null> selectDate2(BuildContext context) async {
    DateTime datePiker = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1901),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget child) {
          return Theme(
            child: child,
            data: ThemeData(
              primarySwatch: appColor,
              primaryColor: appColor,
              accentColor: appColor,
            ),
          );
        });

    if (datePiker != null && datePiker != date2) {
      setState(() {
        date2 = datePiker;
        print(date2);
      });
    }
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
        ),
        appBar: AppBar(
          title: Text('Meu Km'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Form(
                    key: chaveFormulario,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 360,
                              decoration: BoxDecoration(
                                color: Colors.green[700],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        selectDate1(context);
                                      }),
                                  Text(
                                    'Selecione a Data Inicial',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    ' ${date.day.toString()}/${date.month.toString()}/${date.year.toString()}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 360,
                              decoration: BoxDecoration(
                                color: Colors.green[700],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        selectDate2(context);
                                      }),
                                  Text(
                                    'Selecione a Data Final',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    ' ${date2.day.toString()}/${date2.month.toString()}/${date2.year.toString()}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField2(
                            controller: kminicial,
                            labelText: 'Digite o KM inicial!',
                            validatorText: 'Digite o KM inicial!'),
                        SizedBox(
                          height: 20,
                        ),
                        TextField2(
                            controller: kmfinal,
                            labelText: 'Digite o KM Final!',
                            validatorText: 'Digite o KM Final!'),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 90,
                              width: 150,
                              child: ElevatedButton2(
                                buttonName: 'Calcular',
                                onPressed: () {
                                  if (chaveFormulario.currentState.validate()) {
                                    calcularDia();
                                    calcularKm();
                                    calculoGeral();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              height: 90,
                              width: 150,
                              child: ElevatedButton2(
                                buttonName: 'Limpar',
                                onPressed: () {
                                  limparCamposKm();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 150,
                          width: 360,
                          decoration: BoxDecoration(
                            color: Colors.green[700],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                totalDias,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                resultadokm,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                resultadoFinal,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calcularDia() {
    setState(() {
      var diferenca = date2.difference(date).inDays;
      var meses = diferenca / 30;
      var ano = diferenca / 365;

      totalDias =
          'Total de ${diferenca} dias, ${meses.toStringAsFixed(0)} mese(s) e ${ano.toStringAsFixed(0)} ano(s)';
      print('${diferenca}');
    });
  }

  void calcularKm() {
    setState(() {
      double kmI = double.parse(kminicial.text);
      double kmF = double.parse(kmfinal.text);
      double calculokm = kmF - kmI;

      resultadokm = 'Você percorreu ${calculokm.toStringAsFixed(0)} Km ';
    });
  }

  void calculoGeral() {
    setState(() {
      var diferenca = date2.difference(date).inDays;
      var meses = diferenca / 30;
      var ano = diferenca / 365;
      double kmI = double.parse(kminicial.text);
      double kmF = double.parse(kmfinal.text);
      double calculokm = kmF - kmI;
      double geral1 = calculokm / diferenca;
      double geral2 = calculokm / meses;
      double geral3 = calculokm / ano;
      resultadoFinal = ' ${geral1.toStringAsFixed(2)} Km dia '
          ' ${geral2.toStringAsFixed(2)} Km mês '
          ' ${geral3.toStringAsFixed(2)} Km ano';
    });
  }
}
