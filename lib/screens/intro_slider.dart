import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:my_car/date_piker/date_piker_km.dart';
import 'package:my_car/screens/alcool_ou_gasolina.dart';

import 'package:my_car/screens/media_gas_alc.dart';

import 'package:my_car/screens/notas.dart';

class IntroSliderPage extends StatefulWidget {
  @override
  _IntroSliderPageState createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();
    Container();
    slides.add(
      new Slide(
        title: 'Álcool ou Gasolina',
        description: 'Qual é mais vantajoso?',
        pathImage: "assets/image/gas1.png",
        onCenterItemPress: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => GasOuAl(),
          ),
        ),
      ),
    );
    slides.add(
      new Slide(
        title: 'Qual Combustível?',
        description: 'Media por km',
        pathImage: "assets/image/gas2.png",
        onCenterItemPress: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MediaGasAlc(),
          ),
        ),
      ),
    );
    slides.add(
      new Slide(
        title: 'Meu Km',
        description: 'Calcule quanto você rodou',
        pathImage: "assets/image/road.png",
        onCenterItemPress: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DatePikerKM(),
          ),
        ),
      ),
    );
    slides.add(
      new Slide(
        title: 'Sobre Meu Carro',
        description: 'Historico de Manutenções',
        pathImage: "assets/image/car3.png",
        onCenterItemPress: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Notas(),
          ),
        ),
      ),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(
        GestureDetector(
          onTap: currentSlide.onCenterItemPress,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Container(
              margin: EdgeInsets.only(bottom: 160, top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Meu Carro',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      currentSlide.pathImage,
                      matchTextDirection: true,
                      height: 120,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      currentSlide.title,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Text(
                      currentSlide.description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    margin: EdgeInsets.only(
                      top: 15,
                      left: 20,
                      right: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      backgroundColorAllSlides: Colors.green[700],
      renderSkipBtn: Text(
        "Voltar",
        style: TextStyle(color: Colors.green[700]),
      ),
      renderNextBtn: Text(
        "Próximo",
        style: TextStyle(color: Colors.green[700]),
      ),
      renderDoneBtn: Text(
        "Fim",
        style: TextStyle(color: Colors.green[700]),
      ),
      colorSkipBtn: Colors.white,
      colorDoneBtn: Colors.white,
      colorActiveDot: Colors.white,
      sizeDot: 8.0,
      typeDotAnimation: dotSliderAnimation.DOT_MOVEMENT,
      listCustomTabs: this.renderListCustomTabs(),
      scrollPhysics: BouncingScrollPhysics(),
      hideStatusBar: false,
      onDonePress: () {},
    );
  }
}
