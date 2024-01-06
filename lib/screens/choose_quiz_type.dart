import 'package:flutter/material.dart';
import 'package:quiz/constants/colors.dart';
import 'package:quiz/constants/db_helper.dart';
import 'package:quiz/screens/home.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import '../model/questions_model.dart';
import '../widgets/button.dart';

class ChooseQuizType extends StatefulWidget {
  const ChooseQuizType({super.key});

  @override
  State<ChooseQuizType> createState() => _ChooseQuizTypeState();
}

class _ChooseQuizTypeState extends State<ChooseQuizType> {
  // Names of Quiz will store in this list---Ex: computer, gk, flutter, science
  Future<List<Map<String, dynamic>>>? quizTypeList;
  // All Types/Quiz Questions List of QuestionsModel
  List<QuestionsModel> allQuestionsList = [];
  //Quiz Question which user want from the quiz names
  List<QuestionsModel> userSelectedQuizQuestions = [];
  //user selected quiz name stored in this list
  String userInputedQuiz = '';
  
  var quizTypes = {'General Knowledge', 'Computer', 'Science', 'Flutter'};

  bool showLoading = false;

  //Variables for Animation
  double bottomContainerPadding = 0;

  @override
  void initState() {
    super.initState();
    // I empty this because after playing quiz there is already data in this list
    // fetch quiz types from database
    fetchQuizTypes();
  }

  fetchQuizTypes() async {
    quizTypeList = DatabaseHelper.instance.getQuizName();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).canPop()) {
          return true;
        } else {
          return await doubleTapToExit(context);
        }
      },
      child:  Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: orange,
          ),
          body: Container(
            color: orange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              color: orange,
                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black54,
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(1, 1)
                                ),
                                BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(-1, -1)
                                )
                              ]
                            ),
                            child: Center(
                                child: Text(
                                  'Let\'s play quiz',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 30,
                                    shadows: const [
                                      Shadow(
                                        color: Colors.black54,
                                        blurRadius: 2,
                                        offset: Offset(1, 1)
                                      )
                                    ]
                                  ),
                                  )
                            ),
                          ),
                          const Align(
                            alignment: Alignment.topRight,
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assets/images/garlands.png'),
                                backgroundColor: Colors.transparent,
                                maxRadius: 30,
                              )
                          )
                        ],
                      ),
                    ),
                    ),
                Expanded(
                  flex: 2,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    padding: const EdgeInsets.all(0),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                     decoration: BoxDecoration(
                       color: white,
                       boxShadow: const [
                         BoxShadow(
                             color: Colors.black54,
                             spreadRadius: 0,
                             blurRadius: 2,
                         )
                       ],
                       borderRadius: const BorderRadius.only(
                           topLeft: Radius.circular(50),
                         topRight: Radius.circular(50)
                       ),

                     ),
                      child: FutureBuilder(
                        future: quizTypeList,
                        builder:
                            (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator(color: orange,));
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error : ${snapshot.error}',style: TextStyle(color: orange),),
                            );
                          } else if (snapshot.hasData) {
                            return GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                mainAxisSpacing: 0
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data![index]['quiz_type'];
                                return InkWell(
                                  onTap: (){

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Button(
                                      onTap: tapOnCard,
                                      data: data,
                                      text: quizTypes.elementAt(index),
                                    )
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Text('No data available',style: TextStyle(color: orange),),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

// fetch all questions as a QuestionsModel
  Future<void> fetchQuestions() async {
    Database? db = await DatabaseHelper.instance.database;
    String tableName = 'questions';
    List<Map<String, dynamic>> questionsMap = await db!.query(tableName);
    setState(() {
      allQuestionsList =
          questionsMap.map((e) => QuestionsModel.fromMap(e)).toList();
    });
  }

//filter all questions into user selected quiz type questions
  Future<void> setSelectedQuizQuestionsOnly() async {
    for (int i = 0; i < allQuestionsList.length; i++) {
      String question = allQuestionsList[i].question;
      var options = allQuestionsList[i].options;
      int correctOption = allQuestionsList[i].correct_option;
      String quiz_type = allQuestionsList[i].quiz_type;

      if (allQuestionsList[i].quiz_type == userInputedQuiz) {
        userSelectedQuizQuestions.add(QuestionsModel(
            question: question,
            options: options,
            correct_option: correctOption,
            quiz_type: quiz_type));
      }
    }
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

  tapOnCard(var data)async{
    setState(() {
      showLoading = true;
    });
    userInputedQuiz = data;
    await fetchQuestions(); //fetch all questions from database
    userSelectedQuizQuestions.clear();
    await setSelectedQuizQuestionsOnly(); // filter only user inputed type questions
    Get.to(()=> Home(userSelectedQuizQuestions: userSelectedQuizQuestions),
      transition: Transition.downToUp
    );
    setState(() {
      showLoading = false;
    });

  }
}
