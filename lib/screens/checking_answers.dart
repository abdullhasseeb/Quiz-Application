import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quiz/constants/colors.dart';
import 'package:quiz/widgets/question_card.dart';

class CheckAnswersScreen extends StatefulWidget {
  final userSelectedQuizQuestions;
  final userOptionsList;

  CheckAnswersScreen({
    required this.userSelectedQuizQuestions,
    required this.userOptionsList
});

  @override
  State<CheckAnswersScreen> createState() => _CheckAnswersScreenState();
}

class _CheckAnswersScreenState extends State<CheckAnswersScreen> {

  CarouselController carouselController = CarouselController();

  //Variables Contains Index
  int currentIndex = 0;
  int selectedOptionIndex = -1;
  int currentQuestionIndex = 0;

  //Actual Answers Index List to check by user inputted index
  var answersList = [];

  //this variable used for stop scrolling the carousel slider
  bool scrollDisable = true;

  //variable for next, finish and prev buttons
  bool nextBtnShow = true;
  bool prevBtnShow = false;
  bool finishBtnShow = false;
  Color nextButtonColor = white;
  Color nextButtonTextColor = orange;
  Color prevButtonColor = white;
  Color prevButtonTextColor = orange;


  //variables for showing resultText
  String resultText = '';
  double resultTextOpacity = 0.0;
  bool isTextVisible = false;

  void _nextQuestion() {
    setState(() {
      // if 2 < 10 then pass and if 10 < 10 go to else Part
        if (currentIndex < widget.userSelectedQuizQuestions.length-1) {
          //change Page
          currentIndex++;
          carouselController.animateToPage(currentIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutQuart
          );
          //prev btn show when there is 2nd question or above
          if (currentIndex > 0) {
            prevBtnShow = true;
          }
          //next btn not show when there is last question
          if (!(currentIndex < widget.userSelectedQuizQuestions.length - 1)) {
            nextBtnShow = false;
          }
          resultTextOpacity = 0.0;
        }
      });
    }

  void _previousQuestion() {
    setState(() {
      //change Page
      currentIndex--;
      carouselController.animateToPage(currentIndex,
          duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuart
      );
      //next btn show only when current index < length of questions
      if (currentIndex < widget.userSelectedQuizQuestions.length - 1) {
        nextBtnShow = true;
      }
      // dont show prev btn while at first question
      if (currentIndex == 0) {
        prevBtnShow = false;
      }
      resultTextOpacity = 0.0;
    });
  }

  @override
  void initState() {
    super.initState();
   // print('userOptions Length : ${widget.userOptionsList.length}');
    for(int i = 0; i < widget.userSelectedQuizQuestions.length; i++){
      answersList.add(widget.userSelectedQuizQuestions[i].correct_option);
      showRightOrNot(0);
    }
    //print('Asnwers List $answersList');
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: white,
            leading: IconButton(
               icon: const Icon(Icons.keyboard_backspace),
              color: orange,
              onPressed: (){
                 Navigator.pop(context);
              },

            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.userSelectedQuizQuestions.isEmpty
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : CarouselSlider.builder(
                itemCount: widget.userSelectedQuizQuestions.length,
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: (MediaQuery.of(context).size.height) * 0.6,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    showRightOrNot(index);
                    if (scrollDisable) {
                      // uncomment if we want scroll with finger
                      // carouselController.animateToPage(
                      //     currentIndex,
                      //     duration: Duration(milliseconds: 500)
                      // );
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
                      storeAnswer: (){},
                      answersList: answersList,
                      userOptionsList: widget.userOptionsList,
                      resultScreen: true,
                    ),
                  );
                },
              ),
              AnimatedOpacity(
                opacity: resultTextOpacity,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                child: Text(
                    resultText,
                  style: TextStyle(
                    color: orange,
                    fontSize: 20
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: buildBottomAppBar()
      ),
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
                prevBtnShow
                    ? InkWell(
                    onTap: () async{
                      prevButtonColor = orange;
                      prevButtonTextColor = white;
                      setState(() {});
                      await Future.delayed(const Duration(milliseconds: 100));
                      _previousQuestion();
                      setState(() {});
                      prevButtonColor = white;
                      prevButtonTextColor = orange;
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                        decoration: BoxDecoration(
                          color: prevButtonColor,
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
                          'Previous',
                          style: TextStyle(
                            color: prevButtonTextColor,
                          ),
                        )
                    )
                )
                    : const SizedBox(),
                nextBtnShow
                    ? InkWell(
                    onTap: () async{
                      nextButtonColor = orange;
                      nextButtonTextColor = white;
                      setState(() {});
                      await Future.delayed(const Duration(milliseconds: 100));
                      _nextQuestion();
                      setState(() {});
                      nextButtonColor = white;
                      nextButtonTextColor = orange;
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                        decoration: BoxDecoration(
                          color: nextButtonColor,
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
                            color: nextButtonTextColor,
                          ),
                        )
                    )
                )
                    : const SizedBox()
              ],
            ),
          ),
        );
  }

  void storeAnswer(int selectedOption, int index){
    currentQuestionIndex = index;
    selectedOptionIndex = selectedOption;
  //  print('you select $selectedOptionIndex index');
  }

  showRightOrNot(int index){
    setState(() {
      if(answersList[index] == widget.userOptionsList[index]){
        //print('${answersList[index]} == ${widget.userOptionsList[index]}');
        resultText = 'Your answer is Right ✓';
        resultTextOpacity = 1.0;
      }  else if(widget.userOptionsList[index] == -1){
        resultText = 'No answer provided';
        resultTextOpacity = 1.0;
      } else{
        resultText = 'Your answer is wrong X';
        resultTextOpacity = 1.0;
      }
    });
  }
}
