import 'package:flutter/material.dart';
import 'package:rehab_task/choice_screen.dart';
import 'package:rehab_task/main.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late double width = 100;
  late double height = 100;
  late double opacity = 1;
  late AnimationController animationController;
  late Animation<Offset> shadowOffsetAnimation;
  late Animation<Offset> shadowOffsetAnimation2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(seconds: 1),
    );

    shadowOffsetAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(10, 10),
    ).animate(animationController);
    shadowOffsetAnimation2 = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(-10, -10),
    ).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
        // animationController.forward();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
        // animationController.reverse();
      }
      // animationController.repeat();
    });
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
      appBar: AppBar(
        title: const Text('Moody tones'),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(seconds: 2),
                  child: const Text(
                    "Click ... 👇👇",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                AnimatedContainer(
                  margin: const EdgeInsets.only(top: 15),
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOut,
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      color: App.navy,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).shadowColor.withOpacity(0.4),
                            blurRadius: 15,
                            spreadRadius: 1,
                            offset: const Offset(4, 0))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: TextFormField(
                        controller: controller,
                        maxLines: 10,
                        onTap: () {
                          setState(() {
                            width = MediaQuery.of(context).size.width * 0.85;
                            height = MediaQuery.of(context).size.height * 0.5;
                            opacity = 0;
                            animationController.forward();
                          });
                        },
                        maxLength: 280,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide:
                                    BorderSide(color: App.lightFuchsia))),
                        cursorRadius: const Radius.circular(10),
                        cursorColor: App.mauva,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Container(
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Choice()));
                    },
                    style: ButtonStyle(),
                    child: Text(
                      'Predict',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
