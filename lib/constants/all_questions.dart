
import 'package:quiz/constants/db_helper.dart';
import 'package:quiz/model/questions_model.dart';

// this file is only making my sqlite database file  which is named as questions.db
class AllQuestions{
  Future<void> addQuestion()async {

    //general knowledge
    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'general_knowledge',
          question: 'What is the capital of France?',
          options: ['Rome', 'Madrid', 'Paris', 'Berlin'],
          correct_option: 2
      )
    );
    await DatabaseHelper.instance.insertInitialData(
        QuestionsModel(
            quiz_type: 'general_knowledge',
            question: 'Who painted the Mona Lisa?',
            options: ['Leonardo da Vinci', 'Pablo Picasso', 'Vincent van Gogh', 'Michelangelo'],
            correct_option: 0
        )
    );
    await DatabaseHelper.instance.insertInitialData(
        QuestionsModel(
            quiz_type: 'general_knowledge',
            question: 'What is the largest ocean on Earth?',
            options: ['Atlantic Ocean', 'Pacific Ocean', 'Indian Ocean', 'Arctic Ocean'],
            correct_option: 1
        )
    );
    await DatabaseHelper.instance.insertInitialData(
        QuestionsModel(
            quiz_type: 'general_knowledge',
            question: 'Which planet is known as the Red Planet?',
            options: ['Saturn', 'Jupiter', 'Venus', 'Mars'],
            correct_option: 3
        )
    );
    await DatabaseHelper.instance.insertInitialData(
        QuestionsModel(
            quiz_type: 'general_knowledge',
            question: 'What is the tallest mountain in the world?',
            options: ['Mount Everest', 'K2', 'Kangchenjunga', 'Lhotse'],
            correct_option: 0
        )
    );
    await DatabaseHelper.instance.insertInitialData(
        QuestionsModel(
            quiz_type: 'general_knowledge',
            question: 'Who wrote Romeo and Juliet?',
            options: ['Mark Twain', 'Charles Dickens','William Shakespeare', 'Jane Austen'],
            correct_option: 2
        )
    );await DatabaseHelper.instance.insertInitialData(
        QuestionsModel(
            quiz_type: 'general_knowledge',
            question: 'What is the largest organ in the human body?',
            options: ['Lungs', 'Liver', 'Heart', 'Skin'],
            correct_option: 3
        )
    );
    await DatabaseHelper.instance.insertInitialData(
        QuestionsModel(
            quiz_type: 'general_knowledge',
            question: 'Who discovered penicillin?',
            options: ['Louis Pasteur', 'Alexander Fleming', 'Marie Curie', 'Isaac Newton'],
            correct_option: 1
        )
    );
    await DatabaseHelper.instance.insertInitialData(
        QuestionsModel(
            quiz_type: 'general_knowledge',
            question: 'What is the currency of Japan?',
            options: ['Korean Won', 'Chinese Yuan', 'Japanese Yen', 'Thai Baht'],
            correct_option: 2
        )
    );
    await DatabaseHelper.instance.insertInitialData(
        QuestionsModel(
            quiz_type: 'general_knowledge',
            question: 'Which country is known as the Land of the Rising Sun?',
            options: ['Japan', 'China', 'South Korea', 'Vietnam'],
            correct_option: 0
        )
    );



    //-------------------------------------------------------------------------
    //computer science
    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'computer',
        question: 'What does CPU stand for?',
        options: ['Central Processing Unit', 'Computer Personal Unit', 'Central Process Unit', 'Central Processor Unit'],
        correct_option: 0,
      ),
    );
    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'computer',
        question: 'Which company developed the first computer mouse?',
        options: ['Apple', 'Microsoft', 'IBM', 'Xerox'],
        correct_option: 3,
      ),
    );
    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'computer',
        question: 'What is the largest computer network in the world?',
        options: ['Local Area Network (LAN)', 'Metropolitan Area Network (MAN)', 'Wide Area Network (WAN)', 'Internet'],
        correct_option: 3,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'computer',
        question: 'Who is known as the father of computer science?',
        options: ['Alan Turing', 'Bill Gates', 'Steve Jobs', 'Tim Berners-Lee'],
        correct_option: 0,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'computer',
        question: 'What is the main function of an operating system?',
        options: ['Running applications', 'Printing documents', 'Managing hardware and software', 'Browsing the web'],
        correct_option: 2,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'computer',
        question: 'Which programming language is often used for artificial intelligence and machine learning?',
        options: ['Java', 'C++', 'Python', 'JavaScript'],
        correct_option: 2,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'computer',
        question: 'Who is the co-founder of Microsoft?',
        options: ['Bill Gates', 'Steve Jobs', 'Mark Zuckerberg', 'Larry Page'],
        correct_option: 0,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'computer',
        question: 'What is the standard file extension for a Python source code file?',
        options: ['.exe', '.py', '.doc', '.html'],
        correct_option: 1,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'computer',
        question: 'Which company developed the Java programming language?',
        options: ['Apple', 'Microsoft', 'IBM', 'Sun Microsystems'],
        correct_option: 3,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'computer',
        question: 'What is the basic unit of digital information storage?',
        options: ['Byte', 'Bit', 'Nibble', 'Megabyte'],
        correct_option: 1,
      ),
    );




    //-----------------------------------------------------------------------------
    //Science Questions
    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'science',
        question: 'What is the chemical symbol for gold?',
        options: ['Ag', 'Au', 'Fe', 'Hg'],
        correct_option: 1,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'science',
        question: 'Which planet is known as the Red Planet?',
        options: ['Mars', 'Venus', 'Jupiter', 'Saturn'],
        correct_option: 0,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'science',
        question: 'What is the chemical symbol for water?',
        options: ['O2', 'CO2', 'H2O', 'N2'],
        correct_option: 2,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'science',
        question: 'What is the atomic number of carbon?',
        options: ['12', '14', '6', '8'],
        correct_option: 2,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'science',
        question: 'Which gas do plants absorb from the atmosphere?',
        options: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
        correct_option: 1,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'science',
        question: 'What is the largest organ in the human body?',
        options: ['Heart', 'Brain', 'Skin', 'Liver'],
        correct_option: 2,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'science',
        question: 'Which gas makes up the majority of the Earth’s atmosphere?',
        options: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Argon'],
        correct_option: 2,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'science',
        question: 'What is the chemical symbol for iron?',
        options: ['Fe', 'Ag', 'Au', 'Hg'],
        correct_option: 0,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'science',
        question: 'Which planet is known as the Blue Planet?',
        options: ['Mars', 'Venus', 'Earth', 'Saturn'],
        correct_option: 2,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'science',
        question: 'What is the chemical symbol for oxygen?',
        options: ['O2', 'CO2', 'H2O', 'N2'],
        correct_option: 0,
      ),
    );





    //---------------------------------------------------------------------
    //Flutter Questions
    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'flutter',
        question: 'What is the main programming language used to develop Flutter apps?',
        options: ['Java', 'C#', 'Dart', 'Kotlin'],
        correct_option: 2,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'flutter',
        question: 'What widget is used to create a button in Flutter?',
        options: ['Text', 'Button', 'Container', 'ElevatedButton'],
        correct_option: 3,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'flutter',
        question: 'Which command is used to create a new Flutter project from the command line?',
        options: ['flutter start', 'flutter init', 'flutter create', 'flutter new'],
        correct_option: 2,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'flutter',
        question: 'What is the purpose of the `main` function in a Flutter app?',
        options: ['To display the app name', 'To handle HTTP requests', 'To define the app structure', 'To start the app and run the `MyApp` widget'],
        correct_option: 3,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'flutter',
        question: 'Which package is used for state management in Flutter?',
        options: ['http', 'sqflite', 'provider', 'shared_preferences'],
        correct_option: 2,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'flutter',
        question: 'What is the name of the file where Flutter app configuration is defined?',
        options: ['main.dart', 'config.yaml', 'pubspec.yaml', 'app.json'],
        correct_option: 2,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'flutter',
        question: 'Which class is the root widget for a Flutter app?',
        options: ['App', 'Root', 'Main', 'MyApp'],
        correct_option: 3,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'flutter',
        question: 'How do you add padding around a widget in Flutter?',
        options: ['Using the `padding` property', 'Using the `margin` property', 'Using the `border` property', 'Using the `spacing` property'],
        correct_option: 0,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'flutter',
        question: 'What is the primary function of the `Scaffold` widget in Flutter?',
        options: ['Display a drawer menu', 'Provide a bottom navigation bar', 'Define the overall structure of the app', 'Display a floating action button (FAB)'],
        correct_option: 2,
      ),
    );

    await DatabaseHelper.instance.insertInitialData(
      QuestionsModel(
        quiz_type: 'flutter',
        question: 'Which widget is used to create a list of scrollable items in Flutter?',
        options: ['Container', 'ListView', 'Text', 'Card'],
        correct_option: 1,
      ),
    );

  }
}