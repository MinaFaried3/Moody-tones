import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:rehab_task/main.dart';
import 'package:rehab_task/playlist.dart';
import 'package:rehab_task/song.dart';

import 'books.dart';

class Choice extends StatefulWidget {
  const Choice({super.key});

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late double width = 100;
  late double height = 100;
  late double opacity = 1;
  late AnimationController animationController;
  late Animation<Offset> shadowOffsetAnimation;
  late Animation<Offset> shadowOffsetAnimation2;
  late double val = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 500),
    );

    shadowOffsetAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(10, 10),
    ).animate(animationController);
    shadowOffsetAnimation2 = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(-10, -10),
    ).animate(animationController);
    // animationController.addListener(() {
    //   setState(() {});
    // });
    //
    // animationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     animationController.reverse();
    //     animationController.forward();
    //   } else if (status == AnimationStatus.dismissed) {
    //     animationController.forward();
    //     animationController.reverse();
    //   }
    //   // animationController.repeat();
    // });
    //
    // animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '😃',
                        style: TextStyle(fontSize: 100),
                      ),
                    )),
                Expanded(
                  flex: 4,
                  child: Container(
                      // width: 100,
                      height: 200,
                      padding: EdgeInsets.all(10),
                      child: FlutterSlider(
                        values: [0],
                        max: 20,
                        min: 0,
                        trackBar: FlutterSliderTrackBar(
                          inactiveTrackBarHeight: 14,
                          activeTrackBarHeight: 10,
                          inactiveTrackBar: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            border: Border.all(width: 3, color: App.mauva),
                          ),
                          activeTrackBar: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: App.beige),
                        ),
                        step: FlutterSliderStep(step: 10),
                        jump: true,
                        handler: customHandler(Icons.arrow_circle_right),
                        tooltip: FlutterSliderTooltip(custom: (value) {
                          val = value;
                          switch (value) {
                            case 0:
                              return Text('Generate Music');
                            case 10:
                              return Text('Recommend PlayList');
                            default:
                              return Text('Poetry');
                          }
                        }),
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: shadowOffsetAnimation.value,
                      blurRadius: 20,
                      spreadRadius: 0.5,
                      color: Colors.grey,
                    ),
                    BoxShadow(
                      offset: shadowOffsetAnimation2.value,
                      blurRadius: 20,
                      spreadRadius: 0.5,
                      color: App.paleVioletRed,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    switch (val) {
                      case 0:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Song()));
                      case 10:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PlayList()));
                      default:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Books()));
                    }
                  },
                  style: ButtonStyle(),
                  child: Text(
                    'Go',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  customHandler(IconData icon) {
    return FlutterSliderHandler(
      decoration: BoxDecoration(),
      child: Container(
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(color: App.beige, shape: BoxShape.circle),
          child: Icon(
            icon,
            color: App.paleVioletRed,
            size: 23,
          ),
        ),
        decoration: BoxDecoration(
          color: App.mauva,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                spreadRadius: 0.05,
                blurRadius: 5,
                offset: Offset(0, 1))
          ],
        ),
      ),
    );
  }
}
