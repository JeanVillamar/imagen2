// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Mario Bross'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  static double mariox = -0.10;
  static double marioy = 1.0;
  static double krysx = 0.10;
  static double krysy = 1.05;
  static double coinX = 0.20;
  static double coinY = 0.0;
  double timeM = 0;
  double heightM = 0;
  double timeK = 0;
  double heightK = 0;
  static double vidas = 5;
  static double puntos = 0;
  static double tiempo = 120;
  double initialPosM = marioy;
   double initialPosK = krysy;
  String directionM = "right";
  bool gameOver = false;
  
  //movimiento con flechas de Mario
  void preJumpM() {
    timeM = 0;
    initialPosM = marioy;
  }
  void jumpMario() {
    preJumpM();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      timeM += 0.05;
      heightM = -4.9 * timeM * timeM + 5 * timeM;
      if (initialPosM - heightM > 1) {
        setState(() {
          marioy = 1;
        });
      } else {
        setState(() {
          marioy = initialPosM - heightM;
        });
      }
    });
  }
  void walkMarioL() {
    directionM = "left";
    setState(() {
      mariox -= 0.02;
    });
  }
  void walkMarioR() {
    directionM = "right";
    setState(() {
      mariox += 0.02;
    });
  }
  
  //movimiento con flechas de Krystel
  void preJumpK() {
    timeK = 0;
    initialPosK = krysy;
  }
  void jumpKrys() {
    preJumpK();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      timeK += 0.05;
      heightK = -4.9 * timeK * timeK + 5 * timeK;
      if (initialPosK - heightK > 1) {
        setState(() {
          krysy = 1;
        });
      } else {
        setState(() {
          krysy = initialPosK - heightK;
        });
      }
    });
  }
  void walkKrysL() {
    setState(() {
      krysx -= 0.02;
    });
  }
  void walkKrysR() {
    setState(() {
      krysx += 0.02;
    });
  }
  
  //monedas
  void startGame() {
    do{
      if((mariox == coinX && marioy == coinY)
          || (krysx == coinX && krysy == coinY)){
        Random random = new Random();
        int randomX = random.nextInt(100); 
        int randomY = random.nextInt(100); 
        setState(() {
          puntos +=10;
          coinX = randomX/100;
          coinY = randomY/100;
        });
      }
    }while(!gameOver);
  }
  
  void timeManage(){
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if(tiempo == 0){
        gameOver = true;
      }
      setState(() {
        tiempo -= 1;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      const Text(
                        'Vidas', 
                        style: const TextStyle(color: Colors.white)
                      ),
                      Text(
                        vidas.toString(), 
                        style: const TextStyle(color: Colors.white)
                      )
                      ]
                    ),
                    Column(children: [
                      const Text(
                        'Puntos', 
                        style: const TextStyle(color: Colors.white)
                      ),
                      Text(
                        puntos.toString(), 
                        style: const TextStyle(color: Colors.white)
                      )
                      ]
                    ),
                    Column(children: [
                      const Text(
                        'Tiempo', 
                        style: const TextStyle(color: Colors.white)
                      ),
                      Text(
                        tiempo.toString(), 
                        style: const TextStyle(color: Colors.white)
                      )
                      ]
                    )
                  ]
                )
              )
          ),
        Expanded(
            flex: 4,
            child: Container(
                color: Colors.blue,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(coinX, coinY),
                      duration: Duration(milliseconds: 0),
                      child: Coin()
                      ),
                    AnimatedContainer(
                      alignment: Alignment(mariox, marioy),
                      duration: Duration(milliseconds: 0),
                      child: Mario(
                        direction: directionM,)
                      ),
                    AnimatedContainer(
                      alignment: Alignment(krysx, krysy),
                      duration: Duration(milliseconds: 0),
                      child: Krystel()
                      )
                    
                  ]
                ) 
              )
            
            ),
        Container(height: 10, color: Colors.green),
        Expanded(
            flex: 1,
            child: Container(
                color: Colors.brown,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: walkMarioL,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.brown[300],
                            child: const Icon(Icons.arrow_back),
                          )),
                      GestureDetector(
                          onTap: jumpMario,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.brown[300],
                            child: const Icon(Icons.arrow_upward),
                          )),
                      GestureDetector(
                          onTap: walkMarioR,
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              color: Colors.brown[300],
                              child: const Icon(Icons.arrow_forward))),
                      GestureDetector(
                          onTap: walkKrysL,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.brown[300],
                            child: const Icon(Icons.arrow_back),
                          )),
                      GestureDetector(
                          onTap: jumpKrys,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.brown[300],
                            child: const Icon(Icons.arrow_upward),
                          )),
                      GestureDetector(
                          onTap: walkKrysR,
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              color: Colors.brown[300],
                              child: const Icon(Icons.arrow_forward))),
                    ]))),
        Expanded(
            flex: 1,
            child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text('Mario'),
                    Text('VS'),
                    Text('Krystel')
                  ]
                )))
      ]),
    );
  }
}
class Mario extends StatelessWidget{
  
  final direction;
  
  Mario({this.direction});
  
  @override
  Widget build(BuildContext context){
    if (direction == "right"){
      return Container(
        width: 50,
        height: 50,
        child: Image.network(
                        "https://cdn.pixabay.com/photo/2021/02/11/15/40/mario-6005703_960_720.png")
      );
    }else{
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
        width: 50,
        height: 50,
        child: Image.network(
                        "https://cdn.pixabay.com/photo/2021/02/11/15/40/mario-6005703_960_720.png")
      ));
    }
  }
}
class Krystel extends StatelessWidget{
 
  @override
  Widget build(BuildContext context){
      return Container(
        width: 60,
        height: 60,
        child: Image.network(
                        "https://lh3.googleusercontent.com/drive-viewer/AJc5JmTqwFMoiDJGNU1hG3q6KiJPwEZ9wX_PBMevNDP42LPmwKYHUDcKxSOXEkLzU-FDvQNW6IUP5ug=w1325-h658")
      );
  }
}
class Coin extends StatelessWidget{
 
  @override
  Widget build(BuildContext context){
      return Container(
        width: 50,
        height: 50,
        child: Image.network(
                        "https://lh3.googleusercontent.com/drive-viewer/AJc5JmSOOY14dPL9K9gODFP3rAIiMk9K40iavfckpZT0JJry3kWCvgJdw8QQqWeFQa8fVO7T6x3312g=w1325-h658")
      );
  }
}