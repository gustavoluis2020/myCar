import 'package:flutter/material.dart';
import 'package:my_car/widgets/elevatedButton.dart';

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Notas extends StatefulWidget {
  String valor;

  Notas({this.valor});
  @override
  _NotasState createState() => _NotasState();
}

class _NotasState extends State<Notas> {
  final controleCampoAnotacao = TextEditingController();

  List listaAnotacoes = [];

  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    lerAnotacoes().then((anotacoesData) {
      setState(() {
        listaAnotacoes = json.decode(anotacoesData);
      });
    });
  }

  void addAnotacoes() {
    setState(() {
      Map<String, dynamic> novaAnotacao = Map();
      novaAnotacao['titulo'] = controleCampoAnotacao.text;
      controleCampoAnotacao.text = '';
      novaAnotacao['ok'] = false;
      listaAnotacoes.add(novaAnotacao);
      salvarAnotacoes();
    });
  }

  Future<Null> refreshAtualizar() async {
    await Future.delayed(Duration(seconds: 1));
    //
    setState(() {
      listaAnotacoes.sort((a, b) {
        if (a['ok'] && !b['ok'])
          return 1;
        else if (!a['ok'] && b['ok'])
          return -1;
        else
          return 0;
      });
      salvarAnotacoes();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 15,
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/");
          },
        ),
        appBar: AppBar(
          title: Text(
            'Minhas Anotações',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controleCampoAnotacao,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Nova Anotação',
                        labelStyle: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 80,
                    width: 140,
                    child: ElevatedButton2(
                      buttonName: 'Add',
                      onPressed: addAnotacoes,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: refreshAtualizar,
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  itemCount: listaAnotacoes.length,
                  itemBuilder: checkBoxListTile,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Deslize para apagar !',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget checkBoxListTile(context, index) {
    final anotacaoApagada = listaAnotacoes[index];

    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      onDismissed: (direcao) {
        setState(() {
          listaAnotacoes.removeAt(index);
        });
        Scaffold.of(context).showSnackBar(SnackBar(
            content:
                Text('Anotação foi ${anotacaoApagada['titulo']} removida!')));
        salvarAnotacoes();
      },
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete_forever,
            color: Colors.white,
          ),
        ),
      ),
      child: CheckboxListTile(
        title: Text(
          listaAnotacoes[index]['titulo'],
        ),
        value: listaAnotacoes[index]['ok'],
        secondary: CircleAvatar(
          child: Icon(listaAnotacoes[index]['ok'] ? Icons.check : Icons.error),
        ),
        onChanged: (marcouCaixa) {
          setState(() {
            listaAnotacoes[index]['ok'] = marcouCaixa;
            salvarAnotacoes();
          });
        },
      ),
    );
  }

  Future<File> pegarAnotacao() async {
    final diretorioSalvarAnotacao = await getApplicationDocumentsDirectory();
    return File('${diretorioSalvarAnotacao.path}/data.json');
  }

  Future<File> salvarAnotacoes() async {
    String dadoAnotacao = json.encode(listaAnotacoes);
    final arquivo = await pegarAnotacao();
    return arquivo.writeAsString(dadoAnotacao);
  }

  Future<String> lerAnotacoes() async {
    try {
      final arquivo = await pegarAnotacao();
      return arquivo.readAsString();
    } catch (erro) {
      return null;
    }
  }
}
