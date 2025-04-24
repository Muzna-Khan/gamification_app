import 'package:flutter/material.dart';
import 'package:gamification_app/screens/home_screen.dart';
import 'package:gamification_app/screens/questions_screen.dart';
import 'package:gamification_app/screens/result_screen.dart';

import 'data/questions.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {

  var active_screen = "Start Screen";
  List<String> selectedAnswer = [];

  void chooseAnswer(String answers){
    selectedAnswer.add(answers);
    print(selectedAnswer);
    if(selectedAnswer.length == questions.length)
       setState(() {
         active_screen = "Result Screen";
       });
  }

  void switchScreen()
  {
    setState(() {
      active_screen = "Question Screen";
    });
    print("changed");
  }
  void restartQuiz()
  {
    setState(() {
      selectedAnswer = [];
      active_screen = "Question Screen";
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = HomeScreen(StartQuiz: switchScreen,);
    if(active_screen == "Question Screen")
      {
        screenWidget =  QuestionsScreen(onSelectedAnswer: chooseAnswer,);
      }
    if(active_screen == "Result Screen")
    {
      screenWidget = ResultScreen(onRestart: restartQuiz , choosenAnswer: selectedAnswer,);
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gamification App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: screenWidget
    );
  }
}


