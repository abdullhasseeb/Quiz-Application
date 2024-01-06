import 'package:flutter/material.dart';
import 'package:quiz/screens/choose_quiz_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../widgets/button.dart';

class FirstTimeOpenApp extends StatefulWidget {

  const FirstTimeOpenApp({super.key});

  @override
  State<FirstTimeOpenApp> createState() => _FirstTimeOpenAppState();
}

class _FirstTimeOpenAppState extends State<FirstTimeOpenApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/quiz.png',
                scale: 3,
              ),
              SizedBox(height: 20,),
              Text(
                'Welcome to Quiz App!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: orange,
                    fontSize: 24,
                    shadows: const [
                      Shadow(
                          color: Colors.black54,
                          blurRadius: 5,
                          offset: Offset(1, 0)
                      )
                    ]
                ),
              ),
              const SizedBox(height: 50,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                    color: white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-1,-1),
                        spreadRadius: 1,
                        blurRadius: 2
                      ),
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(1, 1),
                        spreadRadius: 0,
                        blurRadius: 3
                      )
                    ]
                ),
                child: const Text(
                    'Get ready to challenge your knowledge and have fun with our exciting quiz app.'
                        ' Whether you\'re a trivia enthusiast or just looking for a fun way to test'
                        ' your brain, we\'ve got you covered.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Button(
                onTap: _onTap,
                text: 'Next',
              )
            ],
          )
        ),
      ),
    );
  }

  _onTap()async{
    var getRef = await SharedPreferences.getInstance();
    ///set here false it means screen directly go from splash to choose quiz type
    await getRef.setBool('firstTimeOpen', false);
    await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChooseQuizType(),));
  }
}
