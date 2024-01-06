import 'package:flutter/material.dart';
import '../constants/colors.dart';

class Welcome extends StatefulWidget {
  final checkStarting;
  final startTimer;

  const Welcome({super.key,
    required this.checkStarting,
    required this.startTimer,
});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with TickerProviderStateMixin {
  Color buttonColor = white;
  Color arrowColor = orange;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: orange,
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xfffa9855),
                    Color(0xffED7D31),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/quiz1.png',
                scale: 2,
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.4,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.343,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 3,
                                spreadRadius: 0
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Center(
                          child: Text(
                            'You will have 30 seconds to answer each of the 10 questions.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: orange,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: ()async {
                            _onTap();
                            await Future.delayed(const Duration(milliseconds: 100 ));
                            setState(() {
                              widget.checkStarting();
                              widget.startTimer();
                            });
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: const BorderRadius.all(Radius.circular(
                                    40)),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.white,
                                      spreadRadius: 0,
                                      blurRadius: 1,
                                      offset: Offset(-1, -1)
                                  ),
                                  BoxShadow(
                                      color: Colors.black54,
                                      spreadRadius: 0,
                                      blurRadius: 1,
                                      offset: Offset(1, 1)
                                  )
                                ]
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 50,
                              color: arrowColor,
                              shadows: const [
                                Shadow(
                                    color: Colors.black54,
                                    blurRadius: 5,
                                    offset: Offset(1, 1)
                                )
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  _onTap() async {
    setState(() {
      buttonColor = orange;
      arrowColor = white;
    });
    await Future.delayed(const Duration(milliseconds: 50));
    setState(() {
      buttonColor = white;
      arrowColor = orange;
    });
  }
}