import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.StartQuiz});
  final void Function() StartQuiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
            colors: [
              Colors.green,
              Colors.yellow
            ]
        )
      )
      ,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/quiz_logo.png"),
          Text("Guess The Animal",
          style: GoogleFonts.lato(
            fontSize: 23,
            color: Colors.white,
            decoration: TextDecoration.none
          )),
          SizedBox(height: 10,),
          OutlinedButton.icon(
            icon: Icon(CupertinoIcons.arrow_right, color: Colors.white,),
            style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,

          ),onPressed: StartQuiz, label: Text("Start Quiz" , style: GoogleFonts.lato(
            fontSize: 20
          )),

          )
        ],
        ),
      ),
    );
  }
}
