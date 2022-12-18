import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
      title: "Water-Animation",
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController? firstController;
  Animation<double>? firstAnimation;

  AnimationController? secondController;
  Animation<double>? secondAnimation;

  AnimationController? thirdController;
  Animation<double>? thirdAnimation;

  AnimationController? fourthController;
  Animation<double>? fourthAnimation;
  AnimationController? waterHeightController;
  bool tapClicked=false;

  increaseWater(){
    waterHeightController = AnimationController(duration: Duration(seconds:5),vsync: this);
    waterHeightController!.forward();
    waterHeightController!.addListener(() {
      setState(() {

      });
      print(waterHeightController!.value);});
  }
  @override
  void initState() {
    super.initState();

    firstController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    firstAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: firstController!, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          firstController!.forward();
        }
      });

    secondController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    secondAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: secondController!, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController!.forward();
        }
      });

    thirdController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: thirdController!, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          thirdController!.forward();
        }
      });

    fourthController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: fourthController!, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          fourthController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          fourthController!.forward();
        }
      });


    Timer(Duration(seconds: 2), () {
      firstController!.forward();
    });

    Timer(Duration(milliseconds: 1600), () {
      secondController!.forward();
    });

    Timer(Duration(milliseconds: 800), () {
      thirdController!.forward();
    });

    fourthController!.forward();
    waterHeightController = AnimationController(duration: Duration(seconds:5),vsync: this);
  }


  @override
  void dispose() {
    firstController!.dispose();
    secondController!.dispose();
    thirdController!.dispose();
    fourthController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff2B2C56),
      body: Stack(
        children: [
          Center(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [GestureDetector(onTap: (){
                setState(() {
                  tapClicked=!tapClicked;
                  print(tapClicked);
                });
                if(tapClicked){
                  waterHeightController!.forward();
                  waterHeightController!.addListener(() {
                    setState(() {
                    });
                  });
                }else{
                  waterHeightController!.reverse();
                  waterHeightController!.addListener(() {
                    setState(() {
                    });
                  });
                }

              },child: Image.asset("assets/tap.png")),
                Visibility(visible: tapClicked,child: Container(width:60,height: size.height/1.46,color: Color(0xff3B6ABA).withOpacity(.8),)),


              ],
            ),
          ),

          Column(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomPaint(
                  painter: MyPainter(
                    firstAnimation!.value,
                    secondAnimation!.value,
                    thirdAnimation!.value,
                    fourthAnimation!.value,
                  ),
                  child: SizedBox(
                    height: 200,
                    width: size.width,
                  ),
                ),
              ),
              Align(alignment: Alignment.bottomCenter,child: Container(width: double.infinity,color: Color(0xff3B6ABA)
                ,height: 4.0*waterHeightController!.value*100,))
            ],
          ),  Center(
            child: Text('${(waterHeightController!.value*100).toInt()} %',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    wordSpacing: 3,
                    color: Colors.white.withOpacity(.7)),
                textScaleFactor: 7),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;

  MyPainter(
      this.firstValue,
      this.secondValue,
      this.thirdValue,
      this.fourthValue,
      );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xff3B6ABA)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height / firstValue)
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7,
          size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}