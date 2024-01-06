import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quiz/model/questions_model.dart';
import 'package:quiz/screens/final_result_screen.dart';
import 'package:quiz/widgets/welcome.dart';
import '../constants/colors.dart';
import '../widgets/question_card.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  List<QuestionsModel> userSelectedQuizQuestions ;
  Home({super.key,
    required this.userSelectedQuizQuestions
});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  //contains list of user inputed index
  List userOptionsList = [];

  // list of maps in which map contains currentIndex, userInputedIndex and actual index of question
  // used at line 70
  List<Map<String, dynamic>> resultRecord = [];

  CarouselController carouselController = CarouselController();

  //it is used to stop scroll in carousel slider
  bool scrollDisable = true;

  //start and home button show or not
  bool startQuizOption = false;
  bool visibleHomeIcon = false;

  // user selected index initial -1
  // because if there is -1 it means user doesn't choose any option
  // and automatically go to next question when time ends
  int selectedOptionIndex = -1;
  int currentIndex = 0;

  //variable for next, finish and prev buttons
  bool nextBtnShow = true;
  bool prevBtnShow = false;
  bool finishBtnShow = false;
  bool skipBtnShow = true;
  Color buttonColor = white;
  Color buttonTextColor = orange;
  Color skipButtonColor = white;
  Color skipTextColor = orange;

  //variables for progress timer indicator
  int totalDurationMilliseconds = 30000;
  var _remainingMilliseconds;
  Timer? _timer;

  Color bgColor = orange;

  double startOptionOpacity = 1;

  late AnimationController _timerController;

  String alertText = '';
  double alertTextOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    // check wheather there is start option or show quiz questions
    // and also reset all variables
    checkStarting();
    //print('next button is $nextBtnShow');
    _timerController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: totalDurationMilliseconds)
    );
    _timerController.repeat();
  }

  @override
  void dispose() {
    _timerController.dispose();
    _timer?.cancel();
    super.dispose();

  }

  void _skipQuestion()async{
    //if user didn't select any option then save -1 in userOptionsList and in map
    userOptionsList.add(-1);
    if(!nextBtnShow) {
      userOptionsList.add(-1);
      //print('userOptionsList : $userOptionsList');
      Map<String, dynamic> map = {
        'currentIndex' : currentIndex,
        'selectedOptionIndex' : -1,
        'currentQuestionOption' : widget.userSelectedQuizQuestions[currentIndex].correct_option
      };
      resultRecord.add(map);
     // print(userOptionsList);

      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
                resultRecord: resultRecord,
                userSelectedQuizQuestions: widget.userSelectedQuizQuestions,
                userOptionsList: userOptionsList
            ),
          )
      );
    }
    else{
      Map<String, dynamic> map = {
        'currentIndex' : currentIndex,
        'selectedOptionIndex' : -1,
        'currentQuestionOption' : widget.userSelectedQuizQuestions[currentIndex].correct_option
      };
      resultRecord.add(map);
      //move to next page
      currentIndex++;
      carouselController.animateToPage(currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutQuart
      );
      //start timer again for next page
      _startTimer();
      //decide that next button show or not
      if (!(currentIndex < widget.userSelectedQuizQuestions.length - 1)) {
        nextBtnShow = false;
        skipBtnShow = false;
      }
      selectedOptionIndex = -1;
      //print(userOptionsList);
      //print(resultRecord);
    }

  }

// if next button pressed then this method will execute
  void _nextQuestion() {
    //print('selected option : $selectedOptionIndex');
    setState(() {
      //first condition will true when we press next button
      //seconds condition will true if timer ends
      //it means there is both nextbutton and timer ends functionalities
      //for moving to next question
      if(selectedOptionIndex != -1 || _remainingMilliseconds == 0){
        alertTextOpacity = 0.0;
        userOptionsList.add(selectedOptionIndex);
       // print('userOptionsList : $userOptionsList');

          //store the questions results for record to checking answers with user user inputs
            Map<String, dynamic> map = {
              'currentIndex' : currentIndex,
              'selectedOptionIndex' : selectedOptionIndex,
              'currentQuestionOption' : widget.userSelectedQuizQuestions[currentIndex].correct_option
            };
            resultRecord.add(map);
           // print(resultRecord);

            //change Page
            currentIndex++;
            carouselController.animateToPage(currentIndex,
                duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutQuart
            );


            //start Timer again because it moves to next question
            _startTimer();

          //prev btn will show when there is 2nd question or above
            //it can be used if you use previous btn
            //uncomment if you want to use
          // if (currentIndex > 0) {
          //   prevBtnShow = true;
          // }

          //next btn not show when there is last question
          if (!(currentIndex < widget.userSelectedQuizQuestions.length - 1)) {
            nextBtnShow = false;
          }
      }else{
        Map<String, dynamic> map = {
          'currentIndex' : currentIndex,
          'selectedOptionIndex' : selectedOptionIndex,
          'currentQuestionOption' : widget.userSelectedQuizQuestions[currentIndex].correct_option
        };
        resultRecord.add(map);

        alertText = 'Please select option!';
        alertTextOpacity = 1.0;
      }
      // for next question this becomes again -1
      // because for next question it reset to -1
      selectedOptionIndex = -1;
    });
  }

  // uncomment if use previous button
  //
  // void _previousQuestion() {
  //   setState(() {
  //     userOptionsList.removeLast();
  //     print('userOptions List : $userOptionsList');
  //     resultRecord.removeWhere((element) => element['currentIndex'] == currentIndex);
  //       //change Page
  //       currentIndex--;
  //       carouselController.animateToPage(currentIndex,
  //           duration: Duration(seconds: 1));
  //       //next btn show only when current index < length of questions
  //       if (currentIndex < widget.userSelectedQuizQuestions.length - 1) {
  //         nextBtnShow = true;
  //       }
  //       // dont show prev btn while at first question
  //       if (currentIndex == 0) {
  //         resultRecord.clear();
  //         prevBtnShow = false;
  //       }
  //   });
  //   print(resultRecord);
  // }

// it is called when press finish button
  void _finishButton()async{
    if(selectedOptionIndex != -1 || _remainingMilliseconds == 0){
      _timer!.cancel();
      userOptionsList.add(selectedOptionIndex);
      //print('userOptionsList : $userOptionsList');
      Map<String, dynamic> map = {
        'currentIndex' : currentIndex,
        'selectedOptionIndex' : selectedOptionIndex,
        'currentQuestionOption' : widget.userSelectedQuizQuestions[currentIndex].correct_option
      };
      resultRecord.add(map);

      // go to result screen for showing results of quiz that is played
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
                resultRecord: resultRecord,
                userSelectedQuizQuestions: widget.userSelectedQuizQuestions,
              userOptionsList: userOptionsList
            ),
          )
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    //Questions Screen
    // willPopScope is used for if user tap back button of device
    return WillPopScope(
      onWillPop: ()async{
        // it is used to double click back button for exit app
        if(Navigator.of(context).canPop()){
          return true;
        }else{
          return await doubleTapToExit(context);
        }
      },
        child:!startQuizOption ? Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              leading: InkWell(
                  onTap: (){
                    _timer!.cancel();
                    Navigator.of(context).pop();
                    },
                  child: Icon(
                    Icons.home,
                    color: orange,
                    size: 35,
                  )
              ),
              backgroundColor: bgColor,
              elevation: 0,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                widget.userSelectedQuizQuestions.isEmpty ?
                const Center(
                  child: CircularProgressIndicator(),
                ) :
                timerWidget(),
                Container(
                    child: quizScrollWidget()
                ),
                AnimatedOpacity(
                  opacity: alertTextOpacity,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  child: Text(
                    alertText,
                    style: TextStyle(
                        color: orange,
                        fontSize: 20
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: buildBottomAppBar()
        ) :
        // Welcome Screen-----------------------------------------------------
        Welcome(
          checkStarting: checkStarting,
          startTimer: _startTimer,
        )
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      elevation: 0,
      color: white,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Skip Button---------------------------------------------
            InkWell(
                onTap: () async{
                  skipButtonColor = orange;
                  skipTextColor = white;
                  await Future.delayed(const Duration(milliseconds: 100));
                  _skipQuestion();
                  skipButtonColor = white;
                  skipTextColor = orange;
                  },
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                    decoration: BoxDecoration(
                      color: skipButtonColor,
                      borderRadius: BorderRadius.circular(20),
                      // border: Border.all(width: 2,color: orange),
                      boxShadow:[
                        const BoxShadow(
                            color:Colors.black54,
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(1, 1)
                        ),
                        BoxShadow(
                            color: orange,
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(-1, -1)
                        )
                      ],
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: skipTextColor,
                      ),
                    )
                )
            ),
            //Next Button------------------------------------------
            nextBtnShow ?
            InkWell(
                onTap: () async{
                  buttonColor = orange;
                  buttonTextColor = white;
                  await Future.delayed(const Duration(milliseconds: 100));
                  _nextQuestion();
                  buttonColor = white;
                  buttonTextColor = orange;
                  },
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(20),
                      // border: Border.all(width: 2,color: orange),
                      boxShadow:[
                        const BoxShadow(
                            color:Colors.black54,
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(1, 1)
                        ),
                        BoxShadow(
                            color: orange,
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(-1, -1)
                        )
                      ],
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: buttonTextColor,
                      ),
                    )
                )
            ) :
            //Finish button ---------------------------------------
            InkWell(
                onTap: ()async{
                  buttonColor = orange;
                  buttonTextColor = white;
                  await Future.delayed(const Duration(milliseconds: 100));
                  _finishButton();
                  buttonColor = white;
                  buttonTextColor = orange;
                  },
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2,color: orange),
                      boxShadow:[
                        const BoxShadow(
                            color: Colors.black54,
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(1, 1)
                        ),
                        BoxShadow(
                            color: orange,
                            spreadRadius: 0,
                            blurRadius: 1,
                            offset: const Offset(-1, -1)
                        )
                      ],
                    ),
                    child: Text(
                      'Finish',
                      style: TextStyle(
                        color: buttonTextColor,
                      ),
                    )
                )
            )
          ],
        ),
      ),
    );
  }

  Widget timerWidget(){
    double progress =  1.0 - (_remainingMilliseconds/totalDurationMilliseconds);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 3,
              color: Colors.black54,
              offset: Offset(1,1)
            ),
            BoxShadow(
                spreadRadius: 0,
                blurRadius: 3,
                color: Colors.white,
                offset: Offset(-1,-1)
            )
          ]
        ),
        child: Stack(
          children: [
            LinearProgressIndicator(
              borderRadius: BorderRadius.circular(10),
              value: progress,
              minHeight: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                 alignment: Alignment.centerLeft,
                child: Text(
                  '${(_remainingMilliseconds / 1000).floor()} seconds',
                  style: const TextStyle(
                      color: Colors.black54
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  },
                color: Colors.white,
                icon:  Lottie.asset(Icons8.time,
                  controller: _timerController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget quizScrollWidget(){
    return CarouselSlider.builder(
      itemCount: widget.userSelectedQuizQuestions.length,
      options: CarouselOptions(
        autoPlayInterval: const Duration(milliseconds: 200),
        viewportFraction: 1,
        height: (MediaQuery.of(context).size.height) * 0.6,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          if (scrollDisable) {
            carouselController.animateToPage(
                currentIndex,
                duration: const Duration(milliseconds: 500)
            );
          } else {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
      carouselController: carouselController,
      itemBuilder: (context, index, realIndex) {
        final question = widget.userSelectedQuizQuestions[index];
        return Center(
          child: QuestionCard(
            questionModel: question,
            index: index,
            storeAnswer: storeAnswer,
            answersList: [],
            userOptionsList: [],
            resultScreen: false,
          ),
        );
      },
    );
  }

  void checkStarting() async{
    setState(() {
      if (startQuizOption == true) {
        startQuizOption = false;
        visibleHomeIcon = true;
        bgColor = white;

      } else {
        bgColor = orange;
        visibleHomeIcon = false;
        startQuizOption = true;
      }
      resetAllVariables();
    });
  }

  resetAllVariables(){
    resultRecord.clear();
    prevBtnShow = false;
    nextBtnShow = true;
    selectedOptionIndex = -1;
    currentIndex = 0;
    userOptionsList.clear();
    _remainingMilliseconds = totalDurationMilliseconds;
    //print('reset All Varibales');
  }
  void storeAnswer(int selectedOption, int index){
    selectedOptionIndex = selectedOption;
   // print('you select $selectedOptionIndex index');
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

  void _startTimer() {
    if(_timer != null && _timer!.isActive){
      _timer!.cancel();
    }
    _remainingMilliseconds = totalDurationMilliseconds;
    _updateTimer();
  }

  void _updateTimer() {
    if (_remainingMilliseconds > 0) {
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          _remainingMilliseconds -= 100;
          if (_remainingMilliseconds == 0) {
            timer.cancel(); // Timer is stopped when time is up
            if (currentIndex == widget.userSelectedQuizQuestions.length - 1) {
              _finishButton();
            }else{
              _nextQuestion(); // Automatically click the "Next" button
            }

          }
        });
      });
    }
  }
}
