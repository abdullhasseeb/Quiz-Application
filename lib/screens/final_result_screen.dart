import 'package:flutter/material.dart';
import 'package:quiz/constants/colors.dart';
import 'package:quiz/screens/checking_answers.dart';

class ResultScreen extends StatefulWidget {
  final resultRecord;
  final userSelectedQuizQuestions;
  final userOptionsList;

  ResultScreen({
    required this.userSelectedQuizQuestions,
    required this.resultRecord,
    required this.userOptionsList
});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int score = 0;



  @override
  void initState() {
    super.initState();
    countScore();
  }

  countScore() async{
    //print('enetr in counting score');
    for(int i = 0; i < widget.resultRecord.length; i++){
      int selectedOptionIndex = widget.resultRecord[i]['selectedOptionIndex'];
      int answerIndex = widget.resultRecord[i]['currentQuestionOption'];
      if(selectedOptionIndex == answerIndex){
        score++;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(Navigator.of(context).canPop()){
          return true;
        }else{
          return await doubleTapToExit(context);
        }
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          leading:InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.home,
                color: orange,
                size: 35,
              )
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (score > 5) ? Column(
                children: [
                  Image.asset(
                      'assets/images/trophy.png',
                    height: 170,
                    width: 170,
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    'Congratulations!',
                    style: TextStyle(
                      color: orange,
                      fontSize: 24
                    ),
                  )
                ],
              ):
                  Icon(
                      Icons.emoji_emotions_outlined,
                    size: 170,
                    color: orange,
                    shadows: const [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(1, 1)
                      )
                    ],
                  ),
              const SizedBox(height: 50,),
              Text(
                  'Your score: $score/10',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10,),
              Column(
                children: [
                  InkWell(
                    onTap: (){
                     showQuestions();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 50),
                      decoration: BoxDecoration(
                        color: white,
                        boxShadow: const [
                          BoxShadow(
                              color:Colors.black54,
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: Offset(1, 1)
                          ),
                          BoxShadow(
                              color: Colors.white,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(-1, -1)
                          )
                        ],
                          borderRadius: const BorderRadius.all(Radius.circular(20))
                      ),
                      child: Text(
                          'Lets Check result',
                        style: TextStyle(
                          color: orange,
                        ),
                      ),
                    ),
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _doubleTapped = false;
  Future<bool> doubleTapToExit(BuildContext context) async {
    if (_doubleTapped) {
      return true; // Allow the app to exit
    }
    _doubleTapped = true;

    // Use ScaffoldMessenger to show the SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Press back again to exit.'),
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      _doubleTapped = false;
    });
    return false; // Prevent the app from exiting
  }

  showQuestions(){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckAnswersScreen(
              userSelectedQuizQuestions: widget.userSelectedQuizQuestions,
              userOptionsList: widget.userOptionsList
          ),
        )
    );
  }
}
