import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz/screens/choose_quiz_type.dart';
import 'package:quiz/screens/first_time_open_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
        super.initState();
        Timer(const Duration(seconds: 2,),() async {
          var getPref = await SharedPreferences.getInstance();
          // if sharedPredf doesn't contains firstTimeOpen
          // it means app first time opened go to else part
          if(getPref.containsKey('firstTimeOpen')){
            // if sharedPref contains then
            if(getPref.getBool('firstTimeOpen') == false){
              // if its value is true then go to First Time Screen
              await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChooseQuizType(),));
            }
          }
          else{
            //its else part if key doesn't contains
            await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FirstTimeOpenApp()
                )
            );
          }
        });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xfffa9855),
                  orange,
                ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset(
                  'assets/images/logo.png',
                scale: 3.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
