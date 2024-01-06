import 'package:flutter/material.dart';
import 'package:quiz/model/questions_model.dart';
import '../constants/colors.dart';

class QuestionCard extends StatefulWidget {
  final QuestionsModel questionModel;
  final int index;
  final storeAnswer;
  var answersList;
  var userOptionsList;
  //result-screen shows that whether questioned-card is used for result or quiz
  bool resultScreen;
  QuestionCard({
    required this.questionModel,
    required this.index,
    required this.storeAnswer,
    this.answersList,
    this.userOptionsList,
    required this.resultScreen
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> with TickerProviderStateMixin {
  Color optionColor = Colors.yellow;
  bool isSelected = false;
  int? selectedOption;
  Color cardSelectColor = orange;
  Color cardUnselectColor = white;
  Color cardBorderColor = white;
  double cardBorderWidth = 0;


  @override
  void initState() {
    super.initState();
    if ((widget.answersList.length != 0) &&
        (widget.userOptionsList.length != 0)) {
      selectedOption = widget.answersList[widget.index];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(

        color: white,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(50),
            topLeft: Radius.circular(50)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Question ${widget.index + 1}/10',
            style: const TextStyle(
                fontSize: 24,
                color: Colors.black54
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
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
                ]
            ),
            child: Text(
              widget.questionModel.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          (widget.resultScreen) ?

          // if there is Checking Answers
          Expanded(
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 20
                ),
                itemCount: widget.questionModel.options.length,
                itemBuilder: (context, index) {
                  Color optionColor;
                  if (index == widget.answersList[widget.index]) {
                    //print('Correct Answer Color');
                    optionColor = Colors.green;
                  } else if (widget.userOptionsList[widget.index] == index) {
                    optionColor = Colors.red;
                    //print('user Option');
                  } else {
                    //print('Yellow Color');
                    optionColor = Colors.transparent;
                  }
                  return InkWell(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: 200,
                        height: 30,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black54,
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
                            border: Border.all(
                                color: optionColor,
                                width: 2
                            ),
                            color: cardUnselectColor,
                            borderRadius: const BorderRadius.all(Radius.circular(20))
                        ),
                        child: Center(
                          child: Text(
                            widget.questionModel.options.elementAt(index),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: orange
                            ),
                          ),
                        ),
                      )
                  );
                },
              ),
            ),
          )
          // if there is quiz questions---------------------------------------
              : Expanded(
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 20
                ),
                itemCount: widget.questionModel.options.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        setState(() {
                          selectedOption = index;
                          widget.storeAnswer(selectedOption, index);
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: (selectedOption == index) ? Colors
                                      .transparent : Colors.black54,
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: const Offset(1, 1)
                              ),
                              BoxShadow(
                                  color: (selectedOption == index) ? Colors
                                      .transparent : Colors.white,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(-1, -1)
                              )
                            ],
                            border: Border.all(
                                color: (selectedOption == index)
                                    ? orange
                                    : white,
                                width: (selectedOption == index) ? 1 : 0
                            ),
                            color: cardUnselectColor,
                            borderRadius: const BorderRadius.all(Radius.circular(20))
                        ),
                        child: Center(
                          child: Text(
                            widget.questionModel.options.elementAt(index),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: orange
                            ),
                          ),
                        ),
                      )
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}