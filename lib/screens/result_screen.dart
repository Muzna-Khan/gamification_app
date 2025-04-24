import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/questions.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({
    super.key,
    required this.onRestart,
    required this.choosenAnswer,
  });

  final void Function() onRestart;
  final List<String> choosenAnswer;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];
    for (int i = 0; i < choosenAnswer.length; i++) {
      summary.add({
        "question_index": i,
        "question": questions[i].text,
        "correct_answer": questions[i].correctAnswer,
        "user_answer": choosenAnswer[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numOfTotalQuestions = questions.length;
    final numOfCorrectQuestions = summaryData
        .where((data) => data["user_answer"] == data["correct_answer"])
        .length;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green, Colors.yellow],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 65),
              Text(
                "You answered $numOfCorrectQuestions out of $numOfTotalQuestions questions correctly!",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: summaryData.map((data) {
                      final isCorrect =
                          data["user_answer"] == data["correct_answer"];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${(data["question_index"] as int) + 1}. ${(data["question"] as String)}",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "You Selected: ${(data["user_answer"])}",
                              style: GoogleFonts.lato(
                                color: isCorrect ? Colors.blue : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Correct Answer: ${(data["correct_answer"])}",
                              style: GoogleFonts.lato(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onRestart,
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: Text(
                  "Restart Quiz",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),

                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
